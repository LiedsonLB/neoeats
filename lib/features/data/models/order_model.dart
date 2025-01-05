import 'dart:math';

class Order {
  final int? id;
  final int userId;
  final int tableId;
  final String orderDate;
  final String status;
  final String orderNumber;

  Order({
    this.id,
    required this.userId,
    required this.tableId,
    required this.orderDate,
    required this.status,
  }) : orderNumber = _generateOrderNumber();

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      tableId: json['table_id'],
      orderDate: json['order_date'],
      status: json['status'],
    );
  }

  static String _generateOrderNumber() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomSuffix = Random().nextInt(10000);
    return 'NEO$timestamp$randomSuffix';
  }

  Map<String, dynamic> toJson() {
    return {
      'table_id': tableId,
      'user_id': userId,
      'order_date': orderDate,
      'status': status,
      'order_number': orderNumber,
    };
  }

  Order copyWith({int? id, int? tableId, String? orderDate, String? status, String? orderNumber, int? userId}) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      tableId: tableId ?? this.tableId,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
    );
  }
}