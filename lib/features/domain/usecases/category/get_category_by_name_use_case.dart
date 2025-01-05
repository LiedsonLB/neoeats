import 'package:neoeats/features/data/models/category_model.dart';
import 'package:neoeats/features/domain/repositories/category_repository.dart';

class GetCategoryByNameUseCase {
  final CategoryRepository repository;

  GetCategoryByNameUseCase(this.repository);

  Future<Category> call(String name) async {
    return await repository.getCategoryByName(name);
  }
}