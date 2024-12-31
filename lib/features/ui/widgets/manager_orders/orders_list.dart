import 'package:flutter/material.dart';
import 'package:neoeats/features/ui/widgets/manager_orders/order_card.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => const OrderCard(),
      ),
    );
  }
}