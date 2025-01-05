import 'package:equatable/equatable.dart';

abstract class DishEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDishes extends DishEvent {}
