import 'package:neoeats/core/services/order_item_service.dart';
import 'package:neoeats/features/data/models/order_item_modal.dart';
import 'package:neoeats/features/domain/repositories/order_item_repository.dart';

class OrderItemRepositoryImpl implements OrderItemRepository {
  final OrderItemService orderItemService;

  OrderItemRepositoryImpl(this.orderItemService);

  @override
  Future<OrderItem> saveOrderItem(OrderItem orderItem) {
    return orderItemService.saveOrderItem(orderItem);
  }

  @override
  Future<List<OrderItem>> fetchOrderItemsByOrderId(int orderId) {
    return orderItemService.fetchOrderItemsByOrderId(orderId);
  }

  @override
  Future<List<OrderItem>> fetchAllOrderItems() {
    return orderItemService.fetchAllOrderItems();
  }

  @override
  Future<void> updateOrderItemQuantity(int id, int quantity) {
    return orderItemService.updateOrderItemQuantity(id, quantity);
  }

  @override
  Future<void> deleteOrderItem(int id) {
    return orderItemService.deleteOrderItem(id);
  }

  @override
  Future<OrderItem?> fetchOrderItemById(int id) {
    return orderItemService.fetchOrderItemById(id);
  }
}