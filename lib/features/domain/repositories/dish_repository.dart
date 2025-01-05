import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/data/models/category_model.dart';

abstract class DishRepository {
  Future<List<Dish>> fetchDishes();
  Future<Dish> fetchDish(String name);
  Future<Dish> saveDish(Dish dish);
  Future<void> deleteDish(String name);
  Future<List<Category>> fetchCategoriesForDish(Dish dish);
  Future<List<Dish>> fetchDishesByCategoryId(int categoryId);
}