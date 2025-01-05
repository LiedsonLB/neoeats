import 'package:neoeats/core/errors/dish_fetch_failure.dart';
import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/domain/repositories/dish_repository.dart';

class GetDishByName {
  final DishRepository dishRepository;

  GetDishByName({required this.dishRepository});

  Future<Dish> call(String name) async {
    try {
      return await dishRepository.fetchDish(name);
    } catch (e) {
      throw DishFetchFailure('Dish not found');
    }
  }
}