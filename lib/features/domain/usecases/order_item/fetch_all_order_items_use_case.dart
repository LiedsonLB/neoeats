import 'package:neoeats/features/data/models/order_item_modal.dart';
import 'package:neoeats/features/domain/repositories/order_item_repository.dart';

class FetchAllOrderItems {
  final OrderItemRepository orderItemRepository;

  FetchAllOrderItems(this.orderItemRepository);

  Future<List<OrderItem>> call() {
    return orderItemRepository.fetchAllOrderItems();
  }
}