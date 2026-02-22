import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//aqui se guarda el estado del tema y se define la lógica para cambiar entre temas claro y oscuro
class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.dark); //define el modo oscuro por defecto

  void toggleTheme() {
    state = (state == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
  }
}

//proovedor que se usa en toda la app para menajar el estado del tema, se puede acceder a este provider desde cualquier widget para cambiar el tema de la app
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
