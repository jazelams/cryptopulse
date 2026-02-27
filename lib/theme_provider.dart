import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// controla el tema claro/oscuro de toda la app
class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.dark); // oscuro por defecto

  void toggleTheme() {
    state = (state == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
