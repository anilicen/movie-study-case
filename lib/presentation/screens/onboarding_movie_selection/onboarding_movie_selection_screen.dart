import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';
import 'package:movie_study_case/core/di/service_locator.dart';
import 'package:movie_study_case/presentation/stores/onboarding_movie_store/onboarding_movie_store.dart';
import 'package:movie_study_case/presentation/widgets/primary_button.dart';
import 'package:movie_study_case/presentation/widgets/infinite_curved_carousel.dart';

class OnboardingMovieSelectionScreen extends StatefulWidget {
  const OnboardingMovieSelectionScreen({super.key});

  @override
  State<OnboardingMovieSelectionScreen> createState() =>
      _OnboardingMovieSelectionScreenState();
}

class _OnboardingMovieSelectionScreenState
    extends State<OnboardingMovieSelectionScreen> {
  late final OnboardingMovieStore store;

  @override
  void initState() {
    super.initState();

    store = OnboardingMovieStore(getIt());
    store.loadMovies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (store.hasError && store.movies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(store.errorMessage ?? 'An error occurred'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: store.retry,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (store.isLoading && store.movies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 38),
                if (!store.canProceed)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.kWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Choose your 3 favorite movies',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.kWhite,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                else
                  const Text(
                    'Continue to next step 👉',
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.kWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Expanded(
                  child: OverflowBox(
                    maxWidth: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    child: Transform.translate(
                      offset: const Offset(-20, 0),
                      child: InfiniteCurvedCarousel(
                        movies: store.movies,
                        selectedMovieIds: store.selectedMovieIds,
                        onMovieSelected: store.toggleMovieSelection,
                        onLoadMore: store.loadMovies,
                      ),
                    ),
                  ),
                ),

                PrimaryButton(
                  text: "Continue",
                  isActive: store.canProceed,
                  isLoading: false,
                  onPressed: store.canProceed
                      ? () {
                          // Navigate to next screen
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Selection Confirmed!'),
                            ),
                          );
                        }
                      : null,
                ),
                const SizedBox(height: 45),
              ],
            ),
          );
        },
      ),
    );
  }
}
