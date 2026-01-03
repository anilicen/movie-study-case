import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';
import 'package:movie_study_case/core/di/service_locator.dart';
import 'package:movie_study_case/presentation/stores/onboarding_genre_store/onboarding_genre_store.dart';
import 'package:movie_study_case/presentation/widgets/primary_button.dart';
import 'package:movie_study_case/presentation/widgets/primary_circular_container.dart';

class OnboardingGenreSelectionScreen extends StatefulWidget {
  const OnboardingGenreSelectionScreen({super.key});

  @override
  State<OnboardingGenreSelectionScreen> createState() =>
      _OnboardingGenreSelectionScreenState();
}

class _OnboardingGenreSelectionScreenState
    extends State<OnboardingGenreSelectionScreen> {
  late final OnboardingGenreStore store;

  @override
  void initState() {
    super.initState();
    store = getIt<OnboardingGenreStore>();
    store.loadGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (store.hasError && store.genres.isEmpty) {
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

          if (store.isLoading && store.genres.isEmpty) {
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
                        'Choose your 2 favorite genres',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.kWhite,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 58),
                    child: const Text(
                      'Thank you 👍',
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.kWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                const SizedBox(height: 24),

                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 45,
                          mainAxisSpacing: 24,
                        ),
                    itemCount: store.genres.length,
                    itemBuilder: (context, index) {
                      final genre = store.genres[index];
                      final posterPath = store.genrePosters[genre.id];

                      return Observer(
                        builder: (_) => GestureDetector(
                          onTap: () => store.toggleGenreSelection(genre),
                          child: Column(
                            children: [
                              Expanded(
                                child: PrimaryCircularContainer(
                                  isActive: store.isGenreSelected(genre),
                                  child: posterPath != null
                                      ? ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/w500$posterPath',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                            placeholder: (context, url) =>
                                                const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                            errorWidget:
                                                (context, url, error) => Center(
                                                  child: Text(
                                                    genre.name,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                          ),
                                        )
                                      : Center(
                                          child: Text(
                                            genre.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                genre.name,
                                style: const TextStyle(
                                  color: AppColors.kWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                PrimaryButton(
                  text: "Continue",
                  isActive: store.canProceed,
                  isLoading: false,
                  onPressed: store.canProceed
                      ? () async {
                          try {
                            await store.saveFavoriteGenres();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Favorite genres saved!'),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: ${e.toString()}'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
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
