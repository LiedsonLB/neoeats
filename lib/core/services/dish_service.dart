import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/errors/dish_delete_failure.dart';
import 'package:neoeats/core/errors/dish_fetch_failure.dart';
import 'package:neoeats/core/errors/dish_save_failure.dart';
import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/data/models/category_model.dart';

class DishService {
  DatabaseService db = DatabaseService.instance;

  Future<List<Dish>> fetchDishes() async {
    List<Map<String, dynamic>> results = [];
    try {
      results = await db.query('Dish');
    } catch (e) {
      throw DishFetchFailure('Dishes not found');
    }

    return results.map((map) {
      var dish = Dish.fromJson(map);
      return dish;
    }).toList();
  }

  Future<Dish> fetchDish(String name) async {
    List<Map<String, dynamic>> results = [];
    List<Map<String, dynamic>> resultsByName = [];
    try {
      results = await db.query('Dish');
      resultsByName =
          results.where((element) => element['name'] == name).toList();

      if (resultsByName.isEmpty) {
        throw DishFetchFailure('Dish not found');
      }
    } catch (e) {
      throw DishFetchFailure('Error fetching dish');
    }

    return Dish.fromJson(resultsByName.first);
  }

  Future<Dish> fetchDishById(int id) async {
    List<Map<String, dynamic>> results = [];
    List<Map<String, dynamic>> resultsById = [];
    try {
      results = await db.query('Dish');
      resultsById = results.where((element) => element['id'] == id).toList();

      if (resultsById.isEmpty) {
        throw DishFetchFailure('Dish not found');
      }
    } catch (e) {
      throw DishFetchFailure('Error fetching dish');
    }

    return Dish.fromJson(resultsById.first);
  }

  Future<Dish> saveDish(Dish dish) async {
    final Map<String, dynamic> data = dish.toJson();
    try {
      final dishId = await db.insert('Dish', data);

      if (dish.categories.isNotEmpty) {
        await addCategoriesToDish(
            dishId, dish.categories.map((category) => category.id!).toList());
      }

      return dish.copyWith(id: dishId);
    } catch (e) {
      print("Error while saving dish: $e");
      throw DishSaveFailure('Error saving dish');
    }
  }

  Future<void> deleteDish(String name) async {
    final result = await db.delete(
      'Dish',
      where: 'name = ?',
      whereArgs: [name],
    );

    if (result == 0) {
      throw DishDeleteFailure('Error deleting dish');
    }
  }

  Future<void> addCategoriesToDish(int dishId, List<int> categoryIds) async {
    final List<Map<String, dynamic>> dishExists;
    final List<Map<String, dynamic>> dishExistsById;

    dishExists = await db.query('Dish');
    dishExistsById =
        dishExists.where((element) => element['id'] == dishId).toList();
    if (dishExistsById.isEmpty) {
      throw 'Dish not found';
    }

    final List<Map<String, dynamic>> categoriesExist;
    final List<Map<String, dynamic>> categoriesExistById;

    categoriesExist = await db.query('Category');
    categoriesExistById = categoriesExist
        .where((element) => categoryIds.contains(element['id']))
        .toList();
    if (categoriesExistById.length != categoryIds.length) {
      throw 'Some categories not found';
    }

    for (var categoryId in categoryIds) {
      await db.insert('DishCategory', {
        'dish_id': dishId,
        'category_id': categoryId,
      });
    }
  }

  Future<List<Category>> fetchCategoriesForDish(Dish dish) async {
    try {
      final List<Map<String, dynamic>> results = await db.query(
        'DishCategory',
        where: 'dish_id = ?',
        whereArgs: [dish.id],
      );

      List<Category> categoriesForDish = [];
      for (var row in results) {
        final categoryId = row['category_id'];
        final categoryMap = await db.query(
          'Category',
          where: 'id = ?',
          whereArgs: [categoryId],
        );

        if (categoryMap.isNotEmpty) {
          categoriesForDish.add(Category.fromJson(categoryMap.first));
        }
      }

      return categoriesForDish;
    } catch (e) {
      throw DishFetchFailure('Error fetching categories for dish');
    }
  }

  Future<List<Dish>> fetchDishesByCategoryId(int categoryId) async {
    try {
      final results = await db.query(
        'DishCategory',
        where: 'category_id = ?',
        whereArgs: [categoryId],
      );

      final dishIds = results.map((row) => row['dish_id'] as int).toList();

      if (dishIds.isEmpty) {
        return [];
      }

      final dishMaps = await db.query(
        'Dish',
        where: 'id IN (${List.filled(dishIds.length, '?').join(',')})',
        whereArgs: dishIds,
      );

      return dishMaps.map((map) => Dish.fromJson(map)).toList();
    } catch (e) {
      throw DishFetchFailure('Error fetching dishes by category');
    }
  }
}