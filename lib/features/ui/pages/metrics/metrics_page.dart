import 'package:flutter/material.dart';
import 'package:neoeats/features/ui/widgets/metrics/order_chart.dart';
import 'package:neoeats/features/ui/widgets/metrics/period_selector.dart';
import 'package:neoeats/features/ui/widgets/metrics/sales_chart.dart';
import 'package:neoeats/features/ui/widgets/metrics/summary_card.dart';

class MetricsPage extends StatefulWidget {
  const MetricsPage({super.key});

  @override
  State<MetricsPage> createState() => _MetricsPageState();
}

class _MetricsPageState extends State<MetricsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Métricas',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PeriodSelector(),
            const SizedBox(height: 24),
            _buildSummaryCards(),
            const SizedBox(height: 24),
            const SalesChart(),
            const SizedBox(height: 24),
            const OrderChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return const Row(
      children: [
        Expanded(
          child: SummaryCard(title: 'Total de Vendas', value: 'R\$ 12.450,00', icon: Icons.attach_money, color: Colors.green),
        ),
        SizedBox(width: 16),
        Expanded(
          child: SummaryCard(title: 'Total de Pedidos', value: '156', icon: Icons.shopping_bag, color: Colors.blue),
        ),
      ],
    );
  }
}






