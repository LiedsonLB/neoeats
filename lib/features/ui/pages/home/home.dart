import 'package:flutter/material.dart';
import 'package:neoeats/features/ui/pages/sessions/home_session.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/image/logo.png', height: 40),
            const Spacer(),
            const Icon(Icons.sunny, color: Colors.black),
            const SizedBox(width: 16),
            const Icon(Icons.person, color: Colors.black),
          ],
        ),
      ),
      body: const HomeSession(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              size: 30,
            ),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 30,
            ),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
