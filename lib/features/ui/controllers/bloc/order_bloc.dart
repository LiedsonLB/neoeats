import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoeats/features/domain/usecases/dish/get_dish_by_id_use_case.dart';
import 'package:neoeats/features/domain/usecases/order_item/fetch_all_order_items_use_case.dart';
import 'package:neoeats/features/domain/usecases/order_item/save_order_item_use_case.dart';
import 'package:neoeats/features/domain/usecases/order_item/update_order-_item_use_case.dart';
import 'package:neoeats/features/ui/controllers/events/order_events.dart';
import 'package:neoeats/features/ui/controllers/state/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final FetchAllOrderItems fetchAllOrderItems;
  final SaveOrderItem saveOrderItem;
  final UpdateOrderItemQuantity updateOrderItemQuantity;
  final GetDishByIdUseCase getDishByIdUseCase;

  OrderBloc({
    required this.fetchAllOrderItems,
    required this.saveOrderItem,
    required this.updateOrderItemQuantity,
    required this.getDishByIdUseCase,
  }) : super(OrderInitial()) {

    on<AddDishToOrderEvent>((event, emit) async {
      try {
        await saveOrderItem(event.orderItem);
        final orders = await fetchAllOrderItems();
        emit(OrderLoaded(orders));
      } catch (e) {
        emit(OrderError('Erro ao adicionar prato ao pedido.'));
      }
    });

    on<FetchDishByIdEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        final dish = await getDishByIdUseCase(event.dishId);
        emit(OrderDishLoaded(dish));
      } catch (e) {
        emit(OrderError('Erro ao carregar prato.'));
      }
    });

    on<FetchOrders>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await fetchAllOrderItems();
        emit(OrderLoaded(orders));
      } catch (e) {
        emit(OrderError('Erro ao carregar pedidos.'));
      }
    });

    on<SaveOrder>((event, emit) async {
      emit(OrderLoading());
      try {
        await saveOrderItem(event.orderItem);
        final orders = await fetchAllOrderItems();
        emit(OrderLoaded(orders));
      } catch (e) {
        emit(OrderError('Erro ao salvar pedido.'));
      }
    });

    on<UpdateOrderQuantity>((event, emit) async {
      emit(OrderLoading());
      try {
        await updateOrderItemQuantity(event.id, event.quantity);
        final orders = await fetchAllOrderItems();
        emit(OrderLoaded(orders));
      } catch (e) {
        emit(OrderError('Erro ao atualizar quantidade do pedido.'));
      }
    });
  }
}
