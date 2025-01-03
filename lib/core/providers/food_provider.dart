import 'package:flutter_riverpod/flutter_riverpod.dart';

class Food {
  final String name;
  final String price;
  final String description;
  final String imageUrl;

  Food({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}

final selectedFoodProvider = StateProvider<Food?>((ref) => null);