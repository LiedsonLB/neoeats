class OrderItem {
  final int? id;
  final int? orderId;
  final int dishId;
  final int quantity;
  final double unitPrice;
  final String? name;
  String? image;
  final String? description;

  OrderItem({
    this.id,
    required this.orderId,
    required this.dishId,
    required this.quantity,
    required this.unitPrice,
    this.name,
    this.image,
    this.description,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['order_id'],
      dishId: json['dish_id'],
      quantity: json['quantity'],
      unitPrice: json['unit_price'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'dish_id': dishId,
      'quantity': quantity,
      'unit_price': unitPrice,
      'name': name,
      'image': image,
      'description': description,
    };
  }

  OrderItem copyWith({
    int? id,
    int? orderId,
    int? dishId,
    int? quantity,
    double? unitPrice,
    String? name,
    String? image,
    String? description,
  }) {
    return OrderItem(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      dishId: dishId ?? this.dishId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }
}
