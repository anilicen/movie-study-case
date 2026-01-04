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
      final imagesToPreload = <String>{};

      // 0. Preload 'Popular Movies' for 'Onboarding Movie Selection'
      // Fetch from repo (cached)
      try {
        final popularMovies = await _repository.getPopularMovies(page: 1);
        for (final movie in popularMovies.take(6)) {
          if (movie.posterPath.isNotEmpty) {
            imagesToPreload.add(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            );
          }
        }
      } catch (e) {
        // Ignore
      }

      for (int i = 0; i < genres.length; i++) {
        final genre = genres[i];
        try {
          // Movies are already cached in repository by _preloadGenres
          final movies = await _repository.getMoviesByGenre(genre.id, page: 1);

          if (movies.isEmpty) continue;

          // 1. Preload the FIRST movie poster for 'Onboarding Genre Selection'
          if (movies.first.posterPath.isNotEmpty) {
            imagesToPreload.add(
              'https://image.tmdb.org/t/p/w500${movies.first.posterPath}',
            );
          }

          // 2. Preload the FIRST CATEGORY (9 movies) for 'Home Screen'
          // Assuming the first genre in the list is the first category shown
          if (i == 0) {
            final homeMovies = movies.take(9);
            for (final movie in homeMovies) {
              if (movie.posterPath.isNotEmpty) {
                imagesToPreload.add(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                );
              }
            }
          }
        } catch (e) {
          // Ignore errors
        }
      }

      final preloadingFutures = imagesToPreload.map((url) {
        return precacheImage(CachedNetworkImageProvider(url), context);
      });

      await Future.wait(preloadingFutures);
    } catch (e) {
      // Silently fail
    }
  }
}
