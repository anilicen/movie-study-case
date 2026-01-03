import 'package:get_it/get_it.dart';
import 'package:movie_study_case/data/datasources/remote/tmdb_api_service.dart';
import 'package:movie_study_case/data/repositories/movie_repository_impl.dart';
import 'package:movie_study_case/domain/repositories/i_movie_repository.dart';
import 'package:movie_study_case/domain/usecases/get_popular_movies.dart';
import 'package:movie_study_case/domain/usecases/get_genres.dart';
import 'package:movie_study_case/presentation/stores/onboarding_movie_store/onboarding_movie_store.dart';
import 'package:movie_study_case/core/services/image_preloader_service.dart';

import 'package:movie_study_case/core/network/dio_service.dart';
import 'package:dio/dio.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  // Network
  getIt.registerLazySingleton<DioService>(() => DioService());
  getIt.registerLazySingleton<Dio>(() => getIt<DioService>().dio);

  // Data Sources
  getIt.registerLazySingleton<TmdbApiService>(() => TmdbApiService(getIt()));

  // Repositories
  getIt.registerLazySingleton<IMovieRepository>(
    () => MovieRepositoryImpl(getIt()),
  );

  // UseCases
  getIt.registerLazySingleton(() => GetPopularMoviesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetGenresUseCase(getIt()));

  // Services
  getIt.registerLazySingleton<ImagePreloaderService>(
    () => ImagePreloaderService(),
  );

  // Stores
  getIt.registerFactory(() => OnboardingMovieStore(getIt()));
}
