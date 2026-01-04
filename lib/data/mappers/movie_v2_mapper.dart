import 'package:movie_study_case/data/models/movie_v2_dto.dart';
import 'package:movie_study_case/domain/entities/movie.dart';

extension MovieV2Mapper on MovieV2Dto {
  Movie toEntity() {
    return Movie(
      id: movieId,
      title: headline,
      posterPath: coverImageUrl,
      backdropPath: backgroundImageUrl,
    );
  }
}
