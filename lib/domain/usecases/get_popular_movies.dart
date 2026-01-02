import 'package:movie_study_case/domain/entities/movie.dart';
import 'package:movie_study_case/domain/repositories/i_movie_repository.dart';

class GetPopularMoviesUseCase {
  final IMovieRepository repository;

  GetPopularMoviesUseCase(this.repository);

  Future<List<Movie>> call({int page = 1}) async {
    return await repository.getPopularMovies(page: page);
  }
}
