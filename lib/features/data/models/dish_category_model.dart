class DishCategory {
  final int dishId;
  final int categoryId;

  DishCategory({
    required this.dishId,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      'dish_id': dishId,
      'category_id': categoryId,
    };
  }
}
