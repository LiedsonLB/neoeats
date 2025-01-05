import 'package:neoeats/core/services/favorite_service.dart';
import 'package:neoeats/features/data/models/favorite_model.dart';
import 'package:neoeats/features/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteService favoriteService;

  FavoriteRepositoryImpl({required this.favoriteService});

  @override
  Future<Favorite> saveFavorite(Favorite favorite) async {
    return await favoriteService.saveFavorite(favorite);
  }

  @override
  Future<Favorite> fetchFavoriteById(int id) async {
    return await favoriteService.fetchFavoriteById(id);
  }

  @override
  Future<void> removeFavorite(int clientId, int dishId) async {
    return await favoriteService.removeFavorite(clientId, dishId);
  }

  @override
  Future<bool> isFavorite(int clientId, int dishId) async {
    return await favoriteService.isFavorite(clientId, dishId);
  }
}
