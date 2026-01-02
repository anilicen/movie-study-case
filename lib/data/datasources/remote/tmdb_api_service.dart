import 'package:dio/dio.dart';
import 'package:movie_study_case/core/error/exceptions.dart';

class TmdbApiService {
  final Dio dio;

  TmdbApiService(this.dio);

  Future<Map<String, dynamic>> getPopularMovies({int page = 1}) async {
    try {
      final response = await dio.get('/movie/popular', queryParameters: {'page': page});
      return response.data;
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Unknown Error');
    }
  }

  Future<Map<String, dynamic>> getGenres() async {
    try {
      final response = await dio.get('/genre/movie/list');
      return response.data;
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Unknown Error');
    }
  }

  Future<Map<String, dynamic>> getMoviesByGenre(int genreId, {int page = 1}) async {
    try {
      final response = await dio.get(
        '/discover/movie',
        queryParameters: {'with_genres': genreId, 'page': page, 'sort_by': 'popularity.desc'},
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerException(message: e.message ?? 'Unknown Error');
    }
  }
}
