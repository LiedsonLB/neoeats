import 'package:flutter/material.dart';

class CardFoodList extends StatelessWidget {
  const CardFoodList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Image.asset('assets/image/logo.png', height: 80, width: 80),
          const SizedBox(width: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pizza de Parrila',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                'R\$ 98.00',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
