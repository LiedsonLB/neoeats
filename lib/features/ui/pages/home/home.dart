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
    return const Scaffold(
      body: HomeSession(),
    );
  }
}
