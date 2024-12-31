import 'package:flutter/material.dart';

class DetailsSession extends StatelessWidget {
  const DetailsSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/image/logo.png',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pizza de Parrila',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'R\$ 98.00',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'A pizza parrilla é preparada na grelha, o que deixa a massa crocante, macia e com um toque defumado. Coberta com ingredientes frescos, oferece um sabor único e autêntico.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle),
                      iconSize: 32,
                      onPressed: () {},
                      color: Colors.red,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '1',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      iconSize: 32,
                      onPressed: () {},
                      color: Colors.red,
                    ),
                  ],
                ),
                SizedBox(
                  height: 45, 
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Adicionar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
