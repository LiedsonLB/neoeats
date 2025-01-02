import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
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

      await database.delete('Categoria');
    });

    tearDown(() async {
      await db.close();
    });

    CategoryService categoryService = CategoryService();
    CategoryModel category = new CategoryModel(nome: 'Bebidas');

    test('Pegar todas as categorias', () async {
      CategoryModel categorySaved = await categoryService.saveCategory(category);

      List<CategoryModel> results = await categoryService.fetchCategories();

      print(categorySaved.nome);

      expect(results.length, 1);
      expect(results.first.nome, 'Bebidas');
    });

    test('Salvar categoria', () async {
      await categoryService.saveCategory(category);
      await categoryService.saveCategory(new CategoryModel(nome: 'Sobremesas'));
      await categoryService.saveCategory(new CategoryModel(nome: 'Pratos')); 

      List<CategoryModel> results = await categoryService.fetchCategories();

      print(results.length);

      expect(results.length, 3);
      expect(results.first.nome, 'Bebidas');
    });

    test('Salvar categoria com nome repetido', () async {
      await categoryService.saveCategory(category);
      await categoryService.saveCategory(category);

      List<CategoryModel> results = await categoryService.fetchCategories();

      expect(results.length, 1);
    });

    test('Deletar categoria', () async {
      CategoryModel categorySaved = await categoryService.saveCategory(category);

      List<CategoryModel> results = await categoryService.fetchCategories();

      expect(results.length, 1);

      await categoryService.deleteCategory(categorySaved.nome);

      List<CategoryModel> resultsAfterDelete = await categoryService.fetchCategories();

      expect(resultsAfterDelete.length, 0);
    });
  });
}