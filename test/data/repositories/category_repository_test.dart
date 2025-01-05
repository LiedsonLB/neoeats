import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/errors/category_delete_failure.dart';
import 'package:neoeats/core/errors/category_fetch_failure.dart';
import 'package:neoeats/core/errors/category_save_failure.dart';
import 'package:neoeats/features/data/models/category_model.dart';
import 'package:neoeats/core/services/category_service.dart';
import 'package:neoeats/features/data/repositories/category_repository_impl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Category repository test', () {
    late DatabaseService db;
    late Database database;
    late CategoryRepositoryImpl repository;
    late CategoryService categoryService;

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
    });

    tearDown(() async {
      await db.close();
    });

    Category category = Category(name: 'Bebidas');

    test('Deve retornar todas as categorias', () async {
      await repository.addCategory(category);

      List<Category> results = await repository.getCategories();

      expect(results.length, 1);
      expect(results.first.name, 'Bebidas');
    });

    test('Deve adicionar categoria', () async {
      await repository.addCategory(category);
      await repository.addCategory(Category(name: 'Sobremesas'));
      await repository.addCategory(Category(name: 'Pratos'));

      List<Category> results = await repository.getCategories();

      expect(results.length, 3);
      expect(results[0].name, 'Bebidas');
      expect(results[1].name, 'Sobremesas');
      expect(results[2].name, 'Pratos');
    });

    test('Deve salvar categoria com nome repetido', () async {
      await repository.addCategory(category);

      expect(
          () async => await repository.addCategory(category),
          throwsA(isA<CategorySaveFailure>()));

      List<Category> results = await repository.getCategories();

      expect(results.length, 1);
    });

    test('Deve buscar categoria por nome', () async {
      await repository.addCategory(category);

      Category result = await repository.getCategoryByName('Bebidas');

      expect(result.name, 'Bebidas');
    });

    test('Deve lançar erro ao buscar categoria inexistente', () async {
      expect(() async => await repository.getCategoryByName('Inexistente'),
          throwsA(isA<CategoryFetchFailure>()));
    });

    test('Deve deletar categoria', () async {
      await repository.addCategory(category);

      List<Category> results = await repository.getCategories();
      expect(results.length, 1);

      await repository.removeCategory('Bebidas');

      List<Category> resultsAfterDelete = await repository.getCategories();
      expect(resultsAfterDelete.length, 0);
    });

    test('Deve lançar erro ao deletar categoria inexistente', () async {
      await repository.addCategory(category);

      expect(() async => await repository.removeCategory('Pratos'),
          throwsA(isA<CategoryDeleteFailure>()));

      List<Category> results = await repository.getCategories();
      expect(results.length, 1);
    });
  });
}
