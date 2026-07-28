import 'package:abasto_app/config/constants/supabase_config.dart';
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
    url: SupabaseConfig.supabaseUrl!,
    publishableKey: SupabaseConfig.supabaseAnonKey!,
    
  );

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 720),
    minimumSize: Size(1024, 600),
    center: true,
    titleBarStyle:
        TitleBarStyle.hidden, // Ocultamos la barra por defecto de Windows
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      // <--- Contenedor Fluent global
      debugShowCheckedModeBanner: false,
      title: 'AbaSTO',
      themeMode: ThemeMode
          .system, // Soporte automático para temas claro/oscuro de Windows
      theme: FluentThemeData.light(),
      darkTheme: FluentThemeData.dark(),
      home: const MainLayout(),
    );
  }
}
