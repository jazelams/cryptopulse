import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cryptopulse/providers.dart';
import 'package:cryptopulse/data/crypto_data.dart';
import '../widgets/crypto_card.dart';
import '../widgets/animated_live_badge.dart';
import '../widgets/crypto_filter_chip.dart';
import '../widgets/crypto_search_delegate.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final currentFilter = ref.watch(filterProvider);
    final favoriteSymbols = ref.watch(favoritesProvider);

    // Lógica dinámica del bttn fav
    final displayedCryptos = currentFilter == 'Favoritos'
        ? allCryptos.where((c) => favoriteSymbols.contains(c['symbol'])).toList()
        : allCryptos;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('CryptoPulse',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: CryptoSearchDelegate(cryptos: allCryptos),
            ),
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
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 24),
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
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CryptoFilterChip(label: "Todos", isSelected: currentFilter == 'Todos'),
                      const SizedBox(width: 12),
                      CryptoFilterChip(label: "Favoritos", isSelected: currentFilter == 'Favoritos'),
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
                    : [BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      )],
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
                    onRefresh: () async =>
                        await Future.delayed(const Duration(milliseconds: 1500)),
                    color: Theme.of(context).colorScheme.primary,
                    child: displayedCryptos.isEmpty
                        ? Center(
                            child: Text(
                              "No tienes favoritos aún.\nToca la estrella de una moneda.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface
                                    .withValues(alpha: 0.5),
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
                                onFavoriteToggle: () => ref
                                    .read(favoritesProvider.notifier)
                                    .toggleFavorite(symbol),
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
}
