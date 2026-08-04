import 'package:abasto_app/presentation/providers/configuracion/theme_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AparienciaSection extends ConsumerWidget {
  const AparienciaSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cambie entre modo claro, oscuro o automático y elija el color '
          'de acento de la aplicación.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 16),
        InfoLabel(
          label: 'Tema de la aplicación',
          child: ComboBox<ThemeMode>(
            value: theme.themeMode,
            items: const [
              ComboBoxItem(value: ThemeMode.system, child: Text('Sistema')),
              ComboBoxItem(value: ThemeMode.light, child: Text('Claro')),
              ComboBoxItem(value: ThemeMode.dark, child: Text('Oscuro')),
            ],
            onChanged: (value) {
              if (value != null) {
                ref.read(themeNotifierProvider.notifier).setThemeMode(value);
              }
            },
          ),
        ),
        const SizedBox(height: 16),
        InfoLabel(
          label: 'Color de acento',
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: kAccentSwatches.entries.map((entry) {
              final seleccionado = theme.accentKey == entry.key;
              return GestureDetector(
                onTap: () {
                  ref.read(themeNotifierProvider.notifier).setAccent(entry.key);
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: entry.value.normal,
                    shape: BoxShape.circle,
                    border: seleccionado
                        ? Border.all(
                            color: FluentTheme.of(context).accentColor,
                            width: 3,
                          )
                        : Border.all(
                            color: FluentTheme.of(
                              context,
                            ).resources.solidBackgroundFillColorTertiary,
                          ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
