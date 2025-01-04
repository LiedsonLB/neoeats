class Order {
  final int? id;
  final int tableId;
  final String orderDate;
  final String status;

  Order({
    this.id,
    required this.tableId,
    required this.orderDate,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      tableId: json['table_id'],
      orderDate: json['order_date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'table_id': tableId,
      'order_date': orderDate,
      'status': status,
    };
  }
}
