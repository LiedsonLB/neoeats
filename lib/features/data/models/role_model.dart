enum RoleType {
  cliente,
  gerente,
  administrador,
}

class RoleModel {
  final int id;
  final RoleType roleType;
  final String descricao;

  RoleModel({
    required this.id,
    required this.roleType,
    required this.descricao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role_type': roleType.toString().split('.').last,
      'descricao': descricao,
    };
  }

  factory RoleModel.fromMap(Map<String, dynamic> map) {
    return RoleModel(
      id: map['id'],
      roleType: RoleType.values.firstWhere((e) => e.toString().split('.').last == map['role_type']),
      descricao: map['descricao'],
    );
  }
}
