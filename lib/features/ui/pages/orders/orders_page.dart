import 'package:flutter/material.dart';
import 'package:neoeats/features/ui/pages/orders/orders_session.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Meus pedidos',
          style: TextStyle(color: Colors.red,
          fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: const OrdersSession(),
    );
  }
}
