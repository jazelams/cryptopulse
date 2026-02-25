import 'package:flutter/material.dart';

class NewsBottomSheet extends StatelessWidget {
  const NewsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Noticias del mercado",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          ListTile(
            leading: Icon(Icons.article, color: Colors.blue),
            title: Text("Bitcoin sube por demanda"),
            subtitle: Text("Analistas ven tendencia positiva"),
          ),
          ListTile(
            leading: Icon(Icons.article, color: Colors.orange),
            title: Text("Mercado muestra recuperación"),
            subtitle: Text("Expertos recomiendan cautela"),
          ),
          ListTile(
            leading: Icon(Icons.article, color: Colors.green),
            title: Text("Alta volatilidad detectada"),
            subtitle: Text("Movimientos bruscos en el precio"),
          ),
        ],
      ),
    );
  }
}
