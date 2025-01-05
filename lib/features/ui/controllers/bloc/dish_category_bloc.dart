import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoeats/features/domain/usecases/dish/get_categories_for_dish_use_case.dart';
import 'package:neoeats/features/ui/controllers/events/dish_category_event.dart';
import 'package:neoeats/features/ui/controllers/state/dish_category_state.dart';

class DishCategoryBloc extends Bloc<DishCategoryEvent, DishCategoryState> {
  final GetCategoriesForDishUseCase getCategoriesForDishUseCase;

  DishCategoryBloc(this.getCategoriesForDishUseCase) : super(DishCategoryInitial());

  @override
  Stream<DishCategoryState> mapEventToState(DishCategoryEvent event) async* {
    if (event is FetchCategoriesForDish) {
      yield DishCategoryLoading();
      try {
        final categories = await getCategoriesForDishUseCase.call(event.dish);
        yield DishCategoryLoaded(categories);
      } catch (e) {
        yield DishCategoryError('Error fetching categories for dish');
      }
    }
  }
}
