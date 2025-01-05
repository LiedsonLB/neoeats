import 'package:neoeats/core/errors/dish_fetch_failure.dart';
import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/domain/repositories/dish_repository.dart';

class GetAllDishesUseCase {
  final DishRepository dishRepository;

  GetAllDishesUseCase({required this.dishRepository});

  Future<List<Dish>> call() async {
    try {
      return await dishRepository.fetchDishes();
    } catch (e) {
      throw DishFetchFailure('Error retrieving dishes');
    }
  }
}