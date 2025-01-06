import 'package:neoeats/features/data/models/order_model.dart';

abstract class OrderRepository {
  Future<Order> saveOrder(Order order);
  Future<List<Order>> fetchOrders();
  Future<Order> fetchOrderById(int id);
  Future<void> updateOrderStatus(int id, String status);
  Future<List<Order>> fetchOrdersByStatus(String status);
  Future<List<Order>> fetchOrdersByTableId(int tableId);
}