import 'package:cryptopulse/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/crypto_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CryptoPulse',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CryptoSearchDelegate());
            },
          ),
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            Center(
              child: Column(
                children: [
                  const Text(
                    "Mercado de Criptomonedas",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Precios actuales de Criptomoneda",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Divider(color: Theme.of(context).dividerColor),

            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: const [
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
                  CryptoCard(
                    name: 'Binance Coin',
                    symbol: 'BNB',
                    price: '\$590.30',
                    change: '+1.4%',
                    isPositive: true,
                  ),
                  CryptoCard(
                    name: 'Ripple',
                    symbol: 'XRP',
                    price: '\$0.61',
                    change: '-0.8%',
                    isPositive: false,
                  ),
                  CryptoCard(
                    name: 'Cardano',
                    symbol: 'ADA',
                    price: '\$0.45',
                    change: '-2.1%',
                    isPositive: false,
                  ),
                  CryptoCard(
                    name: 'Dogecoin',
                    symbol: 'DOGE',
                    price: '\$0.15',
                    change: '+8.3%',
                    isPositive: true,
                  ),
                  CryptoCard(
                    name: 'Polkadot',
                    symbol: 'DOT',
                    price: '\$7.20',
                    change: '-0.5%',
                    isPositive: false,
                  ),
                  CryptoCard(
                    name: 'Litecoin',
                    symbol: 'LTC',
                    price: '\$85.40',
                    change: '+3.2%',
                    isPositive: true,
                  ),
                  CryptoCard(
                    name: 'Chainlink',
                    symbol: 'LINK',
                    price: '\$14.80',
                    change: '-1.5%',
                    isPositive: false,
                  ),
                  CryptoCard(
                    name: 'Avalanche',
                    symbol: 'AVAX',
                    price: '\$35.90',
                    change: '+4.1%',
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

class CryptoSearchDelegate extends SearchDelegate {
  final List<String> cryptos = [
    "Bitcoin",
    "Ethereum",
    "Solana",
    "Binance Coin",
    "Ripple",
    "Cardano",
    "Dogecoin",
    "Polkadot",
    "Litecoin",
    "Chainlink",
    "Avalanche",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ""),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = cryptos
        .where((crypto) => crypto.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: results.map((crypto) => ListTile(title: Text(crypto))).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
