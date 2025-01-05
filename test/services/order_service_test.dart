import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/services/client_service.dart';
import 'package:neoeats/core/services/order_services.dart';
import 'package:neoeats/core/services/restaurant_table_service.dart';
import 'package:neoeats/features/data/models/client_model.dart';
import 'package:neoeats/features/data/models/order_model.dart';
import 'package:neoeats/features/data/models/restaurant_table_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Order service tests', () {
    late DatabaseService databaseService;
    late Database database;
    late OrderDishService orderDishService;
    late RestaurantTableService restaurantTableService;
    late ClientService clientService;

    setUp(() async {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        sqfliteFfiInit();
      }

      databaseFactory = databaseFactoryFfi;
      databaseService = DatabaseService.instance;
      orderDishService = OrderDishService();
      restaurantTableService = RestaurantTableService();
      clientService = ClientService();
      database = await databaseService.database;

      await database.delete('OrderDish');
      await database.delete('RestaurantTable');
      await database.delete('Client');
    });

    tearDown(() async {
      await DatabaseService.instance.close();
    });

    test('Deve salvar pedido', () async {
      RestaurantTable restaurantTable =
          RestaurantTable(id: 1, status: 'free', capacity: 4);
      await restaurantTableService.saveTable(restaurantTable);

      Client client = Client(
          name: 'Liedson Barros',
          email: 'liedson.b9@gmail.com',
          access: 'client',
          phone: '123456789',
          registrationDate: DateTime.now().toString());
      clientService.saveClient(client);

      Client clientFind = await clientService.fetchClient(client.email);

      final order = Order(
        userId: clientFind.id!,
        tableId: restaurantTable.id!,
        orderDate: '2025-01-04 12:00:00',
        status: 'open',
      );

      final savedOrder = await orderDishService.saveOrder(order);

      expect(savedOrder.id, isNotNull);
      expect(savedOrder.tableId, order.tableId);
      expect(savedOrder.orderDate, order.orderDate);
      expect(savedOrder.status, order.status);
    });

    test('Deve buscar pedido por ID', () async {
      RestaurantTable restaurantTable =
          RestaurantTable(id: 1, status: 'free', capacity: 4);
      await restaurantTableService.saveTable(restaurantTable);

      Client client = Client(
          name: 'Liedson Barros',
          email: 'liedson.b9@gmail.com',
          access: 'client',
          phone: '123456789',
          registrationDate: DateTime.now().toString());
      clientService.saveClient(client);

      Client clientFind = await clientService.fetchClient(client.email);

      final order = Order(
        userId: clientFind.id!,
        tableId: restaurantTable.id!,
        orderDate: '2025-01-04 12:00:00',
        status: 'open',
      );

      final savedOrder = await orderDishService.saveOrder(order);
      final fetchedOrder =
          await orderDishService.fetchOrderById(savedOrder.id!);

      expect(fetchedOrder.id, savedOrder.id);
      expect(fetchedOrder.tableId, savedOrder.tableId);
      expect(fetchedOrder.orderDate, savedOrder.orderDate);
      expect(fetchedOrder.status, savedOrder.status);
    });

    test('Deve buscar pedidos por status', () async {
      RestaurantTable restaurantTable =
          RestaurantTable(id: 1, status: 'free', capacity: 4);
      await restaurantTableService.saveTable(restaurantTable);
      RestaurantTable restaurantTable2 =
          RestaurantTable(id: 2, status: 'occupied', capacity: 2);
      await restaurantTableService.saveTable(restaurantTable2);

      Client client = Client(
          name: 'Liedson Barros',
          email: 'liedson.b9@gmail.com',
          access: 'client',
          phone: '123456789',
          registrationDate: DateTime.now().toString());
      clientService.saveClient(client);

      Client clientFind = await clientService.fetchClient(client.email);

      final order1 = Order(
        userId: clientFind.id!,
        tableId: restaurantTable.id!,
        orderDate: '2025-01-04 12:00:00',
        status: 'open',
      );
      final order2 = Order(
        userId: clientFind.id!,
        tableId: restaurantTable2.id!,
        orderDate: '2025-01-04 12:30:00',
        status: 'closed',
      );

      await orderDishService.saveOrder(order1);
      await orderDishService.saveOrder(order2);

      final openOrders = await orderDishService.fetchOrdersByStatus('open');
      final closedOrders = await orderDishService.fetchOrdersByStatus('closed');

      expect(openOrders.length, 1);
      expect(openOrders.first.status, 'open');
      expect(closedOrders.length, 1);
      expect(closedOrders.first.status, 'closed');
    });

    test('Deve buscar pedidos por tableId', () async {
      RestaurantTable restaurantTable =
          RestaurantTable(id: 1, status: 'free', capacity: 4);
      await restaurantTableService.saveTable(restaurantTable);
      RestaurantTable restaurantTable2 =
          RestaurantTable(id: 2, status: 'occupied', capacity: 2);
      await restaurantTableService.saveTable(restaurantTable2);

      Client client = Client(
          name: 'Liedson Barros',
          email: 'liedson.b9@gmail.com',
          access: 'client',
          phone: '123456789',
          registrationDate: DateTime.now().toString());
      clientService.saveClient(client);

      Client clientFind = await clientService.fetchClient(client.email);

      final order1 = Order(
        userId: clientFind.id!,
        tableId: restaurantTable.id!,
        orderDate: '2025-01-04 12:00:00',
        status: 'open',
      );
      final order2 = Order(
        userId: clientFind.id!,
        tableId: restaurantTable2.id!,
        orderDate: '2025-01-04 12:30:00',
        status: 'closed',
      );

      await orderDishService.saveOrder(order1);
      await orderDishService.saveOrder(order2);

      final ordersForTable1 = await orderDishService.fetchOrdersByTableId(1);
      final ordersForTable2 = await orderDishService.fetchOrdersByTableId(2);

      expect(ordersForTable1.length, 1);
      expect(ordersForTable1.first.tableId, 1);
      expect(ordersForTable2.length, 1);
      expect(ordersForTable2.first.tableId, 2);
    });

    test('Deve atualizar status do pedido', () async {
      RestaurantTable restaurantTable =
          RestaurantTable(id: 1, status: 'free', capacity: 4);
      await restaurantTableService.saveTable(restaurantTable);

      Client client = Client(
          name: 'Liedson Barros',
          email: 'liedson.b9@gmail.com',
          access: 'client',
          phone: '123456789',
          registrationDate: DateTime.now().toString());
      clientService.saveClient(client);

      Client clientFind = await clientService.fetchClient(client.email);

      final order = Order(
        userId: clientFind.id!,
        tableId: restaurantTable.id!,
        orderDate: '2025-01-04 12:00:00',
        status: 'open',
      );

      final savedOrder = await orderDishService.saveOrder(order);
      await orderDishService.updateOrderStatus(savedOrder.id!, 'closed');

      final updatedOrder =
          await orderDishService.fetchOrderById(savedOrder.id!);

      expect(updatedOrder.status, 'closed');
    });
  });
}
