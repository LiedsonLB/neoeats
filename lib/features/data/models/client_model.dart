class Client {
  final int? id;
  final String name;
  final String email;
  final String access;
  final String? phone;
  final String registrationDate;

  Client({
    this.id,
    required this.name,
    required this.email,
    required this.access,
    this.phone,
    required this.registrationDate,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      access: json['access'],
      phone: json['phone'],
      registrationDate: json['registration_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'access': access,
      'phone': phone,
      'registration_date': registrationDate,
    };
  }

  Client copyWith({
    int? id,
    String? name,
    String? email,
    String? access,
    String? phone,
    String? registrationDate,
  }) {
    return Client(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      access: access ?? this.access,
      phone: phone ?? this.phone,
      registrationDate: registrationDate ?? this.registrationDate,
    );
  }
}
