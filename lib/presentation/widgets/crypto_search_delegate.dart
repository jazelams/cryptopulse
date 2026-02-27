import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CryptoSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> cryptos;

  CryptoSearchDelegate({required this.cryptos});

  List<Map<String, dynamic>> get _results => cryptos
      .where((c) =>
          (c['name'] as String).toLowerCase().contains(query.toLowerCase()) ||
          (c['symbol'] as String).toLowerCase().contains(query.toLowerCase()))
      .toList();

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => _buildList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context);

  Widget _buildList(BuildContext context) {
    final results = _results;
    if (results.isEmpty) {
      return Center(
        child: Text('Sin resultados para "$query"',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5))),
      );
    }
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final crypto = results[index];
        final isPositive = crypto['isPositive'] as bool;
        return ListTile(
          leading: CircleAvatar(
            radius: 18,
            backgroundColor:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
            child: Text((crypto['symbol'] as String)[0],
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
          ),
          title: Text(crypto['symbol'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(crypto['name'] as String),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(crypto['price'] as String,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(crypto['change'] as String,
                  style: TextStyle(
                    color: isPositive
                        ? const Color(0xFF1B8A4C)
                        : const Color(0xFFB71C1C),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  )),
            ],
          ),
          onTap: () {
            close(context, null);
            context.push('/details', extra: {
              'name': crypto['name'], 'symbol': crypto['symbol'],
              'price': crypto['price'], 'change': crypto['change'],
              'isPositive': crypto['isPositive'],
            });
          },
        );
      },
    );
  }
}
