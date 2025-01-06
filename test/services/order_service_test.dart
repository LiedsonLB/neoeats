import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/services/client_service.dart';
import 'package:neoeats/core/services/order_service.dart';
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
      clientService.saveClient(Client(name: 'Liedson', email: 'liedaosnawd', access: 'client', registrationDate: DateTime.now().toIso8601String()));

       Client client = await clientService.fetchClient('liedaosnawd');

      final newOrder = Order(
        orderDate: DateTime.now().toIso8601String(),
        status: "open",
        userId: client.id!,
        orderItems: [],
      );

      final savedOrder = await orderDishService.saveOrder(newOrder);

      final fetchedOrder = await orderDishService.fetchOrderById(savedOrder.id!);

      expect(fetchedOrder, isNotNull);
    });

    // test('Deve buscar pedido por orderNumber', () async {
    //   final newOrder = Order(
    //     orderDate: DateTime.now().toIso8601String(),
    //     status: "Aberto",
    //     tableId: 1,
    //     userId: 1,
    //     orderItems: [],
    //   );


    //   print('New order: $newOrder');
      
    //   await orderDishService.saveOrderDish(newOrder);

    //   final fetchedOrders = await orderDishService.getOrderDishesByOrderNumber(orderNumber);

    //   expect(fetchedOrders.length, greaterThan(0));
    //   expect(fetchedOrders.first.orderId, orderNumber);
    // });

    // test('Deve buscar todos os itens do pedido', () async {
    //   final orderId = 1002;

    //   final orders = [
    //     Order(orderId: orderId, dishId: 101, quantity: 1, unitPrice: 15.00),
    //     Order(orderId: orderId, dishId: 102, quantity: 2, unitPrice: 10.00),
    //   ];

    //   for (var order in orders) {
    //     await orderDishService.saveOrderDish(order);
    //   }

    //   final fetchedOrders = await orderDishService.getOrderDishesByOrderNumber(orderId);

    //   expect(fetchedOrders.length, orders.length);
    // });

    // test('Deve adicionar mais itens ao pedido', () async {
    //   final orderId = 1003;

    //   final initialOrder = Order(
    //     orderId: orderId,
    //     dishId: 101,
    //     quantity: 1,
    //     unitPrice: 20.00,
    //   );

    //   await orderDishService.saveOrderDish(initialOrder);

    //   final newItem = Order(
    //     orderId: orderId,
    //     dishId: 102,
    //     quantity: 1,
    //     unitPrice: 30.00,
    //   );

    //   await orderDishService.saveOrderDish(newItem);

    //   final fetchedOrders = await orderDishService.getOrderDishesByOrderNumber(orderId);

    //   expect(fetchedOrders.length, 2);
    // });

    // test('Deve atualizar a quantidade do item no pedido', () async {
    //   final orderId = 1004;
    //   final dishId = 101;

    //   final initialOrder = Order(
    //     orderId: orderId,
    //     dishId: dishId,
    //     quantity: 1,
    //     unitPrice: 20.00,
    //   );

    //   final savedOrder = await orderDishService.saveOrderDish(initialOrder);

    //   await orderDishService.updateOrderDishQuantity(savedOrder.id!, 3);

    //   final updatedOrder = await orderDishService.getOrderDishById(savedOrder.id!);

    //   expect(updatedOrder?.quantity, 3);
    // });

    // test('Deve buscar pedidos por tableId', () async {
    //   final tableId = 1;

    //   await restaurantTableService.saveRestaurantTable(
    //     RestaurantTableModel(id: tableId, tableNumber: 10),
    //   );

    //   final newOrder = Order(
    //     orderId: 2001,
    //     dishId: 101,
    //     quantity: 1,
    //     unitPrice: 15.00,
    //     tableId: tableId,
    //   );

    //   await orderDishService.saveOrderDish(newOrder);

    //   final fetchedOrders = await orderDishService.getOrdersByTableId(tableId);

    //   expect(fetchedOrders.length, greaterThan(0));
    //   expect(fetchedOrders.first.tableId, tableId);
    // });

    // test('Deve atualizar status do pedido', () async {
    //   final orderId = 2002;

    //   final newOrder = Order(
    //     orderId: orderId,
    //     dishId: 101,
    //     quantity: 1,
    //     unitPrice: 25.00,
    //     status: "Aberto",
    //   );

    //   final savedOrder = await orderDishService.saveOrderDish(newOrder);

    //   await orderDishService.updateOrderDishStatus(savedOrder.id!, "Fechado");

    //   final updatedOrder = await orderDishService.getOrderDishById(savedOrder.id!);

    //   expect(updatedOrder?.status, "Fechado");
    // });
  });
}
