// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_genre_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OnboardingGenreStore on _OnboardingGenreStore, Store {
  Computed<bool>? _$canProceedComputed;

  @override
  bool get canProceed => (_$canProceedComputed ??= Computed<bool>(
    () => super.canProceed,
    name: '_OnboardingGenreStore.canProceed',
  )).value;
  Computed<int>? _$selectedCountComputed;

  @override
  int get selectedCount => (_$selectedCountComputed ??= Computed<int>(
    () => super.selectedCount,
    name: '_OnboardingGenreStore.selectedCount',
  )).value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??= Computed<bool>(
    () => super.hasError,
    name: '_OnboardingGenreStore.hasError',
  )).value;
  Computed<List<int>>? _$selectedGenreIdsComputed;

  @override
  List<int> get selectedGenreIds =>
      (_$selectedGenreIdsComputed ??= Computed<List<int>>(
        () => super.selectedGenreIds,
        name: '_OnboardingGenreStore.selectedGenreIds',
      )).value;

  late final _$genresAtom = Atom(
    name: '_OnboardingGenreStore.genres',
    context: context,
  );

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

  late final _$selectedGenresAtom = Atom(
    name: '_OnboardingGenreStore.selectedGenres',
    context: context,
  );

  @override
  ObservableList<Genre> get selectedGenres {
    _$selectedGenresAtom.reportRead();
    return super.selectedGenres;
  }

  @override
  set selectedGenres(ObservableList<Genre> value) {
    _$selectedGenresAtom.reportWrite(value, super.selectedGenres, () {
      super.selectedGenres = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_OnboardingGenreStore.isLoading',
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
    name: '_OnboardingGenreStore.errorMessage',
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

  late final _$genrePostersAtom = Atom(
    name: '_OnboardingGenreStore.genrePosters',
    context: context,
  );

  @override
  ObservableMap<int, String> get genrePosters {
    _$genrePostersAtom.reportRead();
    return super.genrePosters;
  }

  @override
  set genrePosters(ObservableMap<int, String> value) {
    _$genrePostersAtom.reportWrite(value, super.genrePosters, () {
      super.genrePosters = value;
    });
  }

  late final _$loadGenresAsyncAction = AsyncAction(
    '_OnboardingGenreStore.loadGenres',
    context: context,
  );

  @override
  Future<void> loadGenres() {
    return _$loadGenresAsyncAction.run(() => super.loadGenres());
  }

  late final _$retryAsyncAction = AsyncAction(
    '_OnboardingGenreStore.retry',
    context: context,
  );

  @override
  Future<void> retry() {
    return _$retryAsyncAction.run(() => super.retry());
  }

  late final _$saveFavoriteGenresAsyncAction = AsyncAction(
    '_OnboardingGenreStore.saveFavoriteGenres',
    context: context,
  );

  @override
  Future<void> saveFavoriteGenres() {
    return _$saveFavoriteGenresAsyncAction.run(
      () => super.saveFavoriteGenres(),
    );
  }

  late final _$_OnboardingGenreStoreActionController = ActionController(
    name: '_OnboardingGenreStore',
    context: context,
  );

  @override
  void toggleGenreSelection(Genre genre) {
    final _$actionInfo = _$_OnboardingGenreStoreActionController.startAction(
      name: '_OnboardingGenreStore.toggleGenreSelection',
    );
    try {
      return super.toggleGenreSelection(genre);
    } finally {
      _$_OnboardingGenreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearError() {
    final _$actionInfo = _$_OnboardingGenreStoreActionController.startAction(
      name: '_OnboardingGenreStore.clearError',
    );
    try {
      return super.clearError();
    } finally {
      _$_OnboardingGenreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
genres: ${genres},
selectedGenres: ${selectedGenres},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
genrePosters: ${genrePosters},
canProceed: ${canProceed},
selectedCount: ${selectedCount},
hasError: ${hasError},
selectedGenreIds: ${selectedGenreIds}
    ''';
  }
}
