import 'package:movie_study_case/domain/repositories/i_movie_repository.dart';

class SaveFavoriteGenresUseCase {
  final IMovieRepository repository;

  SaveFavoriteGenresUseCase(this.repository);

  Future<void> call(List<int> genreIds) async {
    return await repository.saveFavoriteGenres(genreIds);
  }
}
