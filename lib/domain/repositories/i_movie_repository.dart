import 'package:movie_study_case/domain/entities/genre.dart';
import 'package:movie_study_case/domain/entities/movie.dart';

abstract class IMovieRepository {
  Future<List<Movie>> getPopularMovies({int page = 1});
  Future<List<Genre>> getGenres();
  Future<List<Movie>> getMoviesByGenre(int genreId, {int page = 1});
  Future<void> saveFavoriteMovies(List<int> movieIds);
  Future<void> saveFavoriteGenres(List<int> genreIds);
}
