import 'package:flutter_riverpod/flutter_riverpod.dart';

// Controla que filtro está activo si todos o solo fav
final filterProvider = StateProvider<String>((ref) => 'Todos');

// Controla que crypto están marcados como favoritos
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
