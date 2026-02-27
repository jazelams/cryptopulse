import 'package:fl_chart/fl_chart.dart';

// datos estáticos de prueba, se reemplazarán con la API de CoinGecko
final List<Map<String, dynamic>> allCryptos = [
  {
    'name': 'Bitcoin', 'symbol': 'BTC', 'price': '\$64,230.00',
    'change': '+2.5%', 'isPositive': true,
    'spots': const [FlSpot(0,3),FlSpot(1,2.5),FlSpot(2,4),FlSpot(3,3.2),FlSpot(4,5.5),FlSpot(5,4.8),FlSpot(6,6.2)],
  },
  {
    'name': 'Ethereum', 'symbol': 'ETH', 'price': '\$3,450.50',
    'change': '-1.2%', 'isPositive': false,
    'spots': const [FlSpot(0,6),FlSpot(1,5.8),FlSpot(2,6.5),FlSpot(3,4.2),FlSpot(4,4.8),FlSpot(5,3.1),FlSpot(6,2.5)],
  },
  {
    'name': 'Solana', 'symbol': 'SOL', 'price': '\$145.20',
    'change': '+5.7%', 'isPositive': true,
    'spots': const [FlSpot(0,1),FlSpot(1,3.5),FlSpot(2,2.1),FlSpot(3,5.8),FlSpot(4,4.2),FlSpot(5,6.9),FlSpot(6,7.5)],
  },
  {
    'name': 'Binance Coin', 'symbol': 'BNB', 'price': '\$590.30',
    'change': '+1.4%', 'isPositive': true,
    'spots': const [FlSpot(0,4),FlSpot(1,3.8),FlSpot(2,5.1),FlSpot(3,4.5),FlSpot(4,5.8),FlSpot(5,5.2),FlSpot(6,6.0)],
  },
  {
    'name': 'Ripple', 'symbol': 'XRP', 'price': '\$0.61',
    'change': '-0.8%', 'isPositive': false,
    'spots': const [FlSpot(0,5),FlSpot(1,4.5),FlSpot(2,4.8),FlSpot(3,3.5),FlSpot(4,3.9),FlSpot(5,2.8),FlSpot(6,2.1)],
  },
  {
    'name': 'Cardano', 'symbol': 'ADA', 'price': '\$0.45',
    'change': '-2.1%', 'isPositive': false,
    'spots': const [FlSpot(0,7),FlSpot(1,6.2),FlSpot(2,6.8),FlSpot(3,5.1),FlSpot(4,4.5),FlSpot(5,3.2),FlSpot(6,1.8)],
  },
  {
    'name': 'Dogecoin', 'symbol': 'DOGE', 'price': '\$0.15',
    'change': '+8.3%', 'isPositive': true,
    'spots': const [FlSpot(0,1),FlSpot(1,1.5),FlSpot(2,1.2),FlSpot(3,4.5),FlSpot(4,3.8),FlSpot(5,7.2),FlSpot(6,8.5)],
  },
  {
    'name': 'Polkadot', 'symbol': 'DOT', 'price': '\$7.20',
    'change': '-0.5%', 'isPositive': false,
    'spots': const [FlSpot(0,4.5),FlSpot(1,4.8),FlSpot(2,4.1),FlSpot(3,3.8),FlSpot(4,4.2),FlSpot(5,3.5),FlSpot(6,3.1)],
  },
  {
    'name': 'Litecoin', 'symbol': 'LTC', 'price': '\$85.40',
    'change': '+3.2%', 'isPositive': true,
    'spots': const [FlSpot(0,2),FlSpot(1,3.1),FlSpot(2,2.8),FlSpot(3,4.5),FlSpot(4,4.1),FlSpot(5,5.8),FlSpot(6,6.5)],
  },
  {
    'name': 'Chainlink', 'symbol': 'LINK', 'price': '\$14.80',
    'change': '-1.5%', 'isPositive': false,
    'spots': const [FlSpot(0,6),FlSpot(1,5.5),FlSpot(2,5.8),FlSpot(3,4.1),FlSpot(4,4.5),FlSpot(5,3.2),FlSpot(6,2.8)],
  },
  {
    'name': 'Avalanche', 'symbol': 'AVAX', 'price': '\$35.90',
    'change': '+4.1%', 'isPositive': true,
    'spots': const [FlSpot(0,3),FlSpot(1,2.5),FlSpot(2,4.8),FlSpot(3,4.1),FlSpot(4,5.5),FlSpot(5,5.1),FlSpot(6,6.8)],
  },
];
