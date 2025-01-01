class ClientModel {
  final int? id;
  final String nome;
  final String email;
  final int roleId;
  final String? telefone;
  final String dataCadastro;

  ClientModel({
    this.id,
    required this.nome,
    required this.email,
    required this.roleId,
    this.telefone,
    required this.dataCadastro,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'role_id': roleId,
      'telefone': telefone,
      'data_cadastro': dataCadastro,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      roleId: map['role_id'],
      telefone: map['telefone'],
      dataCadastro: map['data_cadastro'],
    );
  }
}
