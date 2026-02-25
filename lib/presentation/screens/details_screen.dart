import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/simple_crypto_chart.dart';
import '../widgets/news_bottom_sheet.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> crypto;

  const DetailsScreen({super.key, required this.crypto});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  String _selectedTimeframe = '24H';

  // Base de datos de prueba para las diferentes gráficas
  final Map<String, List<FlSpot>> _chartData = {
    '24H': const [
      FlSpot(0, 60.0), FlSpot(1, 61.2), FlSpot(2, 60.5), FlSpot(3, 62.8),
      FlSpot(4, 61.9), FlSpot(5, 63.4), FlSpot(6, 62.1), FlSpot(7, 64.5),
    ],
    '1S': const [
      FlSpot(0, 68.0), FlSpot(1, 67.5), FlSpot(2, 69.1), FlSpot(3, 65.4),
      FlSpot(4, 66.8), FlSpot(5, 63.2), FlSpot(6, 64.5), FlSpot(7, 61.0),
    ],
    '1M': const [
      FlSpot(0, 45.0), FlSpot(1, 48.5), FlSpot(2, 47.0), FlSpot(3, 52.3),
      FlSpot(4, 50.8), FlSpot(5, 55.4), FlSpot(6, 53.9), FlSpot(7, 58.1),
    ],
    '1A': const [
      FlSpot(0, 25.0), FlSpot(1, 32.4), FlSpot(2, 45.8), FlSpot(3, 58.2),
      FlSpot(4, 73.7), FlSpot(5, 68.5), FlSpot(6, 65.1), FlSpot(7, 52.4),
    ],
  };

  @override
  Widget build(BuildContext context) {

    final currentSpots = _chartData[_selectedTimeframe]!;
    final bool isPositive = currentSpots.last.y >= currentSpots.first.y;
    final Color chartColor = isPositive ? Colors.greenAccent.shade400 : Colors.redAccent.shade400;

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
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.crypto['change'],
                  style: TextStyle(
                    fontSize: 18,
                    color: widget.crypto['isPositive'] ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),


            Row(
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
                            : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 25),

            const Text(
              "Movimiento reciente",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),


            SimpleCryptoChart(
              spots: currentSpots, 
              chartColor: chartColor,
            ),

            const SizedBox(height: 15),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const NewsBottomSheet(),
                );
              },
              icon: const Icon(Icons.article),
              label: const Text("Ver noticias"),
            ),
            const SizedBox(height: 20),

            const Text(
              "Estadísticas",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            const ListTile(
              leading: Icon(Icons.show_chart),
              title: Text("Volatilidad"),
              subtitle: Text("Movimientos moderados en las últimas horas"),
            ),
            const ListTile(
              leading: Icon(Icons.public),
              title: Text("Interés del mercado"),
              subtitle: Text("Alta actividad en exchanges principales"),
            ),
            const SizedBox(height: 20),

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
                  subtitle: Text("Se detectan movimientos bruscos en el precio"),
                ),
                ListTile(
                  leading: Icon(Icons.public, color: Colors.blue),
                  title: Text("Interés global"),
                  subtitle: Text("Mayor actividad en mercados internacionales"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}