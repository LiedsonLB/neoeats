import 'package:neoeats/features/domain/repositories/favorite_repository.dart';
import 'package:neoeats/features/data/models/favorite_model.dart';

class SaveFavoriteUseCase {
  final FavoriteRepository favoriteRepository;

  SaveFavoriteUseCase({required this.favoriteRepository});

  Future<Favorite> execute(Favorite favorite) async {
    return await favoriteRepository.saveFavorite(favorite);
  }
}
