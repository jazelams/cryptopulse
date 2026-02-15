import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalles de la Moneda.')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bitcoin (BTC)',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text(
              '\$64,230.00',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 244, 243, 243),
              ),
            ),
            const SizedBox(height: 40),
            //Grafica
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.show_chart,
                size: 100,
                color: Color.fromARGB(195, 212, 21, 21),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Estadísticas',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const ListTile(
              title: Text('Volumen 24h'),
              trailing: Text('\$34.5B'),
            ),
          ],
        ),
      ),
    );
  }
}
