import 'package:flutter_riverpod/flutter_riverpod.dart';

// filtro activo en home: Todos o Favoritos
final filterProvider = StateProvider<String>((ref) => 'Todos');

// preferencias de usuario
final currencyProvider = StateProvider<String>((ref) => 'MXN');
final languageProvider = StateProvider<String>((ref) => 'Español');

// maneja la lista de criptos marcadas como favoritas
class FavoritesNotifier extends StateNotifier<List<String>> {
  FavoritesNotifier() : super([]);

  void toggleFavorite(String symbol) {
    if (state.contains(symbol)) {
      state = state.where((s) => s != symbol).toList();
    } else {
      state = [...state, symbol];
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<String>>(
      (ref) => FavoritesNotifier(),
    );
