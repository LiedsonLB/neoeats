import 'package:neoeats/features/data/models/order_model.dart';
import 'package:neoeats/features/domain/repositories/order_repository.dart';

class FetchOrderById {
  final OrderRepository orderRepository;

  FetchOrderById(this.orderRepository);

  Future<Order> call(int id) async {
    try {
      return await orderRepository.fetchOrderById(id);
    } catch (e) {
      rethrow;
    }
  }
}