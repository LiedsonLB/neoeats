import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/errors/category_delete_failure.dart';
import 'package:neoeats/core/errors/category_save_failure.dart';
import 'package:neoeats/core/services/category_service.dart';
import 'package:neoeats/features/data/models/category_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main()  {
  group('category service test', () {
    late DatabaseService db;
    late Database database;

    setUp(() async{
      if(Platform.isWindows || Platform.isMacOS || Platform.isLinux){
        sqfliteFfiInit();
      }

      databaseFactory = databaseFactoryFfi;
      db = DatabaseService.instance;
      database = await db.database;

      await database.delete('Category');
    });

    tearDown(() async {
      await db.close();
    });

    CategoryService categoryService = CategoryService();
    Category category = new Category(name: 'Bebidas');

    test('Pegar todas as categorias', () async {
      Category categorySaved = await categoryService.saveCategory(category);

      List<Category> results = await categoryService.fetchCategories();

      print(categorySaved.name);

      expect(results.length, 1);
      expect(results.first.name, 'Bebidas');
    });

    test('Salvar categoria', () async {
      await categoryService.saveCategory(category);
      await categoryService.saveCategory(new Category(name: 'Sobremesas'));
      await categoryService.saveCategory(new Category(name: 'Pratos')); 

      List<Category> results = await categoryService.fetchCategories();

      print(results.length);

      expect(results.length, 3);
      expect(results.first.name, 'Bebidas');
    });

    test('Salvar categoria com nome repetido', () async {
      await categoryService.saveCategory(category);

      expect(() async => await categoryService.saveCategory(category), throwsA(isA<CategorySaveFailure>()));

      List<Category> results = await categoryService.fetchCategories();

      expect(results.length, 1);
    });

    test('Deletar categoria', () async {
      Category categorySaved = await categoryService.saveCategory(category);

      List<Category> results = await categoryService.fetchCategories();

      expect(results.length, 1);

      await categoryService.deleteCategory(categorySaved.name);

      List<Category> resultsAfterDelete = await categoryService.fetchCategories();

      expect(resultsAfterDelete.length, 0);
    });

    test('Deletar categoria com nome inexistente', () async {
      await categoryService.saveCategory(category);

      List<Category> results = await categoryService.fetchCategories();

      expect(results.length, 1);

      expect(() async => await categoryService.deleteCategory('Pratos'), throwsA(isA<CategoryDeleteFailure>()));

      List<Category> resultsAfterDelete = await categoryService.fetchCategories();

      expect(resultsAfterDelete.length, 1);
    });
  });
}