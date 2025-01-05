import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoeats/features/domain/usecases/dish/get_all_dishes_use_case.dart';
import 'package:neoeats/features/ui/controllers/events/dish_event.dart';
import 'package:neoeats/features/ui/controllers/state/dish_state.dart';

class DishBloc extends Bloc<DishEvent, DishState> {
  final GetAllDishesUseCase getAllDishesUseCase;

  DishBloc(this.getAllDishesUseCase) : super(DishInitial()) {
    on<FetchDishes>((event, emit) async {
      emit(DishLoading());

      try {
        final dishes = await getAllDishesUseCase();
        emit(DishLoaded(dishes));
      } catch (e) {
        emit(DishError('Erro ao carregar pratos.'));
      }
    });
  }
}
