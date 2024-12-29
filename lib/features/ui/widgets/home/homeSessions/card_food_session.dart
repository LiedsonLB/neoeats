import 'package:flutter/material.dart';

class CardFoodSession extends StatelessWidget {
  const CardFoodSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset('assets/image/logo.png', height: 80, width: 80),
          const SizedBox(height: 8),
          const Text('Pizza de Parrila',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const Text(
            'R\$ 98.00',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
