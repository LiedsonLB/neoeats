import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/errors/dish_fetch_failure.dart';
import 'package:neoeats/core/errors/dish_save_failure.dart';
import 'package:neoeats/core/errors/dish_delete_failure.dart';
import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/data/models/category_model.dart';
import 'package:neoeats/features/data/repositories/dish_repository_impl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Testes de Use Cases - Prato', () {
    late DatabaseService db;
    late Database database;
    late DishRepositoryImpl dishRepository;

    setUp(() async {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        sqfliteFfiInit();
      }

      databaseFactory = databaseFactoryFfi;
      db = DatabaseService.instance;
      database = await db.database;

      await database.delete('Dish');
      await database.delete('Category');
      await database.delete('DishCategory');

      dishRepository = DishRepositoryImpl();

      getDishesUseCase = GetDishesUseCase(dishRepository);
      getDishByNameUseCase = GetDishByNameUseCase(dishRepository);
      createDishUseCase = CreateDishUseCase(dishRepository);
      removeDishUseCase = RemoveDishUseCase(dishRepository);
      assignCategoriesToDishUseCase = AssignCategoriesToDishUseCase(dishRepository);
      getCategoriesForDishUseCase = GetCategoriesForDishUseCase(dishRepository);
    });

    tearDown(() async {
      await db.close();
    });

    final testDish = Dish(name: 'Pizza Margherita', categories: [Category(id: 1, name: 'Comidas')]);

    test('Deve adicionar um prato', () async {
      final result = await createDishUseCase(testDish);

      final dishes = await getDishesUseCase();

      expect(result.name, 'Pizza Margherita');
      expect(dishes.length, 1);
      expect(dishes.first.name, 'Pizza Margherita');
    });

    test('Deve buscar todos os pratos', () async {
      await createDishUseCase(Dish(name: 'Pizza de Calabresa', categories: [Category(id: 2, name: 'Comidas')]));
      await createDishUseCase(Dish(name: 'Lasanha', categories: [Category(id: 3, name: 'Comidas')]));

      final results = await getDishesUseCase();

      expect(results.length, 3); // Including the testDish
      expect(results.first.name, 'Pizza Margherita');
      expect(results.last.name, 'Lasanha');
    });

    test('Deve buscar prato por nome', () async {
      await createDishUseCase(testDish);

      final result = await getDishByNameUseCase('Pizza Margherita');

      expect(result.name, 'Pizza Margherita');
    });

    test('Deve lançar erro ao buscar prato inexistente', () async {
      expect(() => getDishByNameUseCase('Não Existe'),
          throwsA(isA<DishFetchFailure>()));
    });

    test('Deve lançar erro ao adicionar prato com nome repetido', () async {
      await createDishUseCase(testDish);

      final duplicateDish = Dish(name: 'Pizza Margherita', categories: [Category(id: 1, name: 'Comidas')]);

      expect(() async => await createDishUseCase(duplicateDish),
          throwsA(isA<DishSaveFailure>()));
    });

    test('Deve deletar um prato', () async {
      await createDishUseCase(testDish);

      final dishesBeforeDelete = await getDishesUseCase();
      expect(dishesBeforeDelete.length, 1);

      await removeDishUseCase('Pizza Margherita');

      final dishesAfterDelete = await getDishesUseCase();
      expect(dishesAfterDelete.length, 0);
    });

    test('Deve lançar erro ao deletar prato inexistente', () async {
      expect(() => removeDishUseCase('Não Existe'),
          throwsA(isA<DishDeleteFailure>()));
    });

    test('Deve atribuir categorias a um prato', () async {
      final dish = await createDishUseCase(testDish);
      final categoryIds = [1]; // Assuming category ID 1 exists

      await assignCategoriesToDishUseCase(dish.id!, categoryIds);

      final categoriesForDish = await getCategoriesForDishUseCase(dish);

      expect(categoriesForDish.length, 1);
      expect(categoriesForDish.first.name, 'Comidas');
    });

    test('Deve buscar categorias de um prato', () async {
      final dish = await createDishUseCase(testDish);
      final categoryIds = [1]; // Assuming category ID 1 exists

      await assignCategoriesToDishUseCase(dish.id!, categoryIds);

      final categoriesForDish = await getCategoriesForDishUseCase(dish);

      expect(categoriesForDish.length, 1);
      expect(categoriesForDish.first.name, 'Comidas');
    });

    test('Deve buscar pratos por categoria', () async {
      final dish = await createDishUseCase(testDish);
      final categoryId = 1; // Assuming category ID 1 exists

      final dishes = await getDishesUseCase.getDishesByCategory(categoryId);

      expect(dishes.length, 1);
      expect(dishes.first.name, 'Pizza Margherita');
    });
  });
}
