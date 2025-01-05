import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoeats/core/constants/colors.dart';
import 'package:neoeats/core/providers/food_provider.dart';
import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/ui/controllers/bloc/dish_bloc.dart';
import 'package:neoeats/features/ui/controllers/events/dish_event.dart';
import 'package:neoeats/features/ui/controllers/state/dish_state.dart';
import 'package:neoeats/features/ui/pages/details/details_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodListPage extends ConsumerStatefulWidget {
  const FoodListPage({super.key});

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends ConsumerState<FoodListPage> {
  @override
  void initState() {
    super.initState();
    // Disparando o evento para buscar os pratos
    context.read<DishBloc>().add(FetchDishes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Pratos"),
        backgroundColor: AppColors.red,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<DishBloc, DishState>(
        builder: (context, state) {
          if (state is DishLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DishError) {
            return Center(child: Text('Erro: ${state.message}'));
          } else if (state is DishLoaded) {
            final dishes = state.dishes;
            return ListView.builder(
              itemCount: dishes.length,
              itemBuilder: (context, index) {
                final dish = dishes[index];
                return FoodListCard(dish: dish);
              },
            );
          } else {
            return const Center(child: Text('Nenhum prato encontrado.'));
          }
        },
      ),
    );
  }
}

class FoodListCard extends ConsumerWidget {
  final Dish dish;

  const FoodListCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedFoodProvider.notifier).state = dish;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailsPage(),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: dish.image != null
                  ? Image.network(
                      dish.image!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      'https://as2.ftcdn.net/v2/jpg/02/98/69/09/1000_F_298690986_qYbAKr1wNbUtTqZ2YJGm3C737FoetfSZ.jpg', // Imagem padrão
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'R\$ ${dish.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.red,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 4,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
