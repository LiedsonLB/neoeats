import 'package:neoeats/features/data/models/order_item_modal.dart';
import 'package:neoeats/features/domain/repositories/order_item_repository.dart';

class SaveOrderItem {
  final OrderItemRepository orderItemRepository;

  SaveOrderItem(this.orderItemRepository);

  Future<OrderItem> call(OrderItem orderItem) {
    return orderItemRepository.saveOrderItem(orderItem);
  }
}