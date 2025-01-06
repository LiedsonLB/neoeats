import 'package:neoeats/features/data/models/order_model.dart';
import 'package:neoeats/features/domain/repositories/order_repository.dart';

class SaveOrder {
  final OrderRepository orderRepository;

  SaveOrder(this.orderRepository);

  Future<Order> call(Order order) async {
    try {
      return await orderRepository.saveOrder(order);
    } catch (e) {
      rethrow;
    }
  }
}