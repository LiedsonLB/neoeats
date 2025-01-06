import 'package:neoeats/features/data/models/order_item_modal.dart';

abstract class OrderItemRepository {
  Future<OrderItem> saveOrderItem(OrderItem orderItem);
  Future<List<OrderItem>> fetchOrderItemsByOrderId(int orderId);
  Future<List<OrderItem>> fetchAllOrderItems();
  Future<void> updateOrderItemQuantity(int id, int quantity);
  Future<void> deleteOrderItem(int id);
  Future<OrderItem?> fetchOrderItemById(int id);
}