import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoeats/core/constants/colors.dart';
import 'package:neoeats/core/providers/food_provider.dart';
import 'package:neoeats/core/providers/favorite_provider.dart'; 
import 'package:neoeats/features/ui/pages/details/details_session.dart';

class DetailsPage extends ConsumerWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFood = ref.watch(selectedFoodProvider);

    final isFavorite = selectedFood != null
        ? ref.watch(favoriteProvider.notifier).isFavorite(selectedFood)
        : false;

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.orange),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          title: const Text(
            'Detalhes',
            style: TextStyle(
              color: AppColors.orange,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border, 
                  color: AppColors.red,
                ),
                onPressed: () {
                  if (selectedFood != null) {
                    if (isFavorite) {
                      ref.read(favoriteProvider.notifier).removeFavorite(selectedFood);
                    } else {
                      ref.read(favoriteProvider.notifier).addFavorite(selectedFood);
                    }
                  }
                },
              ),
            ),
          ],
        ),
        body: selectedFood != null
            ? DetailsSession(
                foodId: selectedFood.id!,
                foodName: selectedFood.name,
                foodPrice: selectedFood.price.toString(),
                foodDescription: selectedFood.description!,
                foodImageUrl: selectedFood.image!,
              )
            : const Center(
                child: Text('Nenhum prato selecionado.'),
              ),
      ),
    );
  }
}