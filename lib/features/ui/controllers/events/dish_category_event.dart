import 'package:equatable/equatable.dart';
import 'package:neoeats/features/data/models/dish_model.dart';

abstract class DishCategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCategoriesForDish extends DishCategoryEvent {
  final Dish dish;

  FetchCategoriesForDish(this.dish);

  @override
  List<Object?> get props => [dish];
}
