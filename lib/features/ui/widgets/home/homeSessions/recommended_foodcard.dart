import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoeats/core/constants/colors.dart';
import 'package:neoeats/core/providers/food_provider.dart';
import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/ui/pages/details/details_page.dart';

class RecommendedFoodCard extends ConsumerWidget {
  const RecommendedFoodCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedFoodProvider.notifier).state = Dish(
          name: 'Pizza de Parrila',
          price: 98.00,
          description: 'A pizza parrilla é preparada na grelha...',
          image: 'assets/image/logo.png',
          status: '',
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetailsPage()),
        );
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/image/logo.png',
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pizza de Parrila',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'A pizza parrilla é prepa...',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Text(
                  'R\$ 98.00',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.red,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {},
                  color: AppColors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
