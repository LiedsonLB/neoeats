import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/errors/category_delete_failure.dart';
import 'package:neoeats/core/errors/category_fetch_failure.dart';
import 'package:neoeats/core/errors/category_save_failure.dart';
import 'package:neoeats/features/data/models/category_model.dart';

class CategoryService {
  DatabaseService db = DatabaseService.instance;

  Future<List<Category>> fetchCategories() async {
    List<Map<String, dynamic>> results = [];
    try {
      results = await db.query('Category');
    } catch (e) {
      throw CategoryFetchFailure('Categories not found');
    }
    return results.map((map) => Category.fromJson(map)).toList();
  }

  Future<Category> fetchCategory(String name) async {
    List<Map<String, dynamic>> results = [];
    List<Map<String, dynamic>> resultsByName = [];
    try {
      results = await db.query('Category');
      resultsByName =
          results.where((element) => element['name'] == name).toList();
      if (resultsByName.isEmpty) {
        throw CategoryFetchFailure('Category not found');
      }
    } catch (e) {
      throw CategoryFetchFailure('Error fetching category');
    }
    return Category.fromJson(resultsByName.first);
  }

  Future<Category> saveCategory(Category category) async {
    final Map<String, dynamic> data = category.toJson();
    try {
      await db.insert('Category', data);
    } catch (e) {
      throw CategorySaveFailure('Error saving category');
    }
    return category;
  }

  Future<void> deleteCategory(String name) async {
    final result = await db.delete(
      'Category',
      where: 'name = ?',
      whereArgs: [name],
    );

    if (result == 0) {
      throw CategoryDeleteFailure('Error deleting category');
    }
  }
}
