class TableModel {
  final int id;
  final int capacidade;
  final String status;

  TableModel({
    required this.id,
    required this.capacidade,
    required this.status,
  });

  factory TableModel.fromMap(Map<String, dynamic> map) {
    return TableModel(
      id: map['id'],
      capacidade: map['capacidade'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'capacidade': capacidade,
      'status': status,
    };
  }
}