import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_study_case/domain/entities/movie.dart';
import 'package:movie_study_case/presentation/widgets/curved_movie_card.dart';
import 'package:movie_study_case/presentation/widgets/primary_container.dart';

import 'package:movie_study_case/core/di/service_locator.dart';
import 'package:movie_study_case/core/services/image_preloader_service.dart';

class InfiniteCurvedCarousel extends StatefulWidget {
  final List<Movie> movies;
  final Function(Movie) onMovieSelected;
  final List<int> selectedMovieIds;
  final VoidCallback onLoadMore;

  const InfiniteCurvedCarousel({
    super.key,
    required this.movies,
    required this.onMovieSelected,
    required this.selectedMovieIds,
    required this.onLoadMore,
  });

  @override
  State<InfiniteCurvedCarousel> createState() => _InfiniteCurvedCarouselState();
}

class _InfiniteCurvedCarouselState extends State<InfiniteCurvedCarousel> {
  PageController? _pageController;
  final int _initialPage = 0;
  double _currentPage = 0.0;
  final ImagePreloaderService _imagePreloaderService =
      getIt<ImagePreloaderService>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = MediaQuery.of(context).size.width;
    if (width <= 0) return;

    final fraction = (180.w + 16.w) / width;

    if (_pageController != null) {
      if ((_pageController!.viewportFraction - fraction).abs() < 0.001) return;
      _pageController!.removeListener(_onScroll);
      _pageController!.dispose();
    }

    int initialIndex = _initialPage;
    if (_currentPage > 0) {
      initialIndex = _currentPage.round();
    }

    _pageController = PageController(
      viewportFraction: fraction,
      initialPage: initialIndex,
    );
    _pageController!.addListener(_onScroll);

    if (_pageController!.hasClients) {
      _currentPage = _pageController!.page!;
    } else {
      _currentPage = initialIndex.toDouble();
    }
  }

  void _onScroll() {
    if (_pageController?.hasClients ?? false) {
      setState(() {
        _currentPage = _pageController!.page ?? _initialPage.toDouble();
      });

      _preloadNextImages();
    }
  }

  void _preloadNextImages() {
    final int currentIndex = _currentPage.round();
    final int prefetchRange = 5;

    for (int i = 1; i <= prefetchRange; i++) {
      final int nextIndex = currentIndex + i;
      if (nextIndex < widget.movies.length) {
        final movie = widget.movies[nextIndex];
        final url = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';

        _imagePreloaderService.preloadImage(context, url);
      }
    }
  }

  @override
  void dispose() {
    _pageController?.removeListener(_onScroll);
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_pageController == null) return const SizedBox.shrink();

    return PageView.builder(
      controller: _pageController,
      itemCount: 100000,
      physics: const BouncingScrollPhysics(),
      pageSnapping: false,
      itemBuilder: (context, index) {
        if (index >= widget.movies.length - 4) {
          widget.onLoadMore();
          return Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: PrimaryContainer(
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
          );
        }

        final Movie movie = widget.movies[index];

        final double percentage = (index - _currentPage);
        final isSelected = widget.selectedMovieIds.contains(movie.id);

        return Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 180.w,
            height: 252.h,
            child: GestureDetector(
              onTap: () => widget.onMovieSelected(movie),
              child: CurvedMovieCard(
                percentage: percentage,
                child: PrimaryContainer(
                  isActive: isSelected,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Warped Poster Image
                      MeshCurvedImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        percentage: percentage,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
