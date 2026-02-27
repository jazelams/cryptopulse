import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';

class CryptoCard extends StatelessWidget {
  final String name;
  final String symbol;
  final String price;
  final String change;
  final bool isPositive;
  final List<FlSpot> spots;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const CryptoCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.price,
    required this.change,
    required this.isPositive,
    required this.spots,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/details', extra: {
        'name': name, 'symbol': symbol, 'price': price,
        'change': change, 'isPositive': isPositive,
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
              child: Text(
                symbol.isNotEmpty ? symbol[0] : '?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(symbol,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 2),
                  Text(name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.28,
                  height: 45,
                  child: LineChart(LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineTouchData: const LineTouchData(enabled: false),
                    minY: 0,
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        curveSmoothness: 0.15,
                        barWidth: 3,
                        isStrokeCapRound: true,
                        color: isPositive
                            ? Colors.greenAccent.shade400
                            : Colors.redAccent.shade400,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: isPositive
                                ? [Colors.greenAccent.shade400.withValues(alpha: 0.3), Colors.transparent]
                                : [Colors.redAccent.shade400.withValues(alpha: 0.3), Colors.transparent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(price,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 14,
                      color: isPositive
                          ? Colors.greenAccent.shade400
                          : Colors.redAccent.shade400,
                    ),
                    const SizedBox(width: 4),
                    Text(change,
                        style: TextStyle(
                          color: isPositive
                              ? Colors.greenAccent.shade400
                              : Colors.redAccent.shade400,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        )),
                  ],
                ),
              ],
            ),
            Builder(builder: (context) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              final cs = Theme.of(context).colorScheme;
              final activeColor = isDark
                  ? Colors.white
                  : const Color.fromARGB(255, 226, 53, 53); // este es para el color de la estrella en modo claro
              final inactiveColor = isDark
                  ? const Color.fromARGB(255, 128, 128, 128)
                  : cs.outline; // esto es para el borde de la estrella cuando no esta cliqueada
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: isFavorite ? activeColor : inactiveColor,
                  size: 22,
                ),
                onPressed: onFavoriteToggle,
              );
            }),
          ],
        ),
      ),
    );
  }
}
