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
    try {
      final List<Map<String, dynamic>> results = await db.query(
        'Favorite',
        where: 'client_id = ?',
        whereArgs: [clientId],
      );
      return results.map((map) => Favorite.fromJson(map)).toList();
    } catch (e) {
      throw Exception('Error fetching favorites: $e');
    }
  }

  Future<Favorite> fetchFavoriteById(int id) async {
    try {
      final List<Map<String, dynamic>> results = await db.query(
        'Favorite',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (results.isEmpty) {
        throw Exception('Favorite not found');
      }
      return Favorite.fromJson(results.first);
    } catch (e) {
      throw Exception('Error fetching favorite: $e');
    }
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
    try {
      final List<Map<String, dynamic>> results = await db.query(
        'Favorite',
        where: 'client_id = ? AND dish_id = ?',
        whereArgs: [clientId, dishId],
      );
      return results.isNotEmpty;
    } catch (e) {
      throw Exception('Error checking favorite: $e');
    }
  }
}