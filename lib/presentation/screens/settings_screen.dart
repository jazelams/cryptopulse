import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cryptopulse/theme_provider.dart';

final currencyProvider = StateProvider<String>((ref) => 'MXN');
final languageProvider = StateProvider<String>((ref) => 'Español');

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    final currentCurrency = ref.watch(currencyProvider);
    final currentLanguage = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configuración',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "PREFERENCIAS DE APLICACIÓN",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),

          Container(
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.08),
                width: 0.5,
              ),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text(
                    "Modo Oscuro",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  secondary: const Icon(Icons.dark_mode_outlined),
                  value: isDark,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (value) {
                    ref.read(themeProvider.notifier).toggleTheme();
                  },
                ),

                Divider(
                  height: 1,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.1),
                  indent: 16,
                  endIndent: 16,
                ),

                ListTile(
                  leading: const Icon(Icons.attach_money),
                  title: const Text(
                    "Moneda Local",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentCurrency,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),

                  onTap: () => _showPicker(
                    context,
                    ref,
                    title: "Selecciona tu Moneda",
                    provider: currencyProvider,
                    currentValue: currentCurrency,
                    options: [
                      {'value': 'MXN', 'label': 'Peso Mexicano'},
                      {'value': 'USD', 'label': 'Dólar Estadounidense'},
                      {'value': 'EUR', 'label': 'Euro'},
                    ],
                  ),
                ),

                Divider(
                  height: 1,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.1),
                  indent: 16,
                  endIndent: 16,
                ),

                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text(
                    "Idioma",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentLanguage,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),

                  onTap: () => _showPicker(
                    context,
                    ref,
                    title: "Selecciona el Idioma",
                    provider: languageProvider,
                    currentValue: currentLanguage,
                    options: [
                      {'value': 'Español', 'label': 'Español (México)'},
                      {'value': 'English', 'label': 'English (US)'},
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            "ACERCA DE",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.08),
                width: 0.5,
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text(
                "Versión de CryptoPulse",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: Text(
                "1.0.0",
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPicker(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required StateProvider<String> provider,
    required String currentValue,
    required List<Map<String, String>> options,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              ...options.map((option) {
                final isSelected = currentValue == option['value'];
                return ListTile(
                  title: Text(
                    option['label']!,
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                  onTap: () {
                    ref.read(provider.notifier).state = option['value']!;
                    Navigator.pop(context); // Cierra la ventanita
                  },
                );
              }),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
