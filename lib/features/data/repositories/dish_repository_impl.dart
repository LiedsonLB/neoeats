import 'package:neoeats/core/services/dish_service.dart';
import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/data/models/category_model.dart';
import 'package:neoeats/core/errors/dish_fetch_failure.dart';
import 'package:neoeats/core/errors/dish_save_failure.dart';
import 'package:neoeats/core/errors/dish_delete_failure.dart';
import 'package:neoeats/features/domain/repositories/dish_repository.dart';

class DishRepositoryImpl implements DishRepository {
  final DishService dishService;

  DishRepositoryImpl({required this.dishService});

  @override
  Future<List<Dish>> fetchDishes() async {
    try {
      return await dishService.fetchDishes();
    } catch (e) {
      throw DishFetchFailure('Error retrieving dishes');
    }
  }

  @override
  Future<Dish> fetchDish(String name) async {
    try {
      return await dishService.fetchDish(name);
    } catch (e) {
      throw DishFetchFailure('Error retrieving dish');
    }
  }

  @override
  Future<Dish> saveDish(Dish dish) async {
    try {
      return await dishService.saveDish(dish);
    } catch (e) {
      throw DishSaveFailure('Error saving dish');
    }
  }

  @override
  Future<void> deleteDish(String name) async {
    try {
      await dishService.deleteDish(name);
    } catch (e) {
      throw DishDeleteFailure('Error deleting dish');
    }
  }

  @override
  Future<List<Category>> fetchCategoriesForDish(Dish dish) async {
    try {
      return await dishService.fetchCategoriesForDish(dish);
    } catch (e) {
      throw DishFetchFailure('Error fetching categories for dish');
    }
  }

  @override
  Future<List<Dish>> fetchDishesByCategoryId(int categoryId) async {
    try {
      return await dishService.fetchDishesByCategoryId(categoryId);
    } catch (e) {
      throw DishFetchFailure('Error fetching dishes by category');
    }
  }
}