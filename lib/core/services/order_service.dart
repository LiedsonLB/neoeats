import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/errors/order_fetch_failure.dart';
import 'package:neoeats/core/errors/order_save_failure.dart';
import 'package:neoeats/features/data/models/order_model.dart';

class OrderDishService {
  final DatabaseService db = DatabaseService.instance;

  Future<Order> saveOrder(Order order) async {
    if(order.tableId != null) {
      final table = await db.query('RestaurantTable', where: 'id = ?', whereArgs: [order.tableId]);
      if(table.isNotEmpty) {
        await db.update('RestaurantTable', {'status': 'occupied'}, where: 'id = ?', whereArgs: [order.tableId]);
      } else{
        throw OrderSaveFailure('Table not found');
      }
    }

    final Map<String, dynamic> data = {
      'table_id': order.tableId,
      'user_id': order.userId,
      'order_date': order.orderDate,
      'status': order.status,
      'order_number': order.orderNumber,
    };

    try {
      final orderId = await db.insert('OrderDish', data);

      for (final item in order.orderItems) {
        await db.insert('OrderItem', item.copyWith(orderId: orderId).toJson());
      }

      return order.copyWith(id: orderId);
    } catch (e) {
      print("Error while saving order: $e");
      throw OrderSaveFailure('Error saving order');
    }
  }

  Future<List<Order>> fetchOrders() async {
    List<Map<String, dynamic>> results = [];
    try {
      results = await db.query('OrderDish');
    } catch (e) {
      throw OrderFetchFailure('Orders not found');
    }

    return results.map((map) {
      var order = Order.fromJson(map);
      return order;
    }).toList();
  }

  Future<Order> fetchOrderById(int id) async {
    List<Map<String, dynamic>> results = [];
    try {
      results = await db.query('OrderDish',
          where: 'id = ?', whereArgs: [id]);

      if (results.isEmpty) {
        throw OrderFetchFailure('Order not found');
      }

      final orderItems = await db.query(
        'OrderItem',
        where: 'order_id = ?',
        whereArgs: [results.first['id']],
      );

      final orderJson = {
      ...results.first,
      'order_items': orderItems,
    };
    
    return Order.fromJson(orderJson);
    } catch (e) {
      throw OrderFetchFailure('Error fetching order');
    }
  }

  Future<void> updateOrderStatus(int id, String status) async {
    try {
      final result = await db.update(
        'OrderDish',
        {'status': status},
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result == 0) {
        throw OrderFetchFailure('Order not found');
      }
    } catch (e) {
      throw OrderFetchFailure('Error updating order status');
    }
  }

  Future<List<Order>> fetchOrdersByStatus(String status) async {
    List<Map<String, dynamic>> results = [];
    try {
      results = await db.query(
        'OrderDish',
        where: 'status = ?',
        whereArgs: [status],
      );
    } catch (e) {
      throw OrderFetchFailure('Error fetching orders by status');
    }

    return results.map((map) {
      var order = Order.fromJson(map);
      return order;
    }).toList();
  }

  Future<List<Order>> fetchOrdersByTableId(int tableId) async {
    List<Map<String, dynamic>> results = [];
    try {
      results = await db.query(
        'OrderDish',
        where: 'table_id = ?',
        whereArgs: [tableId],
      );
    } catch (e) {
      throw OrderFetchFailure('Error fetching orders for table');
    }

    return results.map((map) {
      var order = Order.fromJson(map);
      return order;
    }).toList();
  }
}
