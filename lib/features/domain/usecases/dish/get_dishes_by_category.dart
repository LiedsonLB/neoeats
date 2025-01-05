import 'package:neoeats/core/errors/dish_fetch_failure.dart';
import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/domain/repositories/dish_repository.dart';

class GetDishesByCategory {
  final DishRepository dishRepository;

  GetDishesByCategory({required this.dishRepository});

  Future<List<Dish>> call(int categoryId) async {
    try {
      return await dishRepository.fetchDishesByCategoryId(categoryId);
    } catch (e) {
      throw DishFetchFailure('Error fetching dishes by category');
    }
  }
}