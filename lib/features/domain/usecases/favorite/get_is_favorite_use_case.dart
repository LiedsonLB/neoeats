import 'package:neoeats/features/domain/repositories/favorite_repository.dart';

class IsFavoriteUseCase {
  final FavoriteRepository favoriteRepository;

  IsFavoriteUseCase({required this.favoriteRepository});

  Future<bool> execute(int clientId, int dishId) async {
    return await favoriteRepository.isFavorite(clientId, dishId);
  }
}
