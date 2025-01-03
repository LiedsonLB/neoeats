import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoeats/core/constants/colors.dart';
import 'package:neoeats/core/providers/food_provider.dart';
import 'package:neoeats/features/ui/pages/details/details_session.dart';

class DetailsPage extends ConsumerWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFood = ref.watch(selectedFoodProvider);

      return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, 
          elevation: 0,
          title: Text(
            'Detalhes',
            style: const TextStyle(
              color: AppColors.orange,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_border, color: AppColors.red),
              onPressed: () {},
            ),
          ],
        ),
        body: selectedFood != null
            ? DetailsSession(
                foodName: selectedFood.name,
                foodPrice: selectedFood.price,
                foodDescription: selectedFood.description,
                foodImageUrl: selectedFood.imageUrl,
              )
            : const Center(
                child: Text('Nenhum prato selecionado.'),
              ),
      ),
    );
  }
}