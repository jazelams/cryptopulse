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

            // ENCABEZADO OPTIMIZADO PARA MODO CLARO Y OSCURO
            Container(
              width: double.infinity,
              // Ajustamos el padding para que fluya hacia los bordes
              padding: const EdgeInsets.only(
                top: 24,
                left: 16,
                right: 16,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                // El secreto: un degradado que en AMBOS temas se vuelve transparente (0.0)
                // revelando el color de fondo natural de la app sin parches
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: Theme.of(context).brightness == Brightness.dark
                      ? [
                          const Color(
                            0xFF1E1F30,
                          ), // Azul profundo oscuro arriba
                          const Color(
                            0xFF1E1F30,
                          ).withValues(alpha: 0.0), // Se desvanece
                        ]
                      : [
                          Theme.of(
                            context,
                          ).colorScheme.primaryContainer.withValues(
                            alpha: 0.4,
                          ), // Azul/púrpura muy suave y translúcido
                          Theme.of(
                            context,
                          ).colorScheme.primaryContainer.withValues(
                            alpha: 0.0,
                          ), // Se desvanece al fondo natural
                        ],
                  stops: const [0.0, 1.0],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Mantenemos el detalle, adaptado al tema actual
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "MERCADO EN VIVO",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Tendencias Crypto",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface, // Se adapta automático a claro/oscuro
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

                  // Chips de Filtro
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

            const SizedBox(height: 16), // Espacio antes de la lista

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

// NUEVO: Método para crear los botones de filtro estilo píldora
Widget _buildFilterChip(BuildContext context, String label, bool isSelected) {
  final colorScheme = Theme.of(context).colorScheme;
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: isSelected
          ? colorScheme.primary
          // EL CAMBIO: Un gris más claro pero definido en tema claro, y oscuro en oscuro
          : (isDark ? const Color(0xFF2A2B3D) : Colors.white),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        // EL CAMBIO: Un borde muy sutil para que las píldoras no se pierdan en el fondo claro
        color: isSelected
            ? Colors.transparent
            : (isDark ? Colors.transparent : Colors.grey.shade300),
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: isSelected
            ? colorScheme.onPrimary
            : colorScheme.onSurface.withValues(alpha: 0.7),
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
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
