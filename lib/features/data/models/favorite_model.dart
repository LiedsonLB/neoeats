class Favorite {
  final int? id;
  final int clientId;
  final int dishId;

  Favorite({
    this.id,
    required this.clientId,
    required this.dishId,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      clientId: json['client_id'],
      dishId: json['dish_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': clientId,
      'dish_id': dishId,
    };
  }

  Favorite copyWith({int? id, int? clientId, int? dishId}) {
    return Favorite(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      dishId: dishId ?? this.dishId,
    );
  }
}
