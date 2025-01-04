class Category {
  final int? id;
  final String name;

  Category({
    this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  Category copyWith({int? id, String? name}) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
