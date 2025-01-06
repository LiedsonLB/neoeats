import 'package:neoeats/features/data/models/order_model.dart';
import 'package:neoeats/features/domain/repositories/order_repository.dart';

class FetchOrdersByStatus {
  final OrderRepository orderRepository;

  FetchOrdersByStatus(this.orderRepository);

  Future<List<Order>> call(String status) async {
    try {
      return await orderRepository.fetchOrdersByStatus(status);
    } catch (e) {
      rethrow;
    }
  }
}