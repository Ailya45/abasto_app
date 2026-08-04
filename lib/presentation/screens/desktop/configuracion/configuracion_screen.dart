import 'package:abasto_app/presentation/screens/desktop/configuracion/sections/apariencia_section.dart';
import 'package:abasto_app/presentation/screens/desktop/configuracion/sections/base_datos_section.dart';
import 'package:abasto_app/presentation/screens/desktop/configuracion/sections/informacion_negocio_section.dart';
import 'package:abasto_app/presentation/widgets/glass_card.dart';
import 'package:fluent_ui/fluent_ui.dart';

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('Configuración')),
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GlassCard(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _titulo(context, 'Información del negocio'),
                      const SizedBox(height: 16),
                      const InformacionNegocioSection(),
                    ],
                  ),
                ),
                GlassCard(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _titulo(context, 'Base de datos'),
                      const SizedBox(height: 16),
                      const BaseDatosSection(),
                    ],
                  ),
                ),
                GlassCard(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _titulo(context, 'Apariencia'),
                      const SizedBox(height: 16),
                      const AparienciaSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titulo(BuildContext context, String texto) {
    return Text(
      texto,
      style: FluentTheme.of(
        context,
      ).typography.bodyStrong?.copyWith(fontSize: 18),
    );
  }
}
