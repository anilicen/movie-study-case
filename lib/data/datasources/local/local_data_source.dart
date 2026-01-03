import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  final SharedPreferences _prefs;

  LocalDataSource(this._prefs);

  static const String _favoriteMoviesKey = 'favorite_movies';

  Future<void> saveFavoriteMovies(List<int> movieIds) async {
    await _prefs.setStringList(
      _favoriteMoviesKey,
      movieIds.map((id) => id.toString()).toList(),
    );
  }

  Future<List<int>> getFavoriteMovies() async {
    final movieIdsString = _prefs.getStringList(_favoriteMoviesKey);
    if (movieIdsString == null) return [];
    return movieIdsString.map((id) => int.parse(id)).toList();
  }

  Future<void> clearFavoriteMovies() async {
    await _prefs.remove(_favoriteMoviesKey);
  }

  static const String _favoriteGenresKey = 'favorite_genres';

  Future<void> saveFavoriteGenres(List<int> genreIds) async {
    await _prefs.setStringList(
      _favoriteGenresKey,
      genreIds.map((id) => id.toString()).toList(),
    );
  }

  Future<List<int>> getFavoriteGenres() async {
    final genreIdsString = _prefs.getStringList(_favoriteGenresKey);
    if (genreIdsString == null) return [];
    return genreIdsString.map((id) => int.parse(id)).toList();
  }

  Future<void> clearFavoriteGenres() async {
    await _prefs.remove(_favoriteGenresKey);
  }
}
