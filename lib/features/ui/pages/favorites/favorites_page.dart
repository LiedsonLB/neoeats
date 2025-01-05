import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:neoeats/core/constants/colors.dart';
import 'package:neoeats/features/ui/widgets/favorites/favorite_list.dart';
import 'package:neoeats/features/ui/widgets/favorites/order_history_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> weekdaySpots = [
      FlSpot(0, 5),
      FlSpot(1, 7),
      FlSpot(2, 3),
      FlSpot(3, 8),
      FlSpot(4, 6),
      FlSpot(5, 0),
      FlSpot(6, 0)
    ];

    final List<FlSpot> weekendSpots = [
      FlSpot(0, 0),
      FlSpot(1, 0),
      FlSpot(2, 0),
      FlSpot(3, 0),
      FlSpot(4, 0),
      FlSpot(5, 9),
      FlSpot(6, 7)
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Meus Favoritos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.orange,
                ),
              ),
              const SizedBox(height: 16),
              const SearchBar(),
              const SizedBox(height: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FavoritesList(),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OrderHistoryCard(
                        weekdaySpots: weekdaySpots,
                        weekendSpots: weekendSpots,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Buscar favoritos',
        hintStyle: const TextStyle(
          color: AppColors.black,
          fontSize: 16,
        ),
        prefixIcon: const Icon(Icons.search, color: AppColors.black),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }
}
