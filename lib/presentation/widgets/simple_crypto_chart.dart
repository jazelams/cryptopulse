import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SimpleCryptoChart extends StatelessWidget {
  final List<FlSpot> spots;
  final Color chartColor;

  const SimpleCryptoChart({
    super.key,
    required this.spots,
    required this.chartColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),

          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              barWidth: 3,
              color: chartColor,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    chartColor.withValues(alpha: 0.3),
                    chartColor.withValues(alpha: 0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
