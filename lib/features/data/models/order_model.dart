import 'dart:math';

import 'package:neoeats/features/data/models/order_item_modal.dart';

class Order {
  final int? id;
  final int userId;
  final int? tableId;
  final String orderDate;
  final String status;
  final String orderNumber;
  final List<OrderItem> orderItems;

  Order({
    this.id,
    required this.userId,
    this.tableId,
    required this.orderDate,
    required this.status,
    required this.orderItems,
  }) : orderNumber = _generateOrderNumber();

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      tableId: json['table_id'],
      orderDate: json['order_date'],
      status: json['status'],
      orderItems: (json['order_items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'table_id': tableId,
      'user_id': userId,
      'order_date': orderDate,
      'status': status,
      'order_number': orderNumber,
      'order_items': orderItems.map((item) => item.toJson()).toList(),
    };
  }

  Order copyWith({int? id, int? tableId, String? orderDate, String? status, String? orderNumber, int? userId, List<OrderItem>? orderItems}) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      tableId: tableId ?? this.tableId,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
      orderItems: orderItems ?? this.orderItems,
    );
  }

  static String _generateOrderNumber() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomSuffix = Random().nextInt(10);
    return '#$timestamp$randomSuffix';
  }
}