import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoeats/core/constants/colors.dart';
import 'package:neoeats/features/ui/controllers/bloc/order_bloc.dart';
import 'package:neoeats/features/ui/controllers/state/order_state.dart';
import 'package:neoeats/features/ui/widgets/orders/order_item_card.dart';

class OrdersSession extends StatelessWidget {
  const OrdersSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Código do pedido',
            style: TextStyle(fontSize: 16),
          ),
          const Text(
            '#907564',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is OrderError) {
                return Center(child: Text('Erro: ${state.message}'));
              } else if (state is OrderLoaded) {
                final orderItems = state.orders;

                // Calcular o valor total
                double totalValue = 0.0;
                for (var orderItem in orderItems) {
                  totalValue += orderItem.unitPrice * orderItem.quantity;
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: orderItems.length,
                    itemBuilder: (context, index) {
                      final orderItem = orderItems[index];
                      return OrderItemCard(orderItem: orderItem);
                    },
                  ),
                );
              } else {
                return const Center(child: Text('Nenhum item no pedido.'));
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        if (state is OrderLoaded) {
                          double totalValue = 0.0;
                          for (var orderItem in state.orders) {
                            totalValue += orderItem.unitPrice * orderItem.quantity;
                          }
                          return Text(
                            'R\$ ${totalValue.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.red,
                            ),
                          );
                        } else {
                          return const Text(
                            'R\$ 0.00',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.red,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Text(
                    'Confirmar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  label: const Icon(Icons.check),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
