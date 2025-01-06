import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoeats/core/constants/colors.dart';
import 'package:neoeats/core/providers/favorite_provider.dart';
import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/ui/pages/details/details_page.dart';

class FavoriteItem extends ConsumerWidget { 
  final Dish dish;

  const FavoriteItem({super.key, required this.dish});

  @override
  Widget build(BuildContext context, WidgetRef ref) { 
    return GestureDetector(
      onTap: () {
     
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailsPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'R\$ ${dish.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: AppColors.red),
              onPressed: () {
                ref.read(favoriteProvider.notifier).removeFavorite(dish);
              },
            ),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Pedir'),
            ),
          ],
        ),
      ),
    );
  }
}