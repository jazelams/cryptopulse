import '../../domain/models/crypto_model.dart';

class ApiClient {
  // Esta será la URL de donde sacaremos los datos reales más adelante
  final String baseUrl = 'https://api.coingecko.com/api/v3';

  Future<List<CryptoModel>> fetchCryptos() async {
    try {
      // AQUÍ IRÁ LA LÓGICA DE INTERNET (El paquete 'http' o 'dio')

      await Future.delayed(const Duration(seconds: 2));

      // Devolvemos una lista vacía para que no marque error mientras tanto
      return [];
    } catch (e) {
      // Si el internet falla, atrapamos el error aquí
      throw Exception('Error al cargar las criptomonedas: $e');
    }
  }
}
