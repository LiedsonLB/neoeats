class Payment {
  final int? id;
  final int orderId;
  final double amount;
  final String paymentDate;
  final String paymentType;

  Payment({
    this.id,
    required this.orderId,
    required this.amount,
    required this.paymentDate,
    required this.paymentType,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      orderId: json['order_id'],
      amount: json['amount'],
      paymentDate: json['payment_date'],
      paymentType: json['payment_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'amount': amount,
      'payment_date': paymentDate,
      'payment_type': paymentType,
    };
  }
}
