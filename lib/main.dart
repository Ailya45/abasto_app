import 'package:abasto_app/config/constants/supabase_config.dart';
import 'package:abasto_app/presentation/providers/configuracion/mica_provider.dart';
import 'package:abasto_app/presentation/providers/configuracion/theme_provider.dart';
import 'package:abasto_app/presentation/widgets/main_layout.dart';
import 'package:fluent_ui/fluent_ui.dart'; // <--- Cambiar material por fluent_ui
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    publishableKey: SupabaseConfig.supabaseAnonKey,
  );

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 720),
    minimumSize: Size(1024, 600),
    center: true,
    titleBarStyle:
        TitleBarStyle.hidden, // Ocultamos la barra por defecto de Windows
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    // Fondo transparente para permitir el efecto Mica/Acrylic
    await windowManager.setBackgroundColor(Colors.transparent);
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    final micaDisponible = ref.watch(micaAvailableProvider);

    return FluentApp(
      // <--- Contenedor Fluent global
      debugShowCheckedModeBanner: false,
      title: 'AbaSTO',
      themeMode: theme.themeMode,
      theme: theme.light,
      darkTheme: theme.dark,
      home: _AppFondo(theme: theme, micaDisponible: micaDisponible),
    );
  }
}

/// Capa de fondo de la aplicación.
///
/// - En Windows 11 usa el backdrop nativo Mica (capa vacía: el sistema dibuja
///   el fondo difuminado detrás de las superficies translúcidas).
/// - En sistemas anteriores (Windows 10) simula el efecto con un degradado
///   interno sutil difuminado por un Acrylic de Flutter.
class _AppFondo extends StatelessWidget {
  final ThemeState theme;
  final bool micaDisponible;

  const _AppFondo({required this.theme, required this.micaDisponible});

  @override
  Widget build(BuildContext context) {
    final oscuro = switch (theme.themeMode) {
      ThemeMode.dark => true,
      ThemeMode.light => false,
      ThemeMode.system =>
        MediaQuery.platformBrightnessOf(context) == Brightness.dark,
    };

    if (micaDisponible) {
      // Mica nativa de Windows 11: sin capa extra en Flutter.
      return const MainLayout();
    }

    // Fallback: degradado interno sutil difuminado por Acrylic.
    return Stack(
      children: [
        Positioned.fill(child: _MicaFondo(oscuro: oscuro)),
        Positioned.fill(
          child: Acrylic(
            tint: const Color(0x00000000),
            blurAmount: 40,
            child: const MainLayout(),
          ),
        ),
      ],
    );
  }
}

/// Fondo degradado sutil que difumina el Acrylic en el fallback, imitando el
/// efecto Mica sin depender del sistema operativo.
class _MicaFondo extends StatelessWidget {
  final bool oscuro;

  const _MicaFondo({required this.oscuro});

  @override
  Widget build(BuildContext context) {
    final colores = oscuro
        ? const [
            Color(0xFF232B3B),
            Color(0xFF171C29),
            Color(0xFF241E33),
          ]
        : const [
            Color(0xFFDCE9F5),
            Color(0xFFE6E2F4),
            Color(0xFFF0E7F2),
          ];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colores,
        ),
      ),
    );
  }
}
