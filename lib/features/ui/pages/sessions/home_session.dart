import 'package:flutter/material.dart';
import 'package:neoeats/core/constants/colors.dart';
import 'package:neoeats/features/ui/widgets/home/homeSessions/category_button.dart';
import 'package:neoeats/features/ui/widgets/home/homeSessions/food_listcard.dart';
import 'package:neoeats/features/ui/widgets/home/homeSessions/recommended_foodcard.dart';

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
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'O que vai pedir hoje ?',
                      hintStyle: const TextStyle(
                        color: AppColors.black, 
                        fontSize: 16, 
                      ),
                      prefixIcon: const Icon(Icons.search, color: AppColors.black),
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
                    icon: const Icon(Icons.tune_outlined, color: AppColors.black),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 35,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryButton(label: 'TODOS', isSelected: true),
                  CategoryButton(label: 'CAFÉ', isSelected: false),
                  CategoryButton(label: 'SOBREMESA', isSelected: false),
                  CategoryButton(label: 'FAST FOOD', isSelected: false),
                ],
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
            const SizedBox(height: 20),
            const Text(
              'Todos os pratos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.orange,
              ),
            ),
            const SizedBox(height: 16),
            const Column(
              children: [
                FoodListCard(),
                SizedBox(height: 12),
                FoodListCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
