import 'package:movie_study_case/core/error/exceptions.dart';
import 'package:movie_study_case/domain/entities/genre.dart';
import 'package:movie_study_case/domain/entities/movie.dart';
import 'package:movie_study_case/domain/repositories/i_movie_repository.dart';
import 'package:movie_study_case/data/datasources/remote/tmdb_api_service.dart';
import 'package:movie_study_case/data/datasources/local/local_data_source.dart';
import 'package:movie_study_case/data/models/genre_model.dart';
import 'package:movie_study_case/data/mappers/mappers.dart';

import 'package:movie_study_case/data/models/movie_v2_dto.dart';
import 'package:movie_study_case/data/mappers/movie_v2_mapper.dart';

class MovieRepositoryImpl implements IMovieRepository {
  final TmdbApiService apiService;
  final LocalDataSource localDataSource;

  // In-memory cache
  final Map<int, List<Movie>> _moviesCache = {};
  List<Genre>? _genresCache;
  final Map<int, Map<int, List<Movie>>> _moviesByGenreCache = {};

  MovieRepositoryImpl(this.apiService, this.localDataSource);

  /// --------------------------------------------------------------------------
  /// ARCHITECTURE TEST: API V2 SIMULATOR
  /// Simulates a breaking change in the JSON structure.
  /// --------------------------------------------------------------------------
  Map<String, dynamic> _simulateApiV2(Map<String, dynamic> v1Json) {
    final List<dynamic> oldList = v1Json['results'] ?? [];

    final List<Map<String, dynamic>> newItemList = oldList.map((item) {
      return {
        'movie_id': item['id'],
        'headline': item['title'],
        'cover_image_url': item['poster_path'],
        'background_image_url': item['backdrop_path'],
      };
    }).toList();

    return {
      'meta': {'status': 200},
      'data': {'items': newItemList},
    };
  }

  /// --------------------------------------------------------------------------

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    if (_moviesCache.containsKey(page)) {
      return _moviesCache[page]!;
    }

    try {
      final v1Response = await apiService.getPopularMovies(page: page);

      final v2Response = _simulateApiV2(v1Response);

      final dataObj = v2Response['data'] as Map<String, dynamic>;
      final List<dynamic> items = dataObj['items'];

      final movies = items
          .map((json) => MovieV2Dto.fromJson(json).toEntity())
          .toList();

      _moviesCache[page] = movies;
      return movies;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: 'Unexpected Error: $e');
    }
  }

  @override
  Future<List<Genre>> getGenres() async {
    if (_genresCache != null) {
      return _genresCache!;
    }

    try {
      final response = await apiService.getGenres();
      final List<dynamic> genres = response['genres'];
      final genreList = genres
          .map((json) => GenreModel.fromJson(json).toEntity())
          .toList();

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
    if (_moviesByGenreCache.containsKey(genreId) &&
        _moviesByGenreCache[genreId]!.containsKey(page)) {
      return _moviesByGenreCache[genreId]![page]!;
    }

    try {
      final v1Response = await apiService.getMoviesByGenre(genreId, page: page);

      // Simulate receiving V2 structure from Backend
      final v2Response = _simulateApiV2(v1Response);

      // Parse using V2 DTOs
      final dataObj = v2Response['data'] as Map<String, dynamic>;
      final List<dynamic> items = dataObj['items'];

      final movies = items
          .map((json) => MovieV2Dto.fromJson(json).toEntity())
          .toList();

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
