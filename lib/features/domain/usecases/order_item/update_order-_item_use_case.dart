import 'package:neoeats/features/domain/repositories/order_item_repository.dart';

class UpdateOrderItemQuantity {
  final OrderItemRepository orderItemRepository;

  UpdateOrderItemQuantity(this.orderItemRepository);

  Future<void> call(int id, int quantity) {
    return orderItemRepository.updateOrderItemQuantity(id, quantity);
  }
}