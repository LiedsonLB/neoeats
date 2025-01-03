import 'package:flutter/material.dart';
import 'package:neoeats/core/constants/colors.dart';
import 'package:neoeats/features/ui/widgets/favorites/favorite_item.dart';

class FavoritesList extends StatelessWidget {
  final List<Map<String, String>> items = const [
    {'name': 'Pizza Margherita', 'price': 'R\$ 45,90'},
    {'name': 'Hambúrguer Especial', 'price': 'R\$ 32,90'},
    {'name': 'Salada Caesar', 'price': 'R\$ 28,90'},
  ];

  const FavoritesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pratos Favoritos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.red,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) => FavoriteItem(
                  name: items[index]['name']!,
                  price: items[index]['price']!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}