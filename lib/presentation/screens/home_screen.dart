import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/crypto_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 24,
                left: 16,
                right: 16,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AnimatedLiveBadge(),

                  const SizedBox(height: 12),
                  Text(
                    "Tendencias Crypto",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Precios globales actualizados.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // botones para el encabezado
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip(context, "Todos", true),
                        const SizedBox(width: 8),
                        _buildFilterChip(context, "Ganadores", false),
                        const SizedBox(width: 8),
                        _buildFilterChip(context, "Perdedores", false),
                        const SizedBox(width: 8),
                        _buildFilterChip(context, "Favoritos", false),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- FIN DEL ENCABEZADO ---
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: const [
                  CryptoCard(
                    name: 'Bitcoin',
                    symbol: 'BTC',
                    price: '\$64,230.00',
                    change: '+2.5%',
                    isPositive: true,
                    spots: [
                      FlSpot(0, 3),
                      FlSpot(1, 2.5),
                      FlSpot(2, 4),
                      FlSpot(3, 3.2),
                      FlSpot(4, 5.5),
                      FlSpot(5, 4.8),
                      FlSpot(6, 6.2),
                    ],
                  ),
                  CryptoCard(
                    name: 'Ethereum',
                    symbol: 'ETH',
                    price: '\$3,450.50',
                    change: '-1.2%',
                    isPositive: false,
                    spots: [
                      FlSpot(0, 6),
                      FlSpot(1, 5.8),
                      FlSpot(2, 6.5),
                      FlSpot(3, 4.2),
                      FlSpot(4, 4.8),
                      FlSpot(5, 3.1),
                      FlSpot(6, 2.5),
                    ],
                  ),
                  CryptoCard(
                    name: 'Solana',
                    symbol: 'SOL',
                    price: '\$145.20',
                    change: '+5.7%',
                    isPositive: true,
                    spots: [
                      FlSpot(0, 1),
                      FlSpot(1, 3.5),
                      FlSpot(2, 2.1),
                      FlSpot(3, 5.8),
                      FlSpot(4, 4.2),
                      FlSpot(5, 6.9),
                      FlSpot(6, 7.5),
                    ],
                  ),
                  CryptoCard(
                    name: 'Binance Coin',
                    symbol: 'BNB',
                    price: '\$590.30',
                    change: '+1.4%',
                    isPositive: true,
                    spots: [
                      FlSpot(0, 4),
                      FlSpot(1, 3.8),
                      FlSpot(2, 5.1),
                      FlSpot(3, 4.5),
                      FlSpot(4, 5.8),
                      FlSpot(5, 5.2),
                      FlSpot(6, 6.0),
                    ],
                  ),
                  CryptoCard(
                    name: 'Ripple',
                    symbol: 'XRP',
                    price: '\$0.61',
                    change: '-0.8%',
                    isPositive: false,
                    spots: [
                      FlSpot(0, 5),
                      FlSpot(1, 4.5),
                      FlSpot(2, 4.8),
                      FlSpot(3, 3.5),
                      FlSpot(4, 3.9),
                      FlSpot(5, 2.8),
                      FlSpot(6, 2.1),
                    ],
                  ),
                  CryptoCard(
                    name: 'Cardano',
                    symbol: 'ADA',
                    price: '\$0.45',
                    change: '-2.1%',
                    isPositive: false,
                    spots: [
                      FlSpot(0, 7),
                      FlSpot(1, 6.2),
                      FlSpot(2, 6.8),
                      FlSpot(3, 5.1),
                      FlSpot(4, 4.5),
                      FlSpot(5, 3.2),
                      FlSpot(6, 1.8),
                    ],
                  ),
                  CryptoCard(
                    name: 'Dogecoin',
                    symbol: 'DOGE',
                    price: '\$0.15',
                    change: '+8.3%',
                    isPositive: true,
                    spots: [
                      FlSpot(0, 1),
                      FlSpot(1, 1.5),
                      FlSpot(2, 1.2),
                      FlSpot(3, 4.5),
                      FlSpot(4, 4.1),
                      FlSpot(5, 7.2),
                      FlSpot(6, 8.5),
                    ],
                  ),
                  CryptoCard(
                    name: 'Polkadot',
                    symbol: 'DOT',
                    price: '\$7.20',
                    change: '-0.5%',
                    isPositive: false,
                    spots: [
                      FlSpot(0, 4.5),
                      FlSpot(1, 4.8),
                      FlSpot(2, 4.1),
                      FlSpot(3, 3.8),
                      FlSpot(4, 4.2),
                      FlSpot(5, 3.5),
                      FlSpot(6, 3.1),
                    ],
                  ),
                  CryptoCard(
                    name: 'Litecoin',
                    symbol: 'LTC',
                    price: '\$85.40',
                    change: '+3.2%',
                    isPositive: true,
                    spots: [
                      FlSpot(0, 2),
                      FlSpot(1, 3.1),
                      FlSpot(2, 2.8),
                      FlSpot(3, 4.5),
                      FlSpot(4, 4.1),
                      FlSpot(5, 5.8),
                      FlSpot(6, 6.5),
                    ],
                  ),
                  CryptoCard(
                    name: 'Chainlink',
                    symbol: 'LINK',
                    price: '\$14.80',
                    change: '-1.5%',
                    isPositive: false,
                    spots: [
                      FlSpot(0, 6),
                      FlSpot(1, 5.5),
                      FlSpot(2, 5.8),
                      FlSpot(3, 4.1),
                      FlSpot(4, 4.5),
                      FlSpot(5, 3.2),
                      FlSpot(6, 2.8),
                    ],
                  ),
                  CryptoCard(
                    name: 'Avalanche',
                    symbol: 'AVAX',
                    price: '\$35.90',
                    change: '+4.1%',
                    isPositive: true,
                    spots: [
                      FlSpot(0, 3),
                      FlSpot(1, 2.5),
                      FlSpot(2, 4.8),
                      FlSpot(3, 4.1),
                      FlSpot(4, 5.5),
                      FlSpot(5, 5.1),
                      FlSpot(6, 6.8),
                    ],
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

// con esto se hacen los botones del encabezado

Widget _buildFilterChip(BuildContext context, String label, bool isSelected) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  final selectedBgColor = isDark ? Colors.white : const Color(0xFF1A1A1A);

  final selectedTextColor = isDark ? Colors.black : Colors.white;

  final unselectedBgColor = isDark
      ? Colors.white.withValues(alpha: 0.08)
      : Colors.black.withValues(alpha: 0.05);

  final unselectedTextColor = isDark
      ? Colors.white.withValues(alpha: 0.5)
      : Colors.black.withValues(alpha: 0.6);

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: isSelected ? selectedBgColor : unselectedBgColor,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: isSelected
            ? Colors.transparent
            : (isDark
                  ? Colors.transparent
                  : Colors.black.withValues(alpha: 0.1)),
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: isSelected ? selectedTextColor : unselectedTextColor,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
        fontSize: 13,
      ),
    ),
  );
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

class AnimatedLiveBadge extends StatefulWidget {
  const AnimatedLiveBadge({super.key});

  @override
  State<AnimatedLiveBadge> createState() => _AnimatedLiveBadgeState();
}

class _AnimatedLiveBadgeState extends State<AnimatedLiveBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.greenAccent.shade400,
      end: Colors.redAccent.shade400,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _colorAnimation.value!.withValues(alpha: 0.6),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            Text(
              "MERCADO EN VIVO",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _colorAnimation.value,
                letterSpacing: 1.5,
              ),
            ),
          ],
        );
      },
    );
  }
}
