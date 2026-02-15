import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/app_router.dart'; // Importamos tu archivo de rutas

void main() {
  runApp(const ProviderScope(child: CryptoPulseApp()));
}

class CryptoPulseApp extends StatelessWidget {
  const CryptoPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CryptoPulse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),

      routerConfig: appRouter,
    );
  }
}
