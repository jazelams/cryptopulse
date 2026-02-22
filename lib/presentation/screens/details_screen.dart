import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map<String, dynamic> crypto;

  const DetailsScreen({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(crypto['name'])),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${crypto['name']} (${crypto['symbol']})',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(crypto['price'], style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text(
              "Cambio: ${crypto['change']}",
              style: TextStyle(
                fontSize: 20,
                color: crypto['isPositive'] ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
