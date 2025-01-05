import 'package:neoeats/features/domain/repositories/dish_repository.dart';
import 'package:neoeats/features/data/models/category_model.dart';
import 'package:neoeats/features/data/models/dish_model.dart';

class GetCategoriesForDishUseCase {
  final DishRepository dishRepository;

  GetCategoriesForDishUseCase(this.dishRepository);

  Future<List<Category>> call(Dish dish) async {
    return await dishRepository.fetchCategoriesForDish(dish);
  }
}