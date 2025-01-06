import 'package:neoeats/features/domain/repositories/order_item_repository.dart';

class DeleteOrderItem {
  final OrderItemRepository orderItemRepository;

  DeleteOrderItem(this.orderItemRepository);

  Future<void> call(int id) {
    return orderItemRepository.deleteOrderItem(id);
  }
}