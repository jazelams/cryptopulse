import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> crypto;

  const DetailsScreen({super.key, required this.crypto});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String _selectedTimeframe = '24H';

  // Datos con muchísima más volatilidad, simulando el caos del mercado real
  final Map<String, List<FlSpot>> _chartData = {
    '24H': const [
      FlSpot(0, 60.0), FlSpot(1, 61.2), FlSpot(2, 60.5), FlSpot(3, 62.8),
      FlSpot(4, 61.9), FlSpot(5, 63.4), FlSpot(6, 62.1), FlSpot(7, 64.5),
      FlSpot(8, 63.0), FlSpot(9, 65.2), FlSpot(10, 64.1), FlSpot(11, 66.0),
      FlSpot(12, 65.5), FlSpot(13, 64.2), // Cierra en positivo (Verde)
    ],
    '1S': const [
      FlSpot(0, 68.0), FlSpot(1, 67.5), FlSpot(2, 69.1), FlSpot(3, 65.4),
      FlSpot(4, 66.8), FlSpot(5, 63.2), FlSpot(6, 64.5), FlSpot(7, 61.0),
      FlSpot(8, 62.3), FlSpot(9, 59.8), FlSpot(10, 60.5), FlSpot(11, 58.1),
      FlSpot(12, 59.5),
      FlSpot(13, 57.2), // Mercado sangrando, cierra en negativo (Rojo)
    ],
    '1M': const [
      FlSpot(0, 45.0), FlSpot(1, 48.5), FlSpot(2, 47.0), FlSpot(3, 52.3),
      FlSpot(4, 50.8), FlSpot(5, 55.4), FlSpot(6, 53.9), FlSpot(7, 58.1),
      FlSpot(8, 56.5), FlSpot(9, 60.2), FlSpot(10, 59.0), FlSpot(11, 63.5),
      FlSpot(12, 62.1), FlSpot(13, 64.2), // Tendencia alcista fuerte (Verde)
    ],
    '1A': const [
      FlSpot(0, 25.0), FlSpot(1, 32.4), FlSpot(2, 45.8), FlSpot(3, 58.2),
      FlSpot(4, 73.7), FlSpot(5, 68.5), FlSpot(6, 65.1), FlSpot(7, 52.4),
      FlSpot(8, 56.8), FlSpot(9, 48.3), FlSpot(10, 42.1), FlSpot(11, 46.5),
      FlSpot(12, 38.2),
      FlSpot(13, 40.5), // Explotó la burbuja, cierra en negativo (Rojo)
    ],
  };

  @override
  Widget build(BuildContext context) {
    final currentSpots = _chartData[_selectedTimeframe]!;
    final bool isPositive = currentSpots.last.y >= currentSpots.first.y;
    final Color chartColor = isPositive
        ? Colors.greenAccent.shade400
        : Colors.redAccent.shade400;

    return Scaffold(
      appBar: AppBar(title: Text(widget.crypto['name'])),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.crypto['name']} (${widget.crypto['symbol']})',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.crypto['price'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.crypto['change'],
                  style: TextStyle(
                    fontSize: 18,
                    color: widget.crypto['isPositive']
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            _buildTimeframeSelector(),

            const SizedBox(height: 25),

            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineTouchData: const LineTouchData(enabled: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: currentSpots,
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
            ),
            const SizedBox(height: 30),

            const Text(
              "Estadísticas",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    "Valor (USD)",
                    widget.crypto['price'],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildStatCard(
                    context,
                    "Valor (MXN)",
                    "Aprox. \$1.3M",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    "Máx. Histórico",
                    "\$73,750.00",
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildStatCard(context, "Mín. Histórico", "\$65.53"),
                ),
              ],
            ),
            const SizedBox(height: 25),

            const Text(
              "Últimas novedades",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            const Column(
              children: [
                ListTile(
                  leading: Icon(Icons.trending_up, color: Colors.green),
                  title: Text("Tendencia positiva"),
                  subtitle: Text("El mercado muestra señales de recuperación"),
                ),
                ListTile(
                  leading: Icon(Icons.show_chart, color: Colors.orange),
                  title: Text("Alta volatilidad"),
                  subtitle: Text(
                    "Se detectan movimientos bruscos en el precio",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeframeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: ['24H', '1S', '1M', '1A'].map((timeframe) {
        final isSelected = _selectedTimeframe == timeframe;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedTimeframe = timeframe;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              timeframe,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.onSurface.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.onSurface.withValues(alpha: 0.08),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
