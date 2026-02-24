import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CryptoCard extends StatelessWidget {
  final String name;
  final String symbol;
  final String price;
  final String change;
  final bool isPositive;

  const CryptoCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.price,
    required this.change,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Variables de colores adaptables al tema
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1F2E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.white54 : Colors.black54;
    final trendColor = isPositive
        ? const Color.fromARGB(255, 18, 179, 34)
        : Colors.redAccent.shade400;

    // 2. Contenedor principal con el nuevo diseño
    return Container(
      margin: const EdgeInsets.only(bottom: 12), // Espacio entre cada tarjeta
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.push(
            '/details',
            extra: {
              'name': name,
              'symbol': symbol,
              'price': price,
              'change': change,
              'isPositive': isPositive,
            },
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                // Icono
                CircleAvatar(
                  radius: 20,
                  backgroundColor: textColor.withValues(alpha: 0.05),
                  child: Text(
                    symbol.isNotEmpty ? symbol[0] : '?',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Textos Invertidos: Nombre arriba, Símbolo abajo
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        symbol,
                        style: TextStyle(color: subtitleColor, fontSize: 13),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: 3,
                  child: Container(
                    height: 35,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CustomPaint(
                      painter: _MockSparklinePainter(
                        isPositive: isPositive,
                        lineColor: trendColor,
                      ),
                    ),
                  ),
                ),

                // Precios alineados a la derecha
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        change,
                        style: TextStyle(
                          color: trendColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//aqui la clase dibuja la curva sin usar librerías de terceros
class _MockSparklinePainter extends CustomPainter {
  final bool isPositive;
  final Color lineColor;

  _MockSparklinePainter({required this.isPositive, required this.lineColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(0, h * 0.5);

    if (isPositive) {
      path.quadraticBezierTo(w * 0.25, h * 0.9, w * 0.5, h * 0.4);
      path.quadraticBezierTo(w * 0.75, h * 0.1, w, h * 0.2);
    } else {
      path.quadraticBezierTo(w * 0.25, h * 0.1, w * 0.5, h * 0.6);
      path.quadraticBezierTo(w * 0.75, h * 0.9, w, h * 0.8);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
