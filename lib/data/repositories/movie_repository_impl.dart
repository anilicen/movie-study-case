import 'package:movie_study_case/core/error/exceptions.dart';
import 'package:movie_study_case/domain/entities/genre.dart';
import 'package:movie_study_case/domain/entities/movie.dart';
import 'package:movie_study_case/domain/repositories/i_movie_repository.dart';
import 'package:movie_study_case/data/datasources/remote/tmdb_api_service.dart';
import 'package:movie_study_case/data/datasources/local/local_data_source.dart';
import 'package:movie_study_case/data/models/movie_model.dart';
import 'package:movie_study_case/data/models/genre_model.dart';
import 'package:movie_study_case/data/mappers/mappers.dart';

class MovieRepositoryImpl implements IMovieRepository {
  final TmdbApiService apiService;
  final LocalDataSource localDataSource;

  // In-memory cache
  final Map<int, List<Movie>> _moviesCache = {};
  List<Genre>? _genresCache;
  final Map<int, Map<int, List<Movie>>> _moviesByGenreCache = {};

  MovieRepositoryImpl(this.apiService, this.localDataSource);

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    // Return cached data if available
    if (_moviesCache.containsKey(page)) {
      return _moviesCache[page]!;
    }

    try {
      final response = await apiService.getPopularMovies(page: page);
      final List<dynamic> results = response['results'];
      final movies = results
          .map((json) => MovieModel.fromJson(json).toEntity())
          .toList();

      // Cache the results
      _moviesCache[page] = movies;
      return movies;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Unexpected Error');
    }
  }

  @override
  Future<List<Genre>> getGenres() async {
    // Return cached data if available
    if (_genresCache != null) {
      return _genresCache!;
    }

    try {
      final response = await apiService.getGenres();
      final List<dynamic> genres = response['genres'];
      final genreList = genres
          .map((json) => GenreModel.fromJson(json).toEntity())
          .toList();

      // Cache the results
      _genresCache = genreList;
      return genreList;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Unexpected Error');
    }
  }

  @override
  Future<List<Movie>> getMoviesByGenre(int genreId, {int page = 1}) async {
    // Return cached data if available
    if (_moviesByGenreCache.containsKey(genreId) &&
        _moviesByGenreCache[genreId]!.containsKey(page)) {
      return _moviesByGenreCache[genreId]![page]!;
    }

    try {
      final response = await apiService.getMoviesByGenre(genreId, page: page);
      final List<dynamic> results = response['results'];
      final movies = results
          .map((json) => MovieModel.fromJson(json).toEntity())
          .toList();

      // Cache the results
      _moviesByGenreCache[genreId] ??= {};
      _moviesByGenreCache[genreId]![page] = movies;
      return movies;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Unexpected Error');
    }
  }

  @override
  Future<void> saveFavoriteMovies(List<int> movieIds) async {
    try {
      await localDataSource.saveFavoriteMovies(movieIds);
    } catch (e) {
      throw ServerException(message: 'Failed to save favorite movies');
    }
  }

  @override
  Future<void> saveFavoriteGenres(List<int> genreIds) async {
    try {
      await localDataSource.saveFavoriteGenres(genreIds);
    } catch (e) {
      throw ServerException(message: 'Failed to save favorite genres');
    }
  }
}
