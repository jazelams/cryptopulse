import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DetailsScreen extends StatelessWidget {
  final Map<String, dynamic> crypto;

  const DetailsScreen({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(crypto['name'])),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${crypto['name']} (${crypto['symbol']})',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Precio y cambio
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  crypto['price'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  crypto['change'],
                  style: TextStyle(
                    fontSize: 18,
                    color: crypto['isPositive'] ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Grafica
            const Text(
              "Movimiento reciente",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 1),
                        FlSpot(1, 1.2),
                        FlSpot(2, 1.1),
                        FlSpot(3, 1.4),
                        FlSpot(4, 1.3),
                        FlSpot(5, 1.6),
                        FlSpot(6, 1.5),
                      ],
                      isCurved: true,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
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
                  subtitle: Text(
                    "Se detectan movimientos bruscos en el precio",
                  ),
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
