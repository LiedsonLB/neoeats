import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoeats/features/data/models/dish_model.dart';

class FavoriteNotifier extends StateNotifier<List<Dish>> {
  FavoriteNotifier() : super([]);

  void addFavorite(Dish dish) {
    if (!state.contains(dish)) {
      state = [...state, dish];
    }
  }
  void removeFavorite(Dish dish) {
    state = state.where((d) => d.id != dish.id).toList();
  }
  bool isFavorite(Dish dish) {
    return state.any((d) => d.id == dish.id);
  }
}
final favoriteProvider = StateNotifierProvider<FavoriteNotifier, List<Dish>>((ref) {
  return FavoriteNotifier();
});