// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_movie_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OnboardingMovieStore on _OnboardingMovieStore, Store {
  Computed<bool>? _$canProceedComputed;

  @override
  bool get canProceed => (_$canProceedComputed ??= Computed<bool>(
    () => super.canProceed,
    name: '_OnboardingMovieStore.canProceed',
  )).value;
  Computed<int>? _$selectedCountComputed;

  @override
  int get selectedCount => (_$selectedCountComputed ??= Computed<int>(
    () => super.selectedCount,
    name: '_OnboardingMovieStore.selectedCount',
  )).value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??= Computed<bool>(
    () => super.hasError,
    name: '_OnboardingMovieStore.hasError',
  )).value;
  Computed<List<int>>? _$selectedMovieIdsComputed;

  @override
  List<int> get selectedMovieIds =>
      (_$selectedMovieIdsComputed ??= Computed<List<int>>(
        () => super.selectedMovieIds,
        name: '_OnboardingMovieStore.selectedMovieIds',
      )).value;

  late final _$moviesAtom = Atom(
    name: '_OnboardingMovieStore.movies',
    context: context,
  );

  @override
  ObservableList<Movie> get movies {
    _$moviesAtom.reportRead();
    return super.movies;
  }

  @override
  set movies(ObservableList<Movie> value) {
    _$moviesAtom.reportWrite(value, super.movies, () {
      super.movies = value;
    });
  }

  late final _$selectedMoviesAtom = Atom(
    name: '_OnboardingMovieStore.selectedMovies',
    context: context,
  );

  @override
  ObservableList<Movie> get selectedMovies {
    _$selectedMoviesAtom.reportRead();
    return super.selectedMovies;
  }

  @override
  set selectedMovies(ObservableList<Movie> value) {
    _$selectedMoviesAtom.reportWrite(value, super.selectedMovies, () {
      super.selectedMovies = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_OnboardingMovieStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_OnboardingMovieStore.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$currentPageAtom = Atom(
    name: '_OnboardingMovieStore.currentPage',
    context: context,
  );

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$hasMorePagesAtom = Atom(
    name: '_OnboardingMovieStore.hasMorePages',
    context: context,
  );

  @override
  bool get hasMorePages {
    _$hasMorePagesAtom.reportRead();
    return super.hasMorePages;
  }

  @override
  set hasMorePages(bool value) {
    _$hasMorePagesAtom.reportWrite(value, super.hasMorePages, () {
      super.hasMorePages = value;
    });
  }

  late final _$loadMoviesAsyncAction = AsyncAction(
    '_OnboardingMovieStore.loadMovies',
    context: context,
  );

  @override
  Future<void> loadMovies() {
    return _$loadMoviesAsyncAction.run(() => super.loadMovies());
  }

  late final _$retryAsyncAction = AsyncAction(
    '_OnboardingMovieStore.retry',
    context: context,
  );

  @override
  Future<void> retry() {
    return _$retryAsyncAction.run(() => super.retry());
  }

  late final _$saveFavoriteMoviesAsyncAction = AsyncAction(
    '_OnboardingMovieStore.saveFavoriteMovies',
    context: context,
  );

  @override
  Future<void> saveFavoriteMovies() {
    return _$saveFavoriteMoviesAsyncAction.run(
      () => super.saveFavoriteMovies(),
    );
  }

  late final _$_OnboardingMovieStoreActionController = ActionController(
    name: '_OnboardingMovieStore',
    context: context,
  );

  @override
  void toggleMovieSelection(Movie movie) {
    final _$actionInfo = _$_OnboardingMovieStoreActionController.startAction(
      name: '_OnboardingMovieStore.toggleMovieSelection',
    );
    try {
      return super.toggleMovieSelection(movie);
    } finally {
      _$_OnboardingMovieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearError() {
    final _$actionInfo = _$_OnboardingMovieStoreActionController.startAction(
      name: '_OnboardingMovieStore.clearError',
    );
    try {
      return super.clearError();
    } finally {
      _$_OnboardingMovieStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
movies: ${movies},
selectedMovies: ${selectedMovies},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
currentPage: ${currentPage},
hasMorePages: ${hasMorePages},
canProceed: ${canProceed},
selectedCount: ${selectedCount},
hasError: ${hasError},
selectedMovieIds: ${selectedMovieIds}
    ''';
  }
}
