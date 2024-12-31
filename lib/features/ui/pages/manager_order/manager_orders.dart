import 'package:flutter/material.dart';
import 'package:neoeats/features/ui/widgets/manager_orders/orders_filter.dart';
import 'package:neoeats/features/ui/widgets/manager_orders/orders_list.dart';

class ManagerOrdersPage extends StatelessWidget {
  const ManagerOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Gerenciamento de Pedidos',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrdersFilter(),
            SizedBox(height: 16),
            OrdersList(),
          ],
        ),
      ),
    );
  }
}





