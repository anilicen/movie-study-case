import 'package:mobx/mobx.dart';
import 'package:movie_study_case/domain/entities/genre.dart';
import 'package:movie_study_case/domain/usecases/get_genres.dart';
import 'package:movie_study_case/domain/usecases/save_favorite_genres.dart';
import 'package:movie_study_case/domain/repositories/i_movie_repository.dart';

part 'onboarding_genre_store.g.dart';

class OnboardingGenreStore = _OnboardingGenreStore with _$OnboardingGenreStore;

abstract class _OnboardingGenreStore with Store {
  final GetGenresUseCase _getGenres;
  final SaveFavoriteGenresUseCase _saveFavoriteGenres;
  final IMovieRepository _repository;

  _OnboardingGenreStore(
    this._getGenres,
    this._saveFavoriteGenres,
    this._repository,
  );

  @observable
  ObservableList<Genre> genres = ObservableList<Genre>();

  @observable
  ObservableList<Genre> selectedGenres = ObservableList<Genre>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  ObservableMap<int, String> genrePosters = ObservableMap<int, String>();

  @computed
  bool get canProceed => selectedGenres.length >= 2;

  @computed
  int get selectedCount => selectedGenres.length;

  @computed
  bool get hasError => errorMessage != null;

  @computed
  List<int> get selectedGenreIds => selectedGenres.map((g) => g.id).toList();

  @action
  Future<void> loadGenres() async {
    if (isLoading) return;

    isLoading = true;
    errorMessage = null;

    try {
      final loadedGenres = await _getGenres();
      genres.clear();
      genres.addAll(loadedGenres);

      for (final genre in loadedGenres) {
        try {
          final movies = await _repository.getMoviesByGenre(genre.id, page: 1);
          if (movies.isNotEmpty && movies.first.posterPath.isNotEmpty) {
            genrePosters[genre.id] = movies.first.posterPath;
          }
        } catch (e) {
          continue;
        }
      }
    } catch (e) {
      errorMessage = 'Failed to load genres. Please try again.';
    } finally {
      isLoading = false;
    }
  }

  @action
  void toggleGenreSelection(Genre genre) {
    if (isGenreSelected(genre)) {
      selectedGenres.removeWhere((g) => g.id == genre.id);
    } else {
      selectedGenres.add(genre);
    }
  }

  @action
  void clearError() {
    errorMessage = null;
  }

  @action
  Future<void> retry() async {
    errorMessage = null;
    await loadGenres();
  }

  bool isGenreSelected(Genre genre) {
    return selectedGenres.any((g) => g.id == genre.id);
  }

  @action
  Future<void> saveFavoriteGenres() async {
    try {
      await _saveFavoriteGenres(selectedGenreIds);
    } catch (e) {
      errorMessage = 'Failed to save favorite genres';
      rethrow;
    }
  }
}
