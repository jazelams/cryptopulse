import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/crypto_card.dart'; // Importamos tu nuevo widget

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CryptoPulse',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () =>
                context.push('/settings'), // Botón de configuración
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10),
        children: const [
          // Aquí estamos usando tu widget reutilizable con datos estáticos
          CryptoCard(
            name: 'Bitcoin',
            symbol: 'BTC',
            price: '\$64,230.00',
            change: '+2.5%',
            isPositive: true,
          ),
          CryptoCard(
            name: 'Ethereum',
            symbol: 'ETH',
            price: '\$3,450.50',
            change: '-1.2%',
            isPositive: false,
          ),
          CryptoCard(
            name: 'Solana',
            symbol: 'SOL',
            price: '\$145.20',
            change: '+5.7%',
            isPositive: true,
          ),
        ],
      ),
    );
  }
}
