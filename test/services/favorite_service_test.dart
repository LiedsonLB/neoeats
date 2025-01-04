import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/services/client_service.dart';
import 'package:neoeats/core/services/dish_service.dart';
import 'package:neoeats/core/services/favorite_service.dart';
import 'package:neoeats/features/data/models/client_model.dart';
import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/data/models/favorite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Favorite service tests', () {
    late DatabaseService db;
    late Database database;
    late FavoriteService favoriteService;
    late DishService dishService;
    late ClientService clientService;

    setUp(() async {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        sqfliteFfiInit();
      }

      databaseFactory = databaseFactoryFfi;
      db = DatabaseService.instance;
      database = await db.database;
      favoriteService = FavoriteService();
      dishService = DishService();
      clientService = ClientService();

      await database.delete('Favorite');
      await database.delete('Dish');
      await database.delete('Client');
    });

    test('Deve salvar um favorito', () async {
      Client client = Client(name: 'João', email: '', access: 'client', registrationDate: DateTime.now().toString());
      Dish dish = Dish(name: 'Pizza', price: 10.5, status: 'active', categories: []);

      final savedClient = await clientService.saveClient(client);
      final savedDish = await dishService.saveDish(dish);

      Client clienteFind =  await clientService.fetchClient(client.email);
      Dish dishFind = await dishService.fetchDish(dish.name);
      
      final favorite = Favorite(clientId: clienteFind.id!, dishId: dishFind.id!);

      final savedFavorite = await favoriteService.saveFavorite(favorite);

      expect(savedFavorite.clientId, favorite.clientId);
      expect(savedFavorite.dishId, favorite.dishId);

      final results = await database.query('Favorite');
      expect(results.length, 1);
      expect(results.first['client_id'], favorite.clientId);
      expect(results.first['dish_id'], favorite.dishId);
    });

    test('Deve excluir um favorito', () async {
      final favorite = Favorite(clientId: 1, dishId: 101);
      final savedFavorite = await favoriteService.saveFavorite(favorite);

      await favoriteService.removeFavorite(savedFavorite.clientId, savedFavorite.dishId);

      final results = await database.query('Favorite');
      expect(results.length, 0);
    });

    test('Deve recuperar um favorito por ID', () async {
      final favorite = Favorite(clientId: 1, dishId: 101);
      final savedFavorite = await favoriteService.saveFavorite(favorite);

      final retrievedFavorite = await favoriteService.fetchFavoriteById(savedFavorite.id!);

      expect(retrievedFavorite, savedFavorite);
    });

    test('Deve recuperar todos os favoritos', () async {
      final favorite1 = Favorite(clientId: 1, dishId: 101);
      final favorite2 = Favorite(clientId: 2, dishId: 102);
      await favoriteService.saveFavorite(favorite1);
      await favoriteService.saveFavorite(favorite2);

      final favorite = Favorite(clientId: 1, dishId: 101);
      final savedFavorite = await favoriteService.saveFavorite(favorite);

      final retrievedFavorite = await favoriteService.fetchFavoritesByClientId(savedFavorite.clientId);

      retrievedFavorite.forEach((element) {
        print(element.clientId);
        print(element.dishId);
      });
    });
  });
}
