import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/errors/category_fetch_failure.dart';
import 'package:neoeats/core/errors/category_save_failure.dart';
import 'package:neoeats/features/data/models/category_model.dart';

class CategoryService {
  DatabaseService db = DatabaseService.instance;

  Future<List<CategoryModel>> fetchCategories() async {
    List<Map<String, dynamic>> results = [];
    try {
      results = await db.query('Categoria');
    } catch (e) {
      CategoryFetchFailure('Categories not found');
    }
    return results.map((map) => CategoryModel.fromJson(map)).toList();
  }

  Future<CategoryModel> fetchCategory(String email) async {
    List<Map<String, dynamic>> results = [];
    try {
      results = await db.query('Categoryes');
    } catch (e) {
      CategoryFetchFailure('Category not found');
    }
    return results.map((map) => CategoryModel.fromJson(map)).first;
  }

  Future<CategoryModel> saveCategory(CategoryModel category) async {
    final Map<String, dynamic> data = category.toJson();
    try {
      await db.insert('Categoria', data);
    } catch (e) {
      CategorySaveFailure('Error saving Category');
    }
    return category;
  }

  Future<void> deleteCategory(String name) async {
    await db.delete(
      'Categoria',
      where: 'nome = ?',
      whereArgs: [name],
    );
  }
}
