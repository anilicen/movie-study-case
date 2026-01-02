import 'package:movie_study_case/domain/entities/genre.dart';
import 'package:movie_study_case/domain/repositories/i_movie_repository.dart';

class GetGenresUseCase {
  final IMovieRepository repository;

  GetGenresUseCase(this.repository);

  Future<List<Genre>> call() async {
    return await repository.getGenres();
  }
}
