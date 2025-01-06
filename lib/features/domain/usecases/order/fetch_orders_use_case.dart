import 'package:neoeats/features/data/models/order_model.dart';
import 'package:neoeats/features/domain/repositories/order_repository.dart';

class FetchOrders {
  final OrderRepository orderRepository;

  FetchOrders(this.orderRepository);

  Future<List<Order>> call() async {
    try {
      return await orderRepository.fetchOrders();
    } catch (e) {
      rethrow;
    }
  }
}
