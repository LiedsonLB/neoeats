import 'package:flutter/material.dart';
import 'package:neoeats/features/ui/widgets/home/homeSessions/card_category_chip.dart';
import 'package:neoeats/features/ui/widgets/home/homeSessions/card_food_list.dart';
import 'package:neoeats/features/ui/widgets/home/homeSessions/card_food_session.dart';

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
            TextField(
              decoration: InputDecoration(
                hintText: 'O que vai pedir hoje?',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CardCategoryChip(label: 'Todos', isSelected: true),
                  CardCategoryChip(label: 'Café', isSelected: false),
                  CardCategoryChip(label: 'Sobremesa', isSelected: false),
                  CardCategoryChip(label: 'Fast Food', isSelected: false),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pratos Recomendados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CardFoodSession(),
                  CardFoodSession(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Todos os pratos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Column(
              children: [
                CardFoodList(),
                CardFoodList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
