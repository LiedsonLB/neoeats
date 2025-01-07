import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/data/models/order_item_modal.dart';

abstract class OrderEvent {}

class FetchOrders extends OrderEvent {}

class SaveOrder extends OrderEvent {
  final OrderItem orderItem;

  SaveOrder(this.orderItem);
}

class UpdateOrderQuantity extends OrderEvent {
  final int id;
  final int quantity;

  UpdateOrderQuantity(this.id, this.quantity);
}

class AddDishToOrderEvent extends OrderEvent {
  final OrderItem orderItem;

  AddDishToOrderEvent(this.orderItem);
}
class RemoveDishFromOrder extends OrderEvent {
  final Dish dish;
  RemoveDishFromOrder(this.dish);
}

class FetchDishByIdEvent extends OrderEvent {
  final int dishId;

  FetchDishByIdEvent(this.dishId);
}