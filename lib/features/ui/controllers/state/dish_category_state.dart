import 'package:equatable/equatable.dart';
import 'package:neoeats/features/data/models/category_model.dart';

abstract class DishCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DishCategoryInitial extends DishCategoryState {}

class DishCategoryLoading extends DishCategoryState {}

class DishCategoryLoaded extends DishCategoryState {
  final List<Category> categories;

  DishCategoryLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class DishCategoryError extends DishCategoryState {
  final String message;

  DishCategoryError(this.message);

  @override
  List<Object?> get props => [message];
}
