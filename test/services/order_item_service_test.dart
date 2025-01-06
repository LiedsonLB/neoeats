import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/services/client_service.dart';
import 'package:neoeats/core/services/dish_service.dart';
import 'package:neoeats/core/services/order_item_service.dart';
import 'package:neoeats/core/services/order_service.dart';
import 'package:neoeats/features/data/models/client_model.dart';
import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/data/models/order_item_modal.dart';
import 'package:neoeats/features/data/models/order_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('OrderItem service tests', () {
    late DatabaseService databaseService;
    late Database database;
    late OrderItemService orderItemService;
    late OrderDishService orderDishService;
    late DishService dishService;
    late ClientService clientService;

    setUp(() async {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        sqfliteFfiInit();
      }

      databaseFactory = databaseFactoryFfi;
      databaseService = DatabaseService.instance;
      orderItemService = OrderItemService();
      orderDishService = OrderDishService();
      dishService = DishService();
      clientService = ClientService();
      database = await databaseService.database;

      await database.delete('OrderItem');
      await database.delete('OrderDish');
      await database.delete('Dish');
      await database.delete('Client');
    });

    tearDown(() async {
      await DatabaseService.instance.close();
    });

    test('Deve salvar item de pedido', () async {
      Client client = await clientService.saveClient(Client(
        name: 'Liedson',
        email: 'liedaosnawd',
        access: 'client',
        registrationDate: DateTime.now().toIso8601String(),
      ));

      Order savedOrder = await orderDishService.saveOrder(Order(
        orderDate: DateTime.now().toIso8601String(),
        status: 'open',
        userId: client.id!,
        orderItems: [],
      ));

      final newDish = Dish(
        name: 'Pizza',
        description: 'Pepperoni',
        price: 25.00,
        status: 'active',
      );

      final savedDish = await dishService.saveDish(newDish);

      final newOrderItem = OrderItem(
        orderId: savedOrder.id!,
        dishId: savedDish.id!,
        quantity: 2,
        unitPrice: 25.00,
      );

      final savedOrderItem = await orderItemService.saveOrderItem(newOrderItem);

      print('savedOrderItemId: ${savedOrderItem.id}');

      final fetchedOrderItem = await orderItemService.fetchOrderItemById(savedOrderItem.id!);

      print('Fetched order item: $fetchedOrderItem - Saved order item: $savedOrderItem');

      expect(fetchedOrderItem, isNotNull);
      expect(fetchedOrderItem?.orderId, newOrderItem.orderId);
      expect(fetchedOrderItem?.dishId, newOrderItem.dishId);
      expect(fetchedOrderItem?.quantity, newOrderItem.quantity);
      expect(fetchedOrderItem?.unitPrice, newOrderItem.unitPrice);
    });

    test('Deve buscar todos os itens de pedido por orderId', () async {
      Order orderSaved = await orderDishService.saveOrder(Order(
        orderDate: DateTime.now().toIso8601String(),
        status: 'open',
        userId: 1,
        orderItems: [],
      ));

      Dish dishSaved = await dishService.saveDish(Dish(
        name: 'Bergamota Doce',
        description: 'Bergamota',
        price: 2895.00,
        status: 'active',
      )); 

      Dish dishSaved2 = await dishService.saveDish(Dish(
        name: 'Bergamota Azeda',
        description: 'Bergamota',
        price: 34.00,
        status: 'active',
      ));

      final newItem1 = OrderItem(
        orderId: orderSaved.id!,
        dishId: dishSaved.id!,
        quantity: 2,
        unitPrice: 25.00,
      );

      final newItem2 = OrderItem(
        orderId: orderSaved.id!,
        dishId: dishSaved2.id!,
        quantity: 3,
        unitPrice: 15.00,
      );

      await orderItemService.saveOrderItem(newItem1);
      await orderItemService.saveOrderItem(newItem2);

      final fetchedItems = await orderItemService.fetchOrderItemsByOrderId(orderSaved.id!);
      
      // percorrendo a lista de itens de pedido e mostra
      fetchedItems.forEach((element) {
        print('OrderItem: ${element.id} - ${element.orderId} - ${element.dishId} - ${element.quantity} - ${element.unitPrice}');
      });

      // Verificando se o número de itens recuperados está correto
      expect(fetchedItems.length, 2);
      expect(fetchedItems[0].orderId, orderSaved.id);
      expect(fetchedItems[1].orderId, orderSaved.id);
    });

    test('Deve atualizar a quantidade do item no pedido', () async {
      Client client = await clientService.saveClient(Client(
        name: 'Liedson',
        email: 'liedaosnawd',
        access: 'client',
        registrationDate: DateTime.now().toIso8601String(),
      ));

      Order savedOrder = await orderDishService.saveOrder(Order(
        orderDate: DateTime.now().toIso8601String(),
        status: 'open',
        userId: client.id!,
        orderItems: [],
      ));

      Dish dishSaved = await dishService.saveDish(Dish(
        name: 'Pitanga laranja',
        description: 'laranja',
        price: 12345.00,
        status: 'active',
      )); 

      final initialOrderItem = OrderItem(
        orderId: savedOrder.id!,
        dishId: dishSaved.id!,
        quantity: 2,
        unitPrice: 25.00,
      );
      final savedOrderItem = await orderItemService.saveOrderItem(initialOrderItem);

      print('savedOrderItemId-Quantity: ${savedOrderItem.id} - ${savedOrderItem.quantity}');

      await orderItemService.updateOrderItemQuantity(savedOrderItem.id!, 5);

      final updatedOrderItem = await orderItemService.fetchOrderItemById(savedOrderItem.id!);

      print('updatedOrderItem ${updatedOrderItem?.id!} - updatedOrderItem: ${updatedOrderItem?.quantity}');

      expect(updatedOrderItem?.quantity, 5);
    });

    test('Deve excluir um item do pedido', () async {
      Client client = await clientService.saveClient(Client(
        name: 'Liedson',
        email: 'liedaosnawd',
        access: 'client',
        registrationDate: DateTime.now().toIso8601String(),
      ));

      Order savedOrder = await orderDishService.saveOrder(Order(
        orderDate: DateTime.now().toIso8601String(),
        status: 'open',
        userId: client.id!,
        orderItems: [],
      ));

      Dish dishSaved = await dishService.saveDish(Dish(
        name: 'Salsicha Vina',
        description: '38% sal e 62% sicha',
        price: 12345.00,
        status: 'active',
      )); 

      final newOrderItem = OrderItem(
        orderId: savedOrder.id!,
        dishId: dishSaved.id!,
        quantity: 2,
        unitPrice: 25.00,
      );
      final savedOrderItem = await orderItemService.saveOrderItem(newOrderItem);

      print('savedOrderItemId: ${savedOrderItem.id}');

      await orderItemService.deleteOrderItem(savedOrderItem.id!);

      final deletedOrderItem = await orderItemService.fetchOrderItemById(savedOrderItem.id!);

      print('deletedOrderItemId: ${deletedOrderItem?.id}');
      
      expect(deletedOrderItem, isNull);
    });
  });
}
