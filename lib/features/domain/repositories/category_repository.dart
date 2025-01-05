import 'package:neoeats/features/data/models/category_model.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<Category> getCategoryByName(String name);
  Future<Category> addCategory(Category category);
  Future<void> removeCategory(String name);
}
