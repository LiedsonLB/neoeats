import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/errors/order_item_fetch_failure.dart';
import 'package:neoeats/core/errors/order_item_save_failure.dart';
import 'package:neoeats/features/data/models/order_item_modal.dart';

class OrderItemService {
  final DatabaseService db = DatabaseService.instance;

  Future<OrderItem> saveOrderItem(OrderItem orderItem) async {
    final Map<String, dynamic> data = orderItem.toJson();
    try {
      final id = await db.insert('OrderItem', data);
      return orderItem.copyWith(id: id);
    } catch (e) {
      print("Error while saving order item: $e");
      throw OrderItemSaveFailure('Error saving order item');
    }
  }

  Future<List<OrderItem>> fetchOrderItemsByOrderId(int orderId) async {
    List<Map<String, dynamic>> results = [];
    try {
      results = await db.query(
        'OrderItem',
        where: 'order_id = ?',
        whereArgs: [orderId],
      );
    } catch (e) {
      throw OrderItemFetchFailure('Error fetching order items');
    }

    return results.map((map) {
      var orderItem = OrderItem.fromJson(map);
      return orderItem;
    }).toList();
  }


  Future<List<OrderItem>> fetchAllOrderItems() async {
    List<Map<String, dynamic>> results = [];
    try {
      results = await db.query('OrderItem');
    } catch (e) {
      throw OrderItemFetchFailure('Error fetching all order items');
    }

    return results.map((map) {
      var orderItem = OrderItem.fromJson(map);
      return orderItem;
    }).toList();
  }

  Future<void> updateOrderItemQuantity(int id, int quantity) async {
    try {
      final result = await db.update(
        'OrderItem',
        {'quantity': quantity},
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result == 0) {
        throw OrderItemFetchFailure('Order item not found');
      }
    } catch (e) {
      throw OrderItemFetchFailure('Error updating order item quantity');
    }
  }

  Future<void> deleteOrderItem(int id) async {
    try {
      final result = await db.delete(
        'OrderItem',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result == 0) {
        throw OrderItemFetchFailure('Order item not found');
      }
    } catch (e) {
      throw OrderItemFetchFailure('Error deleting order item');
    }
  }

  Future<OrderItem?> fetchOrderItemById(int id) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'OrderItem',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return OrderItem.fromJson(maps.first);
    } else {
      return null;
    }
  }
}
