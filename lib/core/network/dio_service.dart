import 'package:dio/dio.dart';
import 'package:movie_study_case/core/constants/api_constants.dart';

class DioService {
  late final Dio _dio;

  DioService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: {'Authorization': ApiConstants.apiKey, 'Content-Type': 'application/json'},
      ),
    );
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Dio get dio => _dio;
}
