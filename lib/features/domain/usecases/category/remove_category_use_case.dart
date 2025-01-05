import 'package:neoeats/features/domain/repositories/category_repository.dart';

class RemoveCategoryUseCase {
  final CategoryRepository repository;

  RemoveCategoryUseCase(this.repository);

  Future<void> call(String name) async {
    await repository.removeCategory(name);
  }
}