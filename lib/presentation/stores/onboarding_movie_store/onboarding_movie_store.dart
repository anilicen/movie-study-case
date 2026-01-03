import 'package:mobx/mobx.dart';
import 'package:movie_study_case/domain/entities/movie.dart';
import 'package:movie_study_case/domain/usecases/get_popular_movies.dart';
import 'package:movie_study_case/domain/usecases/save_favorite_movies.dart';

part 'onboarding_movie_store.g.dart';

class OnboardingMovieStore = _OnboardingMovieStore with _$OnboardingMovieStore;

abstract class _OnboardingMovieStore with Store {
  final GetPopularMoviesUseCase _getPopularMovies;
  final SaveFavoriteMoviesUseCase _saveFavoriteMovies;

  _OnboardingMovieStore(this._getPopularMovies, this._saveFavoriteMovies);

  @observable
  ObservableList<Movie> movies = ObservableList<Movie>();

  @observable
  ObservableList<Movie> selectedMovies = ObservableList<Movie>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  int currentPage = 1;

  @observable
  bool hasMorePages = true;

  @computed
  bool get canProceed => selectedMovies.length >= 3;

  @computed
  int get selectedCount => selectedMovies.length;

  @computed
  bool get hasError => errorMessage != null;

  @computed
  List<int> get selectedMovieIds => selectedMovies.map((m) => m.id).toList();

  @action
  Future<void> loadMovies() async {
    if (isLoading || !hasMorePages) return;

    isLoading = true;
    errorMessage = null;

    try {
      final newMovies = await _getPopularMovies(page: currentPage);

      if (newMovies.isEmpty) {
        hasMorePages = false;
      } else {
        movies.addAll(newMovies);
        currentPage++;
      }
    } catch (e) {
      errorMessage = 'Failed to load movies. Please try again.';
    } finally {
      isLoading = false;
    }
  }

  @action
  void toggleMovieSelection(Movie movie) {
    if (isMovieSelected(movie)) {
      selectedMovies.removeWhere((m) => m.id == movie.id);
    } else {
      selectedMovies.add(movie);
    }
  }

  @action
  void clearError() {
    errorMessage = null;
  }

  @action
  Future<void> retry() async {
    errorMessage = null;
    await loadMovies();
  }

  bool isMovieSelected(Movie movie) {
    return selectedMovies.any((m) => m.id == movie.id);
  }

  @action
  Future<void> saveFavoriteMovies() async {
    try {
      await _saveFavoriteMovies(selectedMovieIds);
    } catch (e) {
      errorMessage = 'Failed to save favorite movies';
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'selectedMovieIds': selectedMovieIds,
      'selectedMovies': selectedMovies
          .map(
            (m) => {'id': m.id, 'title': m.title, 'posterPath': m.posterPath},
          )
          .toList(),
    };
  }
}
