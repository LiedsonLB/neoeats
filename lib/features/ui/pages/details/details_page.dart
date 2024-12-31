import 'package:flutter/material.dart';
import 'package:neoeats/features/ui/pages/details/details_session.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

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
        title: const Text('Detalhes', 
          style: TextStyle(color: Colors.red,
          fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: const DetailsSession(),
    );
  }
}
