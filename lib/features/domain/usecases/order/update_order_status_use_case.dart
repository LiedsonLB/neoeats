import 'package:neoeats/features/domain/repositories/order_repository.dart';

class UpdateOrderStatus {
  final OrderRepository orderRepository;

  UpdateOrderStatus(this.orderRepository);

  Future<void> call(int id, String status) async {
    try {
      await orderRepository.updateOrderStatus(id, status);
    } catch (e) {
      rethrow;
    }
  }
}