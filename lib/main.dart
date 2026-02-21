import 'package:cryptopulse/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/app_router.dart';

void main() {
  runApp(const ProviderScope(child: CryptoPulseApp()));
}

class CryptoPulseApp extends ConsumerWidget {
  const CryptoPulseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(
      themeProvider,
    ); //aqui esta  el estado actual del tema desde el provider
    return MaterialApp.router(
      title: 'CryptoPulse',
      debugShowCheckedModeBanner: false,
      themeAnimationDuration: Duration
          .zero, // aqui se configura la eliminacion de la animacion del cambio de tema.
      themeAnimationCurve: Curves.linear,
      themeMode: themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
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
