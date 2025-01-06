import 'package:neoeats/core/services/order_service.dart';
import 'package:neoeats/features/data/models/order_model.dart';
import 'package:neoeats/features/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDishService orderDishService;

  OrderRepositoryImpl(this.orderDishService);

  @override
  Future<Order> saveOrder(Order order) async {
    return await orderDishService.saveOrder(order);
  }

  @override
  Future<List<Order>> fetchOrders() async {
    return await orderDishService.fetchOrders();
  }

  @override
  Future<Order> fetchOrderById(int id) async {
    return await orderDishService.fetchOrderById(id);
  }

  @override
  Future<void> updateOrderStatus(int id, String status) async {
    await orderDishService.updateOrderStatus(id, status);
  }

  @override
  Future<List<Order>> fetchOrdersByStatus(String status) async {
    return await orderDishService.fetchOrdersByStatus(status);
  }

  @override
  Future<List<Order>> fetchOrdersByTableId(int tableId) async {
    return await orderDishService.fetchOrdersByTableId(tableId);
  }
}