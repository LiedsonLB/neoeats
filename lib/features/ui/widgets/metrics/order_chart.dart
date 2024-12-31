import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OrderChart extends StatelessWidget {
  const OrderChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Total de Pedidos por Período',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups: [
                BarChartGroupData(x: 0, barRods: [
                  BarChartRodData(toY: 15, color: Colors.red)
                ]),
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(toY: 20, color: Colors.red)
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(toY: 18, color: Colors.red)
                ]),
                BarChartGroupData(x: 3, barRods: [
                  BarChartRodData(toY: 25, color: Colors.red)
                ]),
                BarChartGroupData(x: 4, barRods: [
                  BarChartRodData(toY: 22, color: Colors.red)
                ]),
                BarChartGroupData(x: 5, barRods: [
                  BarChartRodData(toY: 28, color: Colors.red)
                ]),
                BarChartGroupData(x: 6, barRods: [
                  BarChartRodData(toY: 24, color: Colors.red)
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}