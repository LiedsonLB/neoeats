import 'package:equatable/equatable.dart';
import 'package:neoeats/features/data/models/dish_model.dart';

abstract class DishState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DishInitial extends DishState {}

class DishLoading extends DishState {}

class DishLoaded extends DishState {
  final List<Dish> dishes;

  DishLoaded(this.dishes);

  @override
  List<Object?> get props => [dishes];
}

class DishError extends DishState {
  final String message;

  DishError(this.message);

  @override
  List<Object?> get props => [message];
}
