import 'package:flutter/material.dart';
import 'package:neoeats/core/constants/colors.dart';
import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/ui/controllers/bloc/dish_bloc.dart';
import 'package:neoeats/features/ui/controllers/state/dish_state.dart';
import 'package:neoeats/features/ui/pages/details/details_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodListPage extends StatelessWidget {
  const FoodListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Pratos"),
        backgroundColor: AppColors.red,
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

class FoodListCard extends StatelessWidget {
  final Dish dish;

  const FoodListCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: dish.image != null
                    ? Image.network(
                        dish.image!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        'https://as2.ftcdn.net/v2/jpg/02/98/69/09/1000_F_298690986_qYbAKr1wNbUtTqZ2YJGm3C737FoetfSZ.jpg', // Adicione uma imagem padrão aqui
                        height: 80,
                        width: 80,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'R\$ ${dish.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  '+',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
