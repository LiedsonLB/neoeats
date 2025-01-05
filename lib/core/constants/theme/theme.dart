import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neoeats/core/constants/colors.dart';

const String themeBox = 'theme_box';
const String themeKey = 'is_dark_mode';

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final box = await Hive.openBox(themeBox);
    state = box.get(themeKey, defaultValue: false);
  }

  Future<void> toggleTheme() async {
    final box = await Hive.openBox(themeBox);
    state = !state;
    await box.put(themeKey, state);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF9B080E),
      scaffoldBackgroundColor: const Color(0xFFF2F2F2),
      appBarTheme: const AppBarTheme(
        backgroundColor: const Color(0xFFF2F2F2),
        iconTheme: IconThemeData(color: Color(0xFF9B080E)),
        titleTextStyle: TextStyle(
          color: Color(0xFF9B080E),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF9B080E),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9B080E),
          foregroundColor: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
      cardTheme: const CardTheme(
        color: Colors.white,
        shadowColor: Colors.black26,
      ),
      cardColor: Colors.white,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.orange,
      scaffoldBackgroundColor: const Color.fromRGBO(34, 34, 34, 1.0),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF2D2D2D),
        iconTheme: IconThemeData(color: Color(0xFFF55432)),
        titleTextStyle: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.orange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF55432),
          foregroundColor: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2D2D2D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.red.shade50,
        elevation: 2,
      ),
      cardColor: Colors.red.shade50,
    );
  }
}

Future<void> initHive() async {
  await Hive.initFlutter();
  await Hive.openBox(themeBox);
}
