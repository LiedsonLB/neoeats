import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neoeats/features/data/models/dish_model.dart';

final selectedFoodProvider = StateProvider<Dish?>((ref) => null);