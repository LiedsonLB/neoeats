class PaymentModel {
  final int? id;
  final int pedidoId;
  final double valorTotal;
  final String status;
  final String? dataPagamento;
  final String metodoPagamento;

  PaymentModel({
    this.id,
    required this.pedidoId,
    required this.valorTotal,
    required this.status,
    this.dataPagamento,
    required this.metodoPagamento,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pedido_id': pedidoId,
      'valor_total': valorTotal,
      'status': status,
      'data_pagamento': dataPagamento,
      'metodo_pagamento': metodoPagamento,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'],
      pedidoId: map['pedido_id'],
      valorTotal: map['valor_total'],
      status: map['status'],
      dataPagamento: map['data_pagamento'],
      metodoPagamento: map['metodo_pagamento'],
    );
  }
}
