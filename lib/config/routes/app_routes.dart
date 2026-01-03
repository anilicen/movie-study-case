import 'package:flutter/material.dart';
import 'package:movie_study_case/presentation/screens/splash/splash_screen.dart';
import 'package:movie_study_case/presentation/screens/onboarding_movie_selection/onboarding_movie_selection_screen.dart';
import 'package:movie_study_case/presentation/screens/onboarding_genre_selection/onboarding_genre_selection_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String movieOnboarding = '/movie-onboarding';
  static const String genreOnboarding = '/genre-onboarding';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      movieOnboarding: (context) => const OnboardingMovieSelectionScreen(),
      genreOnboarding: (context) => const OnboardingGenreSelectionScreen(),
    };
  }
}
