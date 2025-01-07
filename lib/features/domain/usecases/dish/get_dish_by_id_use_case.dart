import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/domain/repositories/dish_repository.dart';

class GetDishByIdUseCase {
  final DishRepository _dishRepository;

  GetDishByIdUseCase(this._dishRepository);

  Future<Dish> call(int id) {
    return _dishRepository.fetchDishById(id);
  }
}