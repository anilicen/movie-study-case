import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_study_case/domain/usecases/get_popular_movies.dart';
import 'package:movie_study_case/domain/usecases/get_genres.dart';
import 'package:movie_study_case/domain/repositories/i_movie_repository.dart';
import 'package:movie_study_case/core/services/remote_config_service.dart';

part 'splash_store.g.dart';

class SplashStore = _SplashStore with _$SplashStore;

abstract class _SplashStore with Store {
  final GetPopularMoviesUseCase _getPopularMovies;
  final GetGenresUseCase _getGenres;
  final IMovieRepository _repository;
  final RemoteConfigService _remoteConfigService;

  _SplashStore(
    this._getPopularMovies,
    this._getGenres,
    this._repository,
    this._remoteConfigService,
  );

  @observable
  bool isLoadingMovies = false;

  @observable
  bool isLoadingGenres = false;

  @observable
  bool moviesLoaded = false;

  @observable
  bool genresLoaded = false;

  @computed
  bool get isReady => moviesLoaded && genresLoaded;

  @action
  Future<void> preloadData() async {
    // Initialize Remote Config (A/B Test Variant)
    await _remoteConfigService.fetchAndActivate();

    await Future.wait([_preloadMovies(), _preloadGenres()]);
  }

  @action
  Future<void> _preloadMovies() async {
    isLoadingMovies = true;
    try {
      await _getPopularMovies(page: 1);
      moviesLoaded = true;
    } catch (e) {
      // Silently fail, user can retry on onboarding screen
      moviesLoaded = true;
    } finally {
      isLoadingMovies = false;
    }
  }

  @action
  Future<void> _preloadGenres() async {
    isLoadingGenres = true;
    try {
      final genres = await _getGenres();

      // Preload representative movies for each genre in parallel
      await Future.wait(
        genres.map((genre) async {
          try {
            await _repository.getMoviesByGenre(genre.id, page: 1);
          } catch (e) {
            // Ignore errors for individual genres
          }
        }),
      );

      genresLoaded = true;
    } catch (e) {
      // Silently fail
      genresLoaded = true;
    } finally {
      isLoadingGenres = false;
    }
  }

  Future<void> preloadGenreImages(BuildContext context) async {
    try {
      final genres = await _repository.getGenres();
      final preloadingFutures = <Future<void>>[];

      for (final genre in genres) {
        preloadingFutures.add(() async {
          try {
            final movies = await _repository.getMoviesByGenre(
              genre.id,
              page: 1,
            );
            final moviesToPreload = movies.take(9).toList();

            final imageFutures = moviesToPreload
                .where((movie) => movie.posterPath.isNotEmpty)
                .map((movie) {
                  final imageUrl =
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}';
                  return precacheImage(
                    CachedNetworkImageProvider(imageUrl),
                    context,
                  );
                });

            await Future.wait(imageFutures);
          } catch (e) {
            // Skip if fails
          }
        }());
      }

      await Future.wait(preloadingFutures);
    } catch (e) {
      // Silently fail
    }
  }
}
