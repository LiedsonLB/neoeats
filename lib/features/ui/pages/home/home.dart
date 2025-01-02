import 'package:flutter/material.dart';
import 'package:neoeats/core/constants/colors.dart';
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
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/image/logo.png', height: 40),
            const Spacer(),
            const Icon(Icons.sunny, color: AppColors.red),
          ],
        ),
      ),
      body: const HomeSession(),
    );
  }
}







