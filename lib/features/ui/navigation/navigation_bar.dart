import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoeats/core/constants/colors.dart';
import 'package:neoeats/features/ui/navigation/navigation_state.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).bottomNavigationBarTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, ),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.backgroundColor ?? Colors.red, 
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(
              Icons.home,
              color: AppColors.white,
              size: 30,
            ),
            onPressed: () => ref.read(navigationProvider.notifier).setScreen(NavigationScreen.home),
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: AppColors.white,
              size: 30,
            ),
            onPressed: () => ref.read(navigationProvider.notifier).setScreen(NavigationScreen.orders),
          ),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: AppColors.white,
              size: 30,
            ),
            onPressed: () => ref.read(navigationProvider.notifier).setScreen(NavigationScreen.favorites),
          ),
          IconButton(
            icon: Icon(
              Icons.assignment,
              color: AppColors.white,
              size: 30,
            ),
            onPressed: () => ref.read(navigationProvider.notifier).setScreen(NavigationScreen.orderStatus),
          ),
        ],
      ),
    );
  }
}
