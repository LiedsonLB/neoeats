import 'package:flutter/material.dart';
import 'package:neoeats/features/ui/pages/home/home.dart';

void main() {
  runApp(NeoEatsApp());
}

class NeoEatsApp extends StatelessWidget {
  const NeoEatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: const HomePage(),
    );
  }
}