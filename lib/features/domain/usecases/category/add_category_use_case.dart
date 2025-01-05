import 'package:neoeats/features/data/models/category_model.dart';
import 'package:neoeats/features/domain/repositories/category_repository.dart';

class AddCategoryUseCase {
  final CategoryRepository repository;

  AddCategoryUseCase(this.repository);

  Future<Category> call(Category category) async {
    return await repository.addCategory(category);
  }
}