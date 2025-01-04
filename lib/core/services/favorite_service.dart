import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/features/data/models/favorite_model.dart';

class FavoriteService {
  DatabaseService db = DatabaseService.instance;

  Future<Favorite> saveFavorite(Favorite favorite) async {
    try {
      final Map<String, dynamic> data = favorite.toJson();
      final favoriteId = await db.insert('Favorite', data);
      return favorite.copyWith(id: favoriteId);
    } catch (e) {
      throw Exception('Error saving favorite: $e');
    }
  }

  Future<List<Favorite>> fetchFavoritesByClientId(int clientId) async {
    final List<Map<String, dynamic>> results;
    final List<Map<String, dynamic>> resultsByClientId = [];
    try {
      results = await db.query('Favorite');
      resultsByClientId.addAll(
        results.where((element) => element['client_id'] == clientId),
      );
    } catch (e) {
      throw Exception('Error fetching favorites: $e');
    }
    return resultsByClientId.map((map) => Favorite.fromJson(map)).toList();
  }

  Future<Favorite> fetchFavoriteById(int id) async {
    List<Map<String, dynamic>> results = [];
    List<Map<String, dynamic>> resultsById = [];
    try {
      results = await db.query('Favorite');
      resultsById.addAll(results.where((element) => element['id'] == id));
    } catch (e) {
      throw Exception('Error fetching favorite: $e');
    }
    return Favorite.fromJson(resultsById.first);
  }

  Future<void> removeFavorite(int clientId, int dishId) async {
    try {
      final result = await db.delete(
        'Favorite',
        where: 'client_id = ? AND dish_id = ?',
        whereArgs: [clientId, dishId],
      );

      if (result == 0) {
        throw Exception('Favorite not found');
      }
    } catch (e) {
      throw Exception('Error removing favorite: $e');
    }
  }

  Future<bool> isFavorite(int clientId, int dishId) async {
    List<Map<String, dynamic>> results = [];
    List<Map<String, dynamic>> resultsByClientIdAndDishId = [];
    try {
      results = await db.query('Favorite');
      resultsByClientIdAndDishId.addAll(
        results.where(
          (element) => element['client_id'] == clientId && element['dish_id'] == dishId,
        ),
      );
      return resultsByClientIdAndDishId.isNotEmpty;
    } catch (e) {
      throw Exception('Error checking favorite: $e');
    }
  }
}
