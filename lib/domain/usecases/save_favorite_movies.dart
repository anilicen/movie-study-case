import 'package:movie_study_case/domain/repositories/i_movie_repository.dart';

class SaveFavoriteMoviesUseCase {
  final IMovieRepository repository;

  SaveFavoriteMoviesUseCase(this.repository);

  Future<void> call(List<int> movieIds) async {
    return await repository.saveFavoriteMovies(movieIds);
  }
}
