import 'package:neoeats/core/errors/category_delete_failure.dart';
import 'package:neoeats/core/errors/category_fetch_failure.dart';
import 'package:neoeats/core/errors/category_save_failure.dart';
import 'package:neoeats/features/data/models/category_model.dart';
import 'package:neoeats/core/services/category_service.dart';
import 'package:neoeats/features/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryService _categoryService;

  CategoryRepositoryImpl({required CategoryService categoryService}) : _categoryService = categoryService;

  @override
  Future<List<Category>> getCategories() async {
    try {
      return await _categoryService.fetchCategories();
    } catch (e) {
      throw CategoryFetchFailure('Failed to fetch categories');
    }
  }

  @override
  Future<Category> getCategoryByName(String name) async {
    try {
      return await _categoryService.fetchCategory(name);
    } catch (e) {
      throw CategoryFetchFailure('Failed to fetch category with name: $name');
    }
  }

  @override
  Future<Category> addCategory(Category category) async {
    try {
      return await _categoryService.saveCategory(category);
    } catch (e) {
      throw CategorySaveFailure('Failed to save category: ${category.name}');
    }
  }

  @override
  Future<void> removeCategory(String name) async {
    try {
      await _categoryService.deleteCategory(name);
    } catch (e) {
      throw CategoryDeleteFailure('Failed to delete category: $name');
    }
  }
}
