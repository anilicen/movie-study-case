import 'package:get_it/get_it.dart';
import 'package:movie_study_case/data/datasources/remote/tmdb_api_service.dart';
import 'package:movie_study_case/data/datasources/local/local_data_source.dart';
import 'package:movie_study_case/data/repositories/movie_repository_impl.dart';
import 'package:movie_study_case/domain/repositories/i_movie_repository.dart';
import 'package:movie_study_case/domain/usecases/get_popular_movies.dart';
import 'package:movie_study_case/domain/usecases/get_genres.dart';
import 'package:movie_study_case/domain/usecases/save_favorite_movies.dart';
import 'package:movie_study_case/domain/usecases/save_favorite_genres.dart';
import 'package:movie_study_case/presentation/stores/onboarding_movie_store/onboarding_movie_store.dart';
import 'package:movie_study_case/presentation/stores/onboarding_genre_store/onboarding_genre_store.dart';
import 'package:movie_study_case/presentation/stores/splash_store/splash_store.dart';
import 'package:movie_study_case/presentation/stores/home_store/home_store.dart';
import 'package:movie_study_case/core/services/image_preloader_service.dart';

import 'package:movie_study_case/core/network/dio_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Network
  getIt.registerLazySingleton<DioService>(() => DioService());
  getIt.registerLazySingleton<Dio>(() => getIt<DioService>().dio);

  // Data Sources
  getIt.registerLazySingleton<TmdbApiService>(() => TmdbApiService(getIt()));
  getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSource(getIt()));

  // Repositories
  getIt.registerLazySingleton<IMovieRepository>(
    () => MovieRepositoryImpl(getIt(), getIt()),
  );

  // UseCases
  getIt.registerLazySingleton(() => GetPopularMoviesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetGenresUseCase(getIt()));
  getIt.registerLazySingleton(() => SaveFavoriteMoviesUseCase(getIt()));
  getIt.registerLazySingleton(() => SaveFavoriteGenresUseCase(getIt()));

  // Services
  getIt.registerLazySingleton<ImagePreloaderService>(
    () => ImagePreloaderService(),
  );

  // Stores
  getIt.registerFactory(
    () => OnboardingMovieStore(
      getIt<GetPopularMoviesUseCase>(),
      getIt<SaveFavoriteMoviesUseCase>(),
    ),
  );

  getIt.registerFactory(
    () => OnboardingGenreStore(
      getIt<GetGenresUseCase>(),
      getIt<SaveFavoriteGenresUseCase>(),
      getIt<IMovieRepository>(),
    ),
  );

  getIt.registerFactory(
    () => SplashStore(
      getIt<GetPopularMoviesUseCase>(),
      getIt<GetGenresUseCase>(),
      getIt<IMovieRepository>(),
    ),
  );

  getIt.registerFactory(
    () => HomeStore(getIt<IMovieRepository>(), getIt<LocalDataSource>()),
  );
}
