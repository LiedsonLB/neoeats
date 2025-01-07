import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoeats/core/constants/colors.dart';
import 'package:neoeats/features/data/models/order_item_modal.dart';
import 'package:neoeats/features/ui/controllers/bloc/order_bloc.dart';
import 'package:neoeats/features/ui/controllers/events/order_events.dart';

class DetailsSession extends StatelessWidget {
  final int foodId;
  final String foodName;
  final String foodPrice;
  final String foodDescription;
  final String foodImageUrl;

  DetailsSession({
    super.key,
    required this.foodName,
    required this.foodPrice,
    required this.foodDescription,
    required this.foodImageUrl,
    required this.foodId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    foodImageUrl,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          foodName,
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "R\$ ${foodPrice}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          foodDescription,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Categorias:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      'Quantidade',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle),
                          iconSize: 36,
                          onPressed: () {},
                          color: AppColors.red,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '1',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.add_circle),
                          iconSize: 36,
                          onPressed: () {},
                          color: AppColors.red,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      OrderItem orderItem = OrderItem(
                        orderId: 1,
                        dishId: foodId,
                        quantity: 1,
                        unitPrice: double.parse(foodPrice),
                        name: foodName,
                        image: foodImageUrl,
                        description: foodDescription,
                      );

                      context
                          .read<OrderBloc>()
                          .add(AddDishToOrderEvent(orderItem));
                    },
                    child: const Text(
                      'Adicionar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
