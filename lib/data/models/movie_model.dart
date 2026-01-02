class MovieModel {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;

  MovieModel({required this.id, required this.title, required this.posterPath, required this.backdropPath});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
    );
  }
}
