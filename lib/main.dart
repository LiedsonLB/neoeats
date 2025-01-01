import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoeats/features/ui/navigation/navigation_bar.dart';
import 'package:neoeats/features/ui/navigation/navigation_state.dart';
import 'package:neoeats/features/ui/pages/home/home.dart';
import 'package:neoeats/features/ui/pages/orders/orders_page.dart';
import 'package:neoeats/features/ui/pages/favorites/favorites_page.dart';
import 'package:neoeats/features/ui/pages/orders_status/order_status_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: NeoEatsApp(),
    ),
  );
}

class NeoEatsApp extends ConsumerWidget {
  const NeoEatsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreen = ref.watch(navigationProvider).currentScreen;

    return Scaffold(
      body: _buildScreen(currentScreen),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildScreen(NavigationScreen screen) {
    switch (screen) {
      case NavigationScreen.home:
        return const HomePage();
      case NavigationScreen.orders:
        return const OrdersPage();
      case NavigationScreen.favorites:
        return const FavoritesPage();
      case NavigationScreen.orderStatus:
        return const OrderStatusPage();
    }
  }
}