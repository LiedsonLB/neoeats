import 'package:neoeats/features/data/models/favorite_model.dart';

abstract class FavoriteRepository {
  Future<Favorite> saveFavorite(Favorite favorite);
  Future<Favorite> fetchFavoriteById(int id);
  Future<void> removeFavorite(int clientId, int dishId);
  Future<bool> isFavorite(int clientId, int dishId);
}