import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/errors/dish_delete_failure.dart';
import 'package:neoeats/core/services/dish_service.dart';
import 'package:neoeats/features/data/models/category_model.dart';
import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Dish service tests', () {
    late DatabaseService db;
    late Database database;
    late DishService dishService;

    late Category category;
    late Dish dish;

    setUp(() async {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        sqfliteFfiInit();
      }

      databaseFactory = databaseFactoryFfi;
      db = DatabaseService.instance;
      database = await db.database;
      dishService = DishService();

      await database.delete('Dish');
      await database.delete('Category');
      await database.delete('DishCategory');
    });

    test('Deve salvar Prato', () async {
      category = Category(name: 'Massas');
      final categoryId = await db.insert('Category', category.toJson());
      category = category.copyWith(id: categoryId);

      dish = Dish(
        name: 'Pizza',
        price: 10.5,
        status: 'active',
        categories: [category],
      );

      final savedDish = await dishService.saveDish(dish);

      expect(savedDish.name, dish.name);
      expect(savedDish.price, dish.price);

      final results = await database.query('Dish');
      expect(results.length, 1);
    });

    test('Deve pegar o prato por nome', () async {
      category = Category(name: 'Massas');
      final categoryId = await db.insert('Category', category.toJson());
      category = category.copyWith(id: categoryId);

      dish = Dish(
        name: 'Pizza',
        price: 10.5,
        status: 'active',
        categories: [category],
      );

      await dishService.saveDish(dish);

      final fetchedDish = await dishService.fetchDish('Pizza');

      expect(fetchedDish.name, 'Pizza');
      expect(fetchedDish.price, 10.5);
    });

    test('Deve deleta um prato', () async {
      category = Category(name: 'Massas');
      final categoryId = await db.insert('Category', category.toJson());
      category = category.copyWith(id: categoryId);

      dish = Dish(
        name: 'Pizza',
        price: 10.5,
        status: 'active',
        categories: [category],
      );

      await dishService.saveDish(dish);

      await dishService.deleteDish('Pizza');

      final results = await database.query('Dish');
      expect(results.length, 0);
    });

    test('Deve pega mensagem de falha após tentar deletar prato que não existe',
        () async {
      expect(() async => await dishService.deleteDish('Non-existent Dish'),
          throwsA(isA<DishDeleteFailure>()));
    });

    test('Deve salvar um prato e associar categorias', () async {
      final category1 = Category(name: 'Categoria 1');
      final category2 = Category(name: 'Categoria 2');

      final category1Id = await db.insert('Category', category1.toJson());
      final category2Id = await db.insert('Category', category2.toJson());

      final category1WithId = category1.copyWith(id: category1Id);
      final category2WithId = category2.copyWith(id: category2Id);

      final dish = Dish(
        name: 'Pizza',
        price: 10.5,
        status: 'active',
        categories: [category1WithId, category2WithId],
      );

      await dishService.saveDish(dish);

      final savedDishName = await db.query('Dish');
      final savedDishByName = Dish.fromJson(savedDishName.first);

      expect(savedDishByName.name, dish.name);
      expect(savedDishByName.id, isNotNull);

      final results = await db.query('DishCategory');
      final existingAssociations = results
          .where((element) =>
              element['dish_id'] == savedDishByName.id &&
              (element['category_id'] == category1WithId.id ||
                  element['category_id'] == category2WithId.id))
          .toList();

      if (existingAssociations.isEmpty) {
        await dishService.addCategoriesToDish(savedDishByName.id!, [
          category1WithId.id!,
          category2WithId.id!,
        ]);
      }

      List<Map<String, dynamic>> resultsForDish;
      final dishCategoryResults = await db.query('DishCategory');
      resultsForDish = dishCategoryResults
          .where((element) => element['dish_id'] == savedDishByName.id)
          .toList();

      expect(resultsForDish.length, 2);
      expect(resultsForDish[0]['category_id'], category1WithId.id);
      expect(resultsForDish[1]['category_id'], category2WithId.id);
    });

    test('Deve pegar categoria por prato', () async {
      final category1 = Category(name: 'Categoria 1');
      final category2 = Category(name: 'Categoria 2');

      final category1Id = await db.insert('Category', category1.toJson());
      final category2Id = await db.insert('Category', category2.toJson());

      final category1WithId = category1.copyWith(id: category1Id);
      final category2WithId = category2.copyWith(id: category2Id);

      final dish = Dish(
        name: 'Pizza',
        price: 10.5,
        status: 'active',
        categories: [category1WithId, category2WithId],
      );

      await dishService.saveDish(dish);

      final savedDishName = await db.query('Dish');
      final savedDishByName = Dish.fromJson(savedDishName.first);

      expect(savedDishByName.name, dish.name);
      expect(savedDishByName.id, isNotNull);

      final results = await db.query('DishCategory');
      final existingAssociations = results
          .where((element) =>
              element['dish_id'] == savedDishByName.id &&
              (element['category_id'] == category1WithId.id ||
                  element['category_id'] == category2WithId.id))
          .toList();

      if (existingAssociations.isEmpty) {
        await dishService.addCategoriesToDish(savedDishByName.id!, [
          category1WithId.id!,
          category2WithId.id!,
        ]);
      }

      final categories =
          await dishService.fetchCategoriesForDish(savedDishByName);

      expect(categories.length, 2);
      expect(categories[0].name, 'Categoria 1');
      expect(categories[1].name, 'Categoria 2');
    });

    test('Deve pegar pratos por categoria procurada', () async {
      final category1 = Category(name: 'Categoria 1');
      final category2 = Category(name: 'Categoria 2');

      final category1Id = await db.insert('Category', category1.toJson());
      final category2Id = await db.insert('Category', category2.toJson());

      final category1WithId = category1.copyWith(id: category1Id);
      final category2WithId = category2.copyWith(id: category2Id);

      final dish1 = Dish(
        name: 'Pizza',
        price: 1300.5,
        status: 'active',
        categories: [category1WithId],
      );

      final dish2 = Dish(
        name: 'Risoto',
        price: 1345.5,
        status: 'active',
        categories: [category1WithId, category2WithId],
      );

      await dishService.saveDish(dish1);
      await dishService.saveDish(dish2);

      final dishes =
          await dishService.fetchDishesByCategoryId(category1WithId.id!);

      expect(dishes.length, 2);
      expect(dishes[0].name, dish1.name);
      expect(dishes[1].name, dish2.name);

      print(dishes[0].name);
      print(dishes[0].price);
      print(dishes[1].name);
      print(dishes[1].price);
    });
  });
}
