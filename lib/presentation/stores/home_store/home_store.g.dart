// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  Computed<Genre?>? _$selectedGenreComputed;

  @override
  Genre? get selectedGenre => (_$selectedGenreComputed ??= Computed<Genre?>(
    () => super.selectedGenre,
    name: '_HomeStore.selectedGenre',
  )).value;

  late final _$isLoadingFavoritesAtom = Atom(
    name: '_HomeStore.isLoadingFavorites',
    context: context,
  );

  @override
  bool get isLoadingFavorites {
    _$isLoadingFavoritesAtom.reportRead();
    return super.isLoadingFavorites;
  }

  @override
  set isLoadingFavorites(bool value) {
    _$isLoadingFavoritesAtom.reportWrite(value, super.isLoadingFavorites, () {
      super.isLoadingFavorites = value;
    });
  }

  late final _$isLoadingGenresAtom = Atom(
    name: '_HomeStore.isLoadingGenres',
    context: context,
  );

  @override
  bool get isLoadingGenres {
    _$isLoadingGenresAtom.reportRead();
    return super.isLoadingGenres;
  }

  @override
  set isLoadingGenres(bool value) {
    _$isLoadingGenresAtom.reportWrite(value, super.isLoadingGenres, () {
      super.isLoadingGenres = value;
    });
  }

  late final _$favoriteMoviesAtom = Atom(
    name: '_HomeStore.favoriteMovies',
    context: context,
  );

  @override
  ObservableList<Movie> get favoriteMovies {
    _$favoriteMoviesAtom.reportRead();
    return super.favoriteMovies;
  }

  @override
  set favoriteMovies(ObservableList<Movie> value) {
    _$favoriteMoviesAtom.reportWrite(value, super.favoriteMovies, () {
      super.favoriteMovies = value;
    });
  }

  late final _$genresAtom = Atom(name: '_HomeStore.genres', context: context);

  @override
  ObservableList<Genre> get genres {
    _$genresAtom.reportRead();
    return super.genres;
  }

  @override
  set genres(ObservableList<Genre> value) {
    _$genresAtom.reportWrite(value, super.genres, () {
      super.genres = value;
    });
  }

  late final _$moviesByGenreAtom = Atom(
    name: '_HomeStore.moviesByGenre',
    context: context,
  );

  @override
  ObservableMap<int, List<Movie>> get moviesByGenre {
    _$moviesByGenreAtom.reportRead();
    return super.moviesByGenre;
  }

  @override
  set moviesByGenre(ObservableMap<int, List<Movie>> value) {
    _$moviesByGenreAtom.reportWrite(value, super.moviesByGenre, () {
      super.moviesByGenre = value;
    });
  }

  late final _$selectedGenreIndexAtom = Atom(
    name: '_HomeStore.selectedGenreIndex',
    context: context,
  );

  @override
  int get selectedGenreIndex {
    _$selectedGenreIndexAtom.reportRead();
    return super.selectedGenreIndex;
  }

  @override
  set selectedGenreIndex(int value) {
    _$selectedGenreIndexAtom.reportWrite(value, super.selectedGenreIndex, () {
      super.selectedGenreIndex = value;
    });
  }

  late final _$searchQueryAtom = Atom(
    name: '_HomeStore.searchQuery',
    context: context,
  );

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$initializeAsyncAction = AsyncAction(
    '_HomeStore.initialize',
    context: context,
  );

  @override
  Future<void> initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  late final _$loadFavoriteMoviesAsyncAction = AsyncAction(
    '_HomeStore.loadFavoriteMovies',
    context: context,
  );

  @override
  Future<void> loadFavoriteMovies() {
    return _$loadFavoriteMoviesAsyncAction.run(
      () => super.loadFavoriteMovies(),
    );
  }

  late final _$loadGenresAndMoviesAsyncAction = AsyncAction(
    '_HomeStore.loadGenresAndMovies',
    context: context,
  );

  @override
  Future<void> loadGenresAndMovies() {
    return _$loadGenresAndMoviesAsyncAction.run(
      () => super.loadGenresAndMovies(),
    );
  }

  late final _$scrollToGenreAsyncAction = AsyncAction(
    '_HomeStore.scrollToGenre',
    context: context,
  );

  @override
  Future<void> scrollToGenre(int index) {
    return _$scrollToGenreAsyncAction.run(() => super.scrollToGenre(index));
  }

  late final _$_HomeStoreActionController = ActionController(
    name: '_HomeStore',
    context: context,
  );

  @override
  void setSelectedGenreIndex(int index) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
      name: '_HomeStore.setSelectedGenreIndex',
    );
    try {
      return super.setSelectedGenreIndex(index);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSearchQuery(String query) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
      name: '_HomeStore.updateSearchQuery',
    );
    try {
      return super.updateSearchQuery(query);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoadingFavorites: ${isLoadingFavorites},
isLoadingGenres: ${isLoadingGenres},
favoriteMovies: ${favoriteMovies},
genres: ${genres},
moviesByGenre: ${moviesByGenre},
selectedGenreIndex: ${selectedGenreIndex},
searchQuery: ${searchQuery},
selectedGenre: ${selectedGenre}
    ''';
  }
}
