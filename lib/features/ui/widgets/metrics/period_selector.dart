import 'package:flutter/material.dart';

class PeriodSelector extends StatelessWidget {
  const PeriodSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton<String>(
          value: 'Últimos 7 dias',
          items: ['Últimos 7 dias', 'Último mês', 'Último ano']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (value) {},
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.calendar_today, color: Colors.red),
          label: const Text(
            'Período personalizado',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
