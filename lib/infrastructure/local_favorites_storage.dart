import 'package:shared_preferences/shared_preferences.dart';

class LocalFavoritesStorage {
  static const String _key =
      'favorites';

  Future<List<String>>
      loadFavorites() async {
    try {
      final prefs =
          await SharedPreferences
              .getInstance();

      return prefs.getStringList(
            _key,
          ) ??
          [];
    } catch (_) {
      return [];
    }
  }

  Future<void> saveFavorites(
    List<String> favorites,
  ) async {
    try {
      final prefs =
          await SharedPreferences
              .getInstance();

      await prefs.setStringList(
        _key,
        favorites,
      );
    } catch (_) {}
  }

  Future<void>
      clearFavorites() async {
    try {
      final prefs =
          await SharedPreferences
              .getInstance();

      await prefs.remove(_key);
    } catch (_) {}
  }
}