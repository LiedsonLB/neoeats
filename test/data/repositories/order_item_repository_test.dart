import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/features/data/models/order_item_modal.dart';
import 'package:neoeats/features/data/repositories/order_item_repository_impl.dart';
import 'package:neoeats/core/services/order_item_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('OrderItemRepositoryImpl', () {
    late OrderItemRepositoryImpl orderItemRepository;
    late OrderItemService orderItemService;
    late DatabaseService db;
    late Database database;

    setUp(() {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        sqfliteFfiInit();
      }

      databaseFactory = databaseFactoryFfi;

      db = DatabaseService.instance;
      orderItemService = OrderItemService();
      orderItemRepository = OrderItemRepositoryImpl(orderItemService);
    });

    test('deve salvar um item de pedido', () async {
      final orderItem = OrderItem(
        orderId: 1,
        dishId: 10,
        quantity: 2,
        unitPrice: 20.0,
      );

      final savedOrderItem = await orderItemRepository.saveOrderItem(orderItem);

      expect(savedOrderItem.orderId, equals(orderItem.orderId));
      expect(savedOrderItem.dishId, equals(orderItem.dishId));
      expect(savedOrderItem.quantity, equals(orderItem.quantity));
      expect(savedOrderItem.unitPrice, equals(orderItem.unitPrice));
    });

    test('deve buscar todos os itens de pedido', () async {
      final orderItems = [
        OrderItem(orderId: 1, dishId: 10, quantity: 2, unitPrice: 20.0),
        OrderItem(orderId: 2, dishId: 15, quantity: 1, unitPrice: 15.0),
      ];

      await orderItemRepository.saveOrderItem(orderItems[0]);
      await orderItemRepository.saveOrderItem(orderItems[1]);

      final fetchedOrderItems = await orderItemRepository.fetchAllOrderItems();

      expect(fetchedOrderItems.length, equals(2));
      expect(fetchedOrderItems[0].orderId, equals(orderItems[0].orderId));
      expect(fetchedOrderItems[1].orderId, equals(orderItems[1].orderId));
    });

    test('deve buscar um item de pedido pelo ID', () async {
      final orderItem = OrderItem(
        orderId: 1,
        dishId: 10,
        quantity: 2,
        unitPrice: 20.0,
      );

      await orderItemRepository.saveOrderItem(orderItem);

      final fetchedOrderItem = await orderItemRepository.fetchOrderItemById(1);

      expect(fetchedOrderItem?.id, equals(orderItem.id));
      expect(fetchedOrderItem?.orderId, equals(orderItem.orderId));
    });

    test('deve deletar um item de pedido', () async {
      final orderItem = OrderItem(
        orderId: 1,
        dishId: 10,
        quantity: 2,
        unitPrice: 20.0,
      );

      await orderItemRepository.saveOrderItem(orderItem);

      await orderItemRepository.deleteOrderItem(1);

      final fetchedOrderItem = await orderItemRepository.fetchOrderItemById(1);

      expect(fetchedOrderItem, isNull);
    });
  });
}
