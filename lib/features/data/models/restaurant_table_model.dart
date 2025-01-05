class RestaurantTable {
  final int? id;
  final int capacity;
  final String status;

  RestaurantTable({
    this.id,
    required this.capacity,
    required this.status,
  });

  factory RestaurantTable.fromJson(Map<String, dynamic> json) {
    return RestaurantTable(
      id: json['id'],
      capacity: json['capacity'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'capacity': capacity,
      'status': status,
    };
  }

  RestaurantTable copyWith({int? id}) {
    return RestaurantTable(
      id: id ?? this.id,
      capacity: this.capacity,
      status: this.status,
    );
  }
}
