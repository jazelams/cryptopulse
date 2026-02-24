import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/crypto_card.dart';
import 'package:cryptopulse/providers.dart';

final favoritesProvider = StateProvider<List<String>>((ref) => []);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    final currentFilter = ref.watch(filterProvider);
    final favoriteSymbols = ref.watch(favoritesProvider);

    // Lista de 11 Criptomonedas de prueba
    final List<Map<String, dynamic>> allCryptos = [
      {
        'name': 'Bitcoin',
        'symbol': 'BTC',
        'price': '\$64,230.00',
        'change': '+2.5%',
        'isPositive': true,
        'spots': const [
          FlSpot(0, 3),
          FlSpot(1, 2.5),
          FlSpot(2, 4),
          FlSpot(3, 3.2),
          FlSpot(4, 5.5),
          FlSpot(5, 4.8),
          FlSpot(6, 6.2),
        ],
      },
      {
        'name': 'Ethereum',
        'symbol': 'ETH',
        'price': '\$3,450.50',
        'change': '-1.2%',
        'isPositive': false,
        'spots': const [
          FlSpot(0, 6),
          FlSpot(1, 5.8),
          FlSpot(2, 6.5),
          FlSpot(3, 4.2),
          FlSpot(4, 4.8),
          FlSpot(5, 3.1),
          FlSpot(6, 2.5),
        ],
      },
      {
        'name': 'Solana',
        'symbol': 'SOL',
        'price': '\$145.20',
        'change': '+5.7%',
        'isPositive': true,
        'spots': const [
          FlSpot(0, 1),
          FlSpot(1, 3.5),
          FlSpot(2, 2.1),
          FlSpot(3, 5.8),
          FlSpot(4, 4.2),
          FlSpot(5, 6.9),
          FlSpot(6, 7.5),
        ],
      },
      {
        'name': 'Binance Coin',
        'symbol': 'BNB',
        'price': '\$590.30',
        'change': '+1.4%',
        'isPositive': true,
        'spots': const [
          FlSpot(0, 4),
          FlSpot(1, 3.8),
          FlSpot(2, 5.1),
          FlSpot(3, 4.5),
          FlSpot(4, 5.8),
          FlSpot(5, 5.2),
          FlSpot(6, 6.0),
        ],
      },
      {
        'name': 'Ripple',
        'symbol': 'XRP',
        'price': '\$0.61',
        'change': '-0.8%',
        'isPositive': false,
        'spots': const [
          FlSpot(0, 5),
          FlSpot(1, 4.5),
          FlSpot(2, 4.8),
          FlSpot(3, 3.5),
          FlSpot(4, 3.9),
          FlSpot(5, 2.8),
          FlSpot(6, 2.1),
        ],
      },
      {
        'name': 'Cardano',
        'symbol': 'ADA',
        'price': '\$0.45',
        'change': '-2.1%',
        'isPositive': false,
        'spots': const [
          FlSpot(0, 7),
          FlSpot(1, 6.2),
          FlSpot(2, 6.8),
          FlSpot(3, 5.1),
          FlSpot(4, 4.5),
          FlSpot(5, 3.2),
          FlSpot(6, 1.8),
        ],
      },
      {
        'name': 'Dogecoin',
        'symbol': 'DOGE',
        'price': '\$0.15',
        'change': '+8.3%',
        'isPositive': true,
        'spots': const [
          FlSpot(0, 1),
          FlSpot(1, 1.5),
          FlSpot(2, 1.2),
          FlSpot(3, 4.5),
          FlSpot(4, 3.8),
          FlSpot(5, 7.2),
          FlSpot(6, 8.5),
        ],
      },
      {
        'name': 'Polkadot',
        'symbol': 'DOT',
        'price': '\$7.20',
        'change': '-0.5%',
        'isPositive': false,
        'spots': const [
          FlSpot(0, 4.5),
          FlSpot(1, 4.8),
          FlSpot(2, 4.1),
          FlSpot(3, 3.8),
          FlSpot(4, 4.2),
          FlSpot(5, 3.5),
          FlSpot(6, 3.1),
        ],
      },
      {
        'name': 'Litecoin',
        'symbol': 'LTC',
        'price': '\$85.40',
        'change': '+3.2%',
        'isPositive': true,
        'spots': const [
          FlSpot(0, 2),
          FlSpot(1, 3.1),
          FlSpot(2, 2.8),
          FlSpot(3, 4.5),
          FlSpot(4, 4.1),
          FlSpot(5, 5.8),
          FlSpot(6, 6.5),
        ],
      },
      {
        'name': 'Chainlink',
        'symbol': 'LINK',
        'price': '\$14.80',
        'change': '-1.5%',
        'isPositive': false,
        'spots': const [
          FlSpot(0, 6),
          FlSpot(1, 5.5),
          FlSpot(2, 5.8),
          FlSpot(3, 4.1),
          FlSpot(4, 4.5),
          FlSpot(5, 3.2),
          FlSpot(6, 2.8),
        ],
      },
      {
        'name': 'Avalanche',
        'symbol': 'AVAX',
        'price': '\$35.90',
        'change': '+4.1%',
        'isPositive': true,
        'spots': const [
          FlSpot(0, 3),
          FlSpot(1, 2.5),
          FlSpot(2, 4.8),
          FlSpot(3, 4.1),
          FlSpot(4, 5.5),
          FlSpot(5, 5.1),
          FlSpot(6, 6.8),
        ],
      },
    ];

    // Lógica dinámica del filtro
    final displayedCryptos = currentFilter == 'Favoritos'
        ? allCryptos
              .where((c) => favoriteSymbols.contains(c['symbol']))
              .toList()
        : allCryptos;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'CryptoPulse',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () =>
                showSearch(context: context, delegate: CryptoSearchDelegate()),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: 24,
            ),
            decoration: BoxDecoration(color: bgColor),
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

                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildFilterChip(
                        context,
                        ref,
                        "Todos",
                        currentFilter == 'Todos',
                      ),
                      const SizedBox(width: 12),
                      _buildFilterChip(
                        context,
                        ref,
                        "Favoritos",
                        currentFilter == 'Favoritos',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? Colors.transparent : Colors.grey.shade50,
                borderRadius: isDark
                    ? BorderRadius.zero
                    : const BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                boxShadow: isDark
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -4),
                        ),
                      ],
              ),
              child: ClipRRect(
                borderRadius: isDark
                    ? BorderRadius.zero
                    : const BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(const Duration(milliseconds: 1500));
                    },
                    color: Theme.of(context).colorScheme.primary,
                    child: displayedCryptos.isEmpty
                        ? Center(
                            child: Text(
                              "No tienes favoritos aún.\nToca la estrella de una moneda.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          )
                        : ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: displayedCryptos.length,
                            itemBuilder: (context, index) {
                              final crypto = displayedCryptos[index];
                              final symbol = crypto['symbol'] as String;
                              final isFav = favoriteSymbols.contains(symbol);

                              return CryptoCard(
                                name: crypto['name'] as String,
                                symbol: symbol,
                                price: crypto['price'] as String,
                                change: crypto['change'] as String,
                                isPositive: crypto['isPositive'] as bool,
                                spots: crypto['spots'] as List<FlSpot>,
                                isFavorite: isFav,
                                onFavoriteToggle: () {
                                  final notifier = ref.read(
                                    favoritesProvider.notifier,
                                  );
                                  if (isFav) {
                                    notifier.state = notifier.state
                                        .where((s) => s != symbol)
                                        .toList();
                                  } else {
                                    notifier.state = [
                                      ...notifier.state,
                                      symbol,
                                    ];
                                  }
                                },
                              );
                            },
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    WidgetRef ref,
    String label,
    bool isSelected,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        ref.read(filterProvider.notifier).state = label;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : (isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.black.withValues(alpha: 0.05)),
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
            color: isSelected
                ? (isDark ? Colors.black : Colors.white)
                : (isDark
                      ? Colors.white.withValues(alpha: 0.5)
                      : Colors.black.withValues(alpha: 0.6)),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            fontSize: 13,
          ),
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
