import 'package:neoeats/features/data/models/dish_model.dart';

abstract class FavoriteRepository {
  Future<void> addFavoriteDish(Dish dish);
  Future<void> removeFavoriteDish(Dish dish);
  Future<List<Dish>> getFavoriteDishes();
}