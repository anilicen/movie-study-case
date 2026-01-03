import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_study_case/domain/usecases/get_popular_movies.dart';
import 'package:movie_study_case/domain/usecases/get_genres.dart';
import 'package:movie_study_case/domain/repositories/i_movie_repository.dart';

part 'splash_store.g.dart';

class SplashStore = _SplashStore with _$SplashStore;

abstract class _SplashStore with Store {
  final GetPopularMoviesUseCase _getPopularMovies;
  final GetGenresUseCase _getGenres;
  final IMovieRepository _repository;

  _SplashStore(this._getPopularMovies, this._getGenres, this._repository);

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

      // Preload representative movies for each genre
      for (final genre in genres) {
        try {
          await _repository.getMoviesByGenre(genre.id, page: 1);
        } catch (e) {
          continue;
        }
      }
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

      // Preload first movie poster for each genre
      for (final genre in genres) {
        try {
          final movies = await _repository.getMoviesByGenre(genre.id, page: 1);
          if (movies.isNotEmpty && movies.first.posterPath.isNotEmpty) {
            final imageUrl =
                'https://image.tmdb.org/t/p/w500${movies.first.posterPath}';
            await precacheImage(CachedNetworkImageProvider(imageUrl), context);
          }
        } catch (e) {
          continue; // Skip if fails
        }
      }
    } catch (e) {
      // Silently fail
    }
  }
}
