import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cryptopulse/providers.dart';

class CryptoFilterChip extends ConsumerWidget {
  final String label;
  final bool isSelected;

  const CryptoFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isFavoritosBtn = label == 'Favoritos';

    final todosSelectedBg = isDark ? Colors.white : const Color(0xFF1A1A1A);
    final todosSelectedText = isDark ? Colors.black : Colors.white;
    const favoritosSelectedBg = Color(0xFF9E1B1B);
    const favoritosSelectedText = Colors.white;

    final unselectedBg = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.05);
    final unselectedText = isDark
        ? Colors.white.withValues(alpha: 0.5)
        : Colors.black.withValues(alpha: 0.6);
    final unselectedBorder = isDark
        ? Colors.transparent
        : Colors.black.withValues(alpha: 0.1);

    final bgColor = isSelected
        ? (isFavoritosBtn ? favoritosSelectedBg : todosSelectedBg)
        : unselectedBg;
    final textColor = isSelected
        ? (isFavoritosBtn ? favoritosSelectedText : todosSelectedText)
        : unselectedText;

    return GestureDetector(
      onTap: () => ref.read(filterProvider.notifier).state = label,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : unselectedBorder,
          ),
        ),
        child: Text(label,
            style: TextStyle(
              color: textColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              fontSize: 13,
            )),
      ),
    );
  }
}
