import 'package:movie_study_case/domain/entities/movie.dart';
import 'package:movie_study_case/domain/entities/genre.dart';
import 'package:movie_study_case/data/models/movie_model.dart';
import 'package:movie_study_case/data/models/genre_model.dart';

extension MovieModelToEntity on MovieModel {
  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      posterPath: posterPath,
      backdropPath: backdropPath,
    );
  }
}

extension GenreModelToEntity on GenreModel {
  Genre toEntity() {
    return Genre(id: id, name: name);
  }
}
