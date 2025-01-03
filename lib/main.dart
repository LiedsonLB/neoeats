import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoeats/core/constants/theme/theme.dart';
import 'package:neoeats/features/ui/navigation/navigation_bar.dart';
import 'package:neoeats/features/ui/navigation/navigation_state.dart';
import 'package:neoeats/features/ui/pages/home/home.dart';
import 'package:neoeats/features/ui/pages/orders/orders_page.dart';
import 'package:neoeats/features/ui/pages/favorites/favorites_page.dart';
import 'package:neoeats/features/ui/pages/orders_status/order_status_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  
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
    final isDarkMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreen = ref.watch(navigationProvider).currentScreen;

    return Scaffold(
      appBar: _buildAppBar(context, ref, currentScreen),
      body: _buildScreen(currentScreen),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  AppBar? _buildAppBar(BuildContext context, WidgetRef ref, NavigationScreen screen) {
    if (screen == NavigationScreen.home) {
      return AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/image/logo.png', height: 40),
                const SizedBox(width: 8),
                const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    'NEOEATS',
                    style: TextStyle(
                      fontFamily: 'Anton',   
                      fontSize: 24,                  
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                ref.watch(themeProvider) ? Icons.dark_mode : Icons.light_mode,
              ),
              onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
            ),
          ],
        ),
      );
    }
    return null;
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
