import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/crypto_card.dart';

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
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () =>
                context.push('/settings'), // Botón de configuración
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[

          const SizedBox(height: 16),

          const Text(
            "Mercado",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

        const SizedBox(height: 4),
        Text(
          "Precios actuales de Criptomoneda",
          style: TextStyle(color: Colors.grey[400]),
        ),

        const SizedBox(height: 10),

        Divider(color: Colors.grey[800]),

        const SizedBox(height: 10),

        Expanded(
          child: ListView(
            children: const [
              CryptoCard(
                name:'Bitcoin',
                symbol:'BTC',
                price:'\$64,230.00',
                change:'+2.5%',
                isPositive: true,
              ),
              CryptoCard(
                name:'Ethereum',
                symbol:'ETH',
                price:'\$3,450.50',
                change:'-1.2%',
                isPositive:false,
              ),
              CryptoCard(
                name:'Solana',
                symbol:'SOL',
                price:'\$145.20',
                change:'+5.7%',
                isPositive: true,
              ),
            ],
          ),
        ),
      ],
    ),
  ),
    );
  }
}
