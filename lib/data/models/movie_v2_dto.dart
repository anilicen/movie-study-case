class MovieV2Dto {
  final int movieId;
  final String headline;
  final String coverImageUrl;
  final String backgroundImageUrl;

  MovieV2Dto({
    required this.movieId,
    required this.headline,
    required this.coverImageUrl,
    required this.backgroundImageUrl,
  });

  factory MovieV2Dto.fromJson(Map<String, dynamic> json) {
    return MovieV2Dto(
      movieId: json['movie_id'] ?? 0,
      headline: json['headline'] ?? '',
      coverImageUrl: json['cover_image_url'] ?? '',
      backgroundImageUrl: json['background_image_url'] ?? '',
    );
  }
}
