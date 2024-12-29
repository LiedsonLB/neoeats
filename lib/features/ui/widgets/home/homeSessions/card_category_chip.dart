import 'package:flutter/material.dart';

class CardCategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CardCategoryChip(
      {super.key, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () => print('Clicou em $label'),
        child: Chip(
          label: Text(label),
          backgroundColor: isSelected ? Colors.red : Colors.grey.shade200,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
