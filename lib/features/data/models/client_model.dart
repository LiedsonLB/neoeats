class ClientModel {
  final int? id;
  final String nome;
  final String email;
  final String acesso;
  final String? telefone;
  final DateTime? dataCadastro;

  ClientModel({
    this.id,
    required this.nome,
    required this.email,
    required this.acesso,
    this.telefone,
    this.dataCadastro,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'acesso': acesso,
      'telefone': telefone,
      'data_cadastro': dataCadastro?.toIso8601String(),
    };
  }

  factory ClientModel.fromJson(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'],
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      acesso: map['acesso'] ?? '',
      telefone: map['telefone'],
      dataCadastro: map['data_cadastro'] != null
          ? DateTime.parse(map['data_cadastro'])
          : null,
    );
  }
}
