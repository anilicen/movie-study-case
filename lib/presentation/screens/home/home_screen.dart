import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';
import 'package:movie_study_case/core/di/service_locator.dart';
import 'package:movie_study_case/presentation/stores/home_store/home_store.dart';
import 'package:movie_study_case/presentation/widgets/primary_circular_container.dart';
import 'package:movie_study_case/presentation/widgets/primary_chips.dart';
import 'package:movie_study_case/presentation/widgets/primary_container.dart';
import 'package:movie_study_case/presentation/widgets/gradient_shadow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeStore store;

  @override
  void initState() {
    super.initState();
    store = getIt<HomeStore>();
    store.initialize();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBlack,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Observer(
                builder: (_) {
                  if (store.isLoadingGenres || store.isLoadingFavorites) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 26),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'For You ⭐️',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kWhite,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        height: 80,
                        child: Observer(
                          builder: (_) => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: store.favoriteMovies.length,
                            itemBuilder: (context, index) {
                              final movie = store.favoriteMovies[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: PrimaryCircularContainer(
                                  isActive: false,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      placeholder: (context, url) =>
                                          const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Divider(color: AppColors.kWhite, thickness: 1),

                      const SizedBox(height: 16),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Movies 🎬',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kWhite,
                          ),
                        ),
                      ),

                      // Search Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: TextField(
                          onChanged: store.updateSearchQuery,
                          style: const TextStyle(color: AppColors.kBlack),
                          decoration: InputDecoration(
                            hintText: 'Search movies...',
                            hintStyle: TextStyle(
                              color: AppColors.kDarkGray.withOpacity(0.5),
                            ),
                            filled: true,
                            fillColor: AppColors.kWhite,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 9,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 20,
                              color: AppColors.kDarkGray,
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 40,
                              minHeight: 40,
                            ),
                          ),
                        ),
                      ),

                      // Genre Chips
                      SizedBox(
                        height: 44,
                        child: ListView.builder(
                          controller: store.chipScrollController,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: store.genres.length,
                          itemBuilder: (context, index) {
                            final genre = store.genres[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Observer(
                                builder: (_) {
                                  final isSelected =
                                      store.selectedGenreIndex == index;

                                  return PrimaryChips(
                                    label: genre.name,
                                    isSelected: isSelected,
                                    onTap: () => store.scrollToGenre(index),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Category Feed
                      Expanded(
                        child: Observer(
                          builder: (_) => ScrollablePositionedList.builder(
                            itemScrollController: store.itemScrollController,
                            itemPositionsListener: store.itemPositionsListener,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: store.genres.length,
                            itemBuilder: (context, genreIndex) {
                              final genre = store.genres[genreIndex];
                              final movies =
                                  store.moviesByGenre[genre.id] ?? [];

                              return Container(
                                margin: const EdgeInsets.only(bottom: 32),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      genre.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.kWhite,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 12,
                                            mainAxisSpacing: 12,
                                            childAspectRatio: 0.7,
                                          ),
                                      itemCount: movies.length,
                                      itemBuilder: (context, movieIndex) {
                                        final movie = movies[movieIndex];
                                        return Column(
                                          children: [
                                            Expanded(
                                              child: PrimaryContainer(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    placeholder:
                                                        (
                                                          context,
                                                          url,
                                                        ) => const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(
                                                              Icons.error,
                                                            ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GradientShadow(height: 30, isTop: false),
            ),
          ],
        ),
      ),
    );
  }
}
