import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoeats/features/domain/usecases/category/get_categories_use_case.dart';
import 'package:neoeats/features/ui/controllers/events/category_event.dart';
import 'package:neoeats/features/ui/controllers/state/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryBloc(this.getCategoriesUseCase) : super(CategoryInitial()) {
    on<FetchCategories>((event, emit) async {
      emit(CategoryLoading());

      try {
        final categories = await getCategoriesUseCase();
        emit(CategoryLoaded(categories));
      } catch (e) {
        emit(CategoryError('Erro ao carregar categorias.'));
      }
    });
  }
}
