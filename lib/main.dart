import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoeats/core/constants/theme/theme.dart';
import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/services/category_service.dart';
import 'package:neoeats/core/services/dish_service.dart';
import 'package:neoeats/core/services/order_item_service.dart';
import 'package:neoeats/features/data/repositories/category_repository_impl.dart';
import 'package:neoeats/features/data/repositories/dish_repository_impl.dart';
import 'package:neoeats/features/data/repositories/order_item_repository_impl.dart';
import 'package:neoeats/features/domain/usecases/category/get_categories_use_case.dart';
import 'package:neoeats/features/domain/usecases/dish/get_all_dishes_use_case.dart';
import 'package:neoeats/features/domain/usecases/dish/get_dish_by_id_use_case.dart';
import 'package:neoeats/features/domain/usecases/order_item/fetch_all_order_items_use_case.dart';
import 'package:neoeats/features/domain/usecases/order_item/save_order_item_use_case.dart';
import 'package:neoeats/features/domain/usecases/order_item/update_order-_item_use_case.dart';
import 'package:neoeats/features/ui/controllers/bloc/category_bloc.dart';
import 'package:neoeats/features/ui/controllers/bloc/dish_bloc.dart';
import 'package:neoeats/features/ui/controllers/bloc/order_bloc.dart';
import 'package:neoeats/features/ui/controllers/events/category_event.dart';
import 'package:neoeats/features/ui/controllers/events/dish_event.dart';
import 'package:neoeats/features/ui/controllers/events/order_events.dart';
import 'package:neoeats/features/ui/navigation/navigation_bar.dart';
import 'package:neoeats/features/ui/navigation/navigation_state.dart';
import 'package:neoeats/features/ui/pages/home/home.dart';
import 'package:neoeats/features/ui/pages/orders/orders_page.dart';
import 'package:neoeats/features/ui/pages/favorites/favorites_page.dart';
import 'package:neoeats/features/ui/pages/orders_status/order_status_page.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
  }

  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.instance.database;

  await initHive();
  final categoryRepository =
      CategoryRepositoryImpl(categoryService: CategoryService());
  final getCategoriesUseCase = GetCategoriesUseCase(categoryRepository);
  final dishRepository = DishRepositoryImpl(dishService: DishService());
  final getAllDishesUseCase =
      GetAllDishesUseCase(dishRepository: dishRepository);
  final orderItemService = OrderItemService();
  final orderItemRepository = OrderItemRepositoryImpl(orderItemService);
  final fetchAllOrderItems = FetchAllOrderItems(orderItemRepository);
  final saveOrderItem = SaveOrderItem(orderItemRepository);
  final updateOrderItemQuantity = UpdateOrderItemQuantity(orderItemRepository);
  final getDishByIdUseCase = GetDishByIdUseCase(dishRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              CategoryBloc(getCategoriesUseCase)..add(FetchCategories()),
        ),
        BlocProvider(
          create: (_) => DishBloc(getAllDishesUseCase)..add(FetchDishes()),
        ),
        BlocProvider(
          create: (_) => OrderBloc(
            fetchAllOrderItems: fetchAllOrderItems,
            saveOrderItem: saveOrderItem,
            updateOrderItemQuantity: updateOrderItemQuantity,
            getDishByIdUseCase: getDishByIdUseCase,
          )..add(FetchOrders()),
        ),
      ],
      child: const ProviderScope(
        child: NeoEatsApp(),
      ),
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

  AppBar? _buildAppBar(
      BuildContext context, WidgetRef ref, NavigationScreen screen) {
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
