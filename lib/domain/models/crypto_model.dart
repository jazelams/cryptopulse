class CryptoModel {
  final String id;
  final String name;
  final String symbol;
  final double currentPrice;
  final double priceChangePercentage24h;

  CryptoModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.priceChangePercentage24h,
  });

  // Este "factory" es un constructor especial.
  // Lo usaremos más adelante para convertir el texto (JSON) que llega de internet
  // en un objeto CryptoModel que Flutter pueda entender.
  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      symbol: (json['symbol'] ?? '').toString().toUpperCase(),
      currentPrice: (json['current_price'] ?? 0.0).toDouble(),
      priceChangePercentage24h: (json['price_change_percentage_24h'] ?? 0.0)
          .toDouble(),
    );
  }
}
