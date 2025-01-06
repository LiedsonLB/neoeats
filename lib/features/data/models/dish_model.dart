import 'package:neoeats/features/data/models/category_model.dart';

class Dish {
  final int? id;
  final String name;
  String? image;
  final String? description;
  final double price;
  final String status;
  List<Category> categories = [];

  Dish({
    this.id,
    required this.name,
    this.image,
    this.description,
    required this.price,
    required this.status,
    this.categories = const [],
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'status': status,
    };
  }

  Dish copyWith({
    int? id,
    String? name,
    String? image,
    String? description,
    double? price,
    String? status,
    List<Category>? categories,
  }) {
    return Dish(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      price: price ?? this.price,
      status: status ?? this.status,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toJsonWithId() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'status': status,
    };
  }
}
