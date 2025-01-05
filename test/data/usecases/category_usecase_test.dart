import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/errors/category_delete_failure.dart';
import 'package:neoeats/core/errors/category_fetch_failure.dart';
import 'package:neoeats/core/errors/category_save_failure.dart';
import 'package:neoeats/core/services/category_service.dart';
import 'package:neoeats/features/data/models/category_model.dart';
import 'package:neoeats/features/data/repositories/category_repository_impl.dart';
import 'package:neoeats/features/domain/usecases/category/add_category_use_case.dart';
import 'package:neoeats/features/domain/usecases/category/get_categories_use_case.dart';
import 'package:neoeats/features/domain/usecases/category/get_category_by_name_use_case.dart';
import 'package:neoeats/features/domain/usecases/category/remove_category_use_case.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Testes de Use Cases', () {
    late DatabaseService db;
    late Database database;
    late CategoryService categoryService;
    late CategoryRepositoryImpl repository;

    late GetCategoriesUseCase getCategoriesUseCase;
    late GetCategoryByNameUseCase getCategoryByNameUseCase;
    late AddCategoryUseCase addCategoryUseCase;
    late RemoveCategoryUseCase removeCategoryUseCase;

    setUp(() async {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        sqfliteFfiInit();
      }

      databaseFactory = databaseFactoryFfi;
      db = DatabaseService.instance;
      database = await db.database;

      await database.delete('Category');

      categoryService = CategoryService();
      repository = CategoryRepositoryImpl(categoryService: categoryService);

      getCategoriesUseCase = GetCategoriesUseCase(repository);
      getCategoryByNameUseCase = GetCategoryByNameUseCase(repository);
      addCategoryUseCase = AddCategoryUseCase(repository);
      removeCategoryUseCase = RemoveCategoryUseCase(repository);
    });

    tearDown(() async {
      await db.close();
    });

    final testCategory = Category(name: 'Bebidas');

    test('Deve adicionar uma categoria', () async {
      final result = await addCategoryUseCase(testCategory);

      final categories = await getCategoriesUseCase();

      expect(result.name, 'Bebidas');
      expect(categories.length, 1);
      expect(categories.first.name, 'Bebidas');
    });

    test('Deve buscar todas as categorias', () async {
      await addCategoryUseCase(Category(name: 'Comidas'));
      await addCategoryUseCase(Category(name: 'Sobremesas'));

      final results = await getCategoriesUseCase();

      expect(results.length, 2);
      expect(results.first.name, 'Comidas');
      expect(results.last.name, 'Sobremesas');
    });

    test('Deve buscar categoria por nome', () async {
      await addCategoryUseCase(testCategory);

      final result = await getCategoryByNameUseCase('Bebidas');

      expect(result.name, 'Bebidas');
    });

    test('Deve lançar erro ao buscar categoria inexistente', () async {
      expect(() => getCategoryByNameUseCase('Não Existe'),
          throwsA(isA<CategoryFetchFailure>()));
    });

    test('Deve lançar erro ao adicionar categoria com nome repetido', () async {
      await addCategoryUseCase(testCategory);

      expect(() async => await addCategoryUseCase(testCategory),
          throwsA(isA<CategorySaveFailure>()));
    });

    test('Deve deletar uma categoria', () async {
      await addCategoryUseCase(testCategory);

      final categoriesBeforeDelete = await getCategoriesUseCase();
      expect(categoriesBeforeDelete.length, 1);

      await removeCategoryUseCase('Bebidas');

      final categoriesAfterDelete = await getCategoriesUseCase();
      expect(categoriesAfterDelete.length, 0);
    });

    test('Deve lançar erro ao deletar categoria inexistente', () async {
      expect(() => removeCategoryUseCase('Não Existe'),
          throwsA(isA<CategoryDeleteFailure>()));
    });
  });
}
