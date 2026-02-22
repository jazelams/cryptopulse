import 'package:go_router/go_router.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/details_screen.dart';
import '../presentation/screens/settings_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        // Si state.extra es null, usa un Map vacío de respaldo
        final crypto =
            (state.extra as Map<String, dynamic>?) ??
            {
              'name': 'Error',
              'symbol': 'ERR',
              'price': '\$0.00',
              'change': '0%',
              'isPositive': true,
            };
        return DetailsScreen(crypto: crypto);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
