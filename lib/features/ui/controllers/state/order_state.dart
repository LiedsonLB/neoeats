import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/data/models/order_item_modal.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderItem> orders;

  OrderLoaded(this.orders);
}

class OrderError extends OrderState {
  final String message;

  OrderError(this.message);
}

class OrderUpdated extends OrderState {
  final List<OrderItem> orderItems;

  OrderUpdated(this.orderItems);
}

class OrderDishLoaded extends OrderState {
  final Dish dish;

  OrderDishLoaded(this.dish);
}

class OrderSaved extends OrderState {}