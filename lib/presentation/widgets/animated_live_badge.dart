import 'package:flutter/material.dart';

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
              width: 6, height: 6,
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _colorAnimation.value!.withValues(alpha: 0.6),
                    blurRadius: 6, spreadRadius: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text("MERCADO EN VIVO",
                style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w700,
                  color: _colorAnimation.value, letterSpacing: 1.5,
                )),
          ],
        );
      },
    );
  }
}
