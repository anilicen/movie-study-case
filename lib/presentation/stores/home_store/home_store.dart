import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:movie_study_case/domain/entities/movie.dart';
import 'package:movie_study_case/domain/entities/genre.dart';
import 'package:movie_study_case/domain/repositories/i_movie_repository.dart';
import 'package:movie_study_case/data/datasources/local/local_data_source.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final IMovieRepository _repository;
  final LocalDataSource _localDataSource;

  _HomeStore(this._repository, this._localDataSource);

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollController chipScrollController = ScrollController();

  bool _isProgrammaticScroll = false;

  @observable
  bool isLoadingFavorites = false;

  @observable
  bool isLoadingGenres = false;

  @observable
  ObservableList<Movie> favoriteMovies = ObservableList<Movie>();

  @observable
  ObservableList<Genre> genres = ObservableList<Genre>();

  @observable
  ObservableMap<int, List<Movie>> moviesByGenre =
      ObservableMap<int, List<Movie>>();

  @observable
  int selectedGenreIndex = 0;

  @observable
  String searchQuery = '';

  @computed
  Genre? get selectedGenre =>
      genres.isNotEmpty && selectedGenreIndex < genres.length
      ? genres[selectedGenreIndex]
      : null;

  @action
  Future<void> initialize() async {
    await Future.wait([loadFavoriteMovies(), loadGenresAndMovies()]);
    _setupScrollListener();
  }

  @action
  Future<void> loadFavoriteMovies() async {
    isLoadingFavorites = true;
    try {
      final favoriteIds = await _localDataSource.getFavoriteMovies();
      final movies = await _repository.getPopularMovies(page: 1);

      favoriteMovies.clear();
      favoriteMovies.addAll(
        movies.where((movie) => favoriteIds.contains(movie.id)).toList(),
      );
    } catch (e) {
      // Handle error
    } finally {
      isLoadingFavorites = false;
    }
  }

  @action
  Future<void> loadGenresAndMovies() async {
    isLoadingGenres = true;
    try {
      final genreList = await _repository.getGenres();
      genres.clear();
      genres.addAll(genreList);

      for (var genre in genres) {
        try {
          final movies = await _repository.getMoviesByGenre(genre.id, page: 1);
          moviesByGenre[genre.id] = movies.take(9).toList();
        } catch (e) {
          moviesByGenre[genre.id] = [];
        }
      }
    } catch (e) {
      // Handle error
    } finally {
      isLoadingGenres = false;
    }
  }

  void _setupScrollListener() {
    itemPositionsListener.itemPositions.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isProgrammaticScroll) return;

    final positions = itemPositionsListener.itemPositions.value;

    if (positions.isNotEmpty) {
      final visibleItems = positions.where((position) {
        return position.itemLeadingEdge < 1.0 &&
            position.itemTrailingEdge > 0.0;
      }).toList();

      if (visibleItems.isNotEmpty) {
        visibleItems.sort(
          (a, b) => a.itemLeadingEdge.compareTo(b.itemLeadingEdge),
        );
        final topMostItem = visibleItems.first;

        if (selectedGenreIndex != topMostItem.index) {
          setSelectedGenreIndex(topMostItem.index);
        }
      }
    }
  }

  @action
  void setSelectedGenreIndex(int index) {
    selectedGenreIndex = index;

    if (chipScrollController.hasClients && genres.isNotEmpty) {
      final chipWidth = 120.0;
      final targetOffset = index * chipWidth;
      final viewportWidth = chipScrollController.position.viewportDimension;

      final centeredOffset =
          targetOffset - (viewportWidth / 2) + (chipWidth / 2);

      chipScrollController.animateTo(
        centeredOffset.clamp(
          chipScrollController.position.minScrollExtent,
          chipScrollController.position.maxScrollExtent,
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @action
  Future<void> scrollToGenre(int index) async {
    if (index >= 0 && index < genres.length) {
      _isProgrammaticScroll = true;

      if (itemScrollController.isAttached) {
        await itemScrollController.scrollTo(
          index: index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0.0,
        );

        await Future.delayed(const Duration(milliseconds: 100));
        _isProgrammaticScroll = false;

        setSelectedGenreIndex(index);
      }
    }
  }

  @action
  void updateSearchQuery(String query) {
    searchQuery = query;
  }

  void dispose() {
    chipScrollController.dispose();
  }
}
