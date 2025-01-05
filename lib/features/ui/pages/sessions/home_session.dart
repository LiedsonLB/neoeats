import 'package:flutter/material.dart';
import 'package:neoeats/core/constants/colors.dart';
import 'package:neoeats/features/ui/controllers/bloc/category_bloc.dart';
import 'package:neoeats/features/ui/controllers/state/category_state.dart';
import 'package:neoeats/features/ui/widgets/home/homeSessions/category_button.dart';
import 'package:neoeats/features/ui/widgets/home/homeSessions/food_listcard.dart';
import 'package:neoeats/features/ui/widgets/home/homeSessions/recommended_foodcard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoeats/features/ui/controllers/bloc/dish_bloc.dart';
import 'package:neoeats/features/ui/controllers/state/dish_state.dart';

class HomeSession extends StatefulWidget {
  const HomeSession({super.key});

  @override
  State<HomeSession> createState() => _HomeSessionState();
}

class _HomeSessionState extends State<HomeSession> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'O que vai pedir hoje ?',
                      hintStyle: const TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                      ),
                      prefixIcon:
                          const Icon(Icons.search, color: AppColors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: IconButton(
                    icon:
                        const Icon(Icons.tune_outlined, color: AppColors.black),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 50,
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CategoryError) {
                    return Center(child: Text('Erro: ${state.message}'));
                  } else if (state is CategoryLoaded) {
                    final categories = state.categories;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return CategoryButton(
                            label: category.name, isSelected: index == 0);
                      },
                    );
                  } else {
                    return const Center(
                        child: Text('Nenhuma categoria encontrada.'));
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pratos Recomendados',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.orange,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  RecommendedFoodCard(),
                  RecommendedFoodCard(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Todos os pratos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.orange,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: BlocBuilder<DishBloc, DishState>(
                builder: (context, state) {
                  if (state is DishLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DishError) {
                    return Center(child: Text('Erro: ${state.message}'));
                  } else if (state is DishLoaded) {
                    final dishes = state.dishes;
                    return Column(
                      children: dishes.map((dish) {
                        return FoodListCard(
                            dish: dish); // Exibe os pratos um abaixo do outro
                      }).toList(),
                    );
                  } else {
                    return const Center(
                      child: Text('Nenhum prato encontrado.'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
