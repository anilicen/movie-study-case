// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SplashStore on _SplashStore, Store {
  Computed<bool>? _$isReadyComputed;

  @override
  bool get isReady => (_$isReadyComputed ??= Computed<bool>(
    () => super.isReady,
    name: '_SplashStore.isReady',
  )).value;

  late final _$isLoadingMoviesAtom = Atom(
    name: '_SplashStore.isLoadingMovies',
    context: context,
  );

  @override
  bool get isLoadingMovies {
    _$isLoadingMoviesAtom.reportRead();
    return super.isLoadingMovies;
  }

  @override
  set isLoadingMovies(bool value) {
    _$isLoadingMoviesAtom.reportWrite(value, super.isLoadingMovies, () {
      super.isLoadingMovies = value;
    });
  }

  late final _$isLoadingGenresAtom = Atom(
    name: '_SplashStore.isLoadingGenres',
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

  late final _$moviesLoadedAtom = Atom(
    name: '_SplashStore.moviesLoaded',
    context: context,
  );

  @override
  bool get moviesLoaded {
    _$moviesLoadedAtom.reportRead();
    return super.moviesLoaded;
  }

  @override
  set moviesLoaded(bool value) {
    _$moviesLoadedAtom.reportWrite(value, super.moviesLoaded, () {
      super.moviesLoaded = value;
    });
  }

  late final _$genresLoadedAtom = Atom(
    name: '_SplashStore.genresLoaded',
    context: context,
  );

  @override
  bool get genresLoaded {
    _$genresLoadedAtom.reportRead();
    return super.genresLoaded;
  }

  @override
  set genresLoaded(bool value) {
    _$genresLoadedAtom.reportWrite(value, super.genresLoaded, () {
      super.genresLoaded = value;
    });
  }

  late final _$preloadDataAsyncAction = AsyncAction(
    '_SplashStore.preloadData',
    context: context,
  );

  @override
  Future<void> preloadData() {
    return _$preloadDataAsyncAction.run(() => super.preloadData());
  }

  late final _$_preloadMoviesAsyncAction = AsyncAction(
    '_SplashStore._preloadMovies',
    context: context,
  );

  @override
  Future<void> _preloadMovies() {
    return _$_preloadMoviesAsyncAction.run(() => super._preloadMovies());
  }

  late final _$_preloadGenresAsyncAction = AsyncAction(
    '_SplashStore._preloadGenres',
    context: context,
  );

  @override
  Future<void> _preloadGenres() {
    return _$_preloadGenresAsyncAction.run(() => super._preloadGenres());
  }

  @override
  String toString() {
    return '''
isLoadingMovies: ${isLoadingMovies},
isLoadingGenres: ${isLoadingGenres},
moviesLoaded: ${moviesLoaded},
genresLoaded: ${genresLoaded},
isReady: ${isReady}
    ''';
  }
}
