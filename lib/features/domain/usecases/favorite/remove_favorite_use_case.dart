import 'package:neoeats/features/domain/repositories/favorite_repository.dart';

class RemoveFavoriteUseCase {
  final FavoriteRepository favoriteRepository;

  RemoveFavoriteUseCase({required this.favoriteRepository});

  Future<void> execute(int clientId, int dishId) async {
    await favoriteRepository.removeFavorite(clientId, dishId);
  }
}
