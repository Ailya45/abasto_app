import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class BaseDatosSection extends ConsumerWidget {
  const BaseDatosSection({super.key});

  Future<String> _rutaBaseDatos() async {
    final docs = await getApplicationDocumentsDirectory();
    return p.join(docs.path, 'db', 'abasto_database.sqlite');
  }

  void _mostrarInfo(BuildContext context, String titulo, String contenido) {
    displayInfoBar(
      context,
      builder: (context, close) {
        return InfoBar(
          title: Text(titulo),
          content: Text(contenido),
          severity: InfoBarSeverity.success,
          action: IconButton(
            icon: const Icon(FluentIcons.clear),
            onPressed: close,
          ),
        );
      },
    );
  }

  void _mostrarError(BuildContext context, String mensaje) {
    displayInfoBar(
      context,
      builder: (context, close) {
        return InfoBar(
          title: const Text('Error'),
          content: Text(mensaje),
          severity: InfoBarSeverity.error,
          action: IconButton(
            icon: const Icon(FluentIcons.clear),
            onPressed: close,
          ),
        );
      },
    );
  }

  Future<void> _crearRespaldo(BuildContext context) async {
    try {
      final rutaDb = await _rutaBaseDatos();
      final archivo = File(rutaDb);
      if (!await archivo.exists()) {
        throw Exception('No se encontró el archivo de base de datos.');
      }

      final fecha = DateTime.now();
      final nombre = 'abasto_backup_'
          '${fecha.year}${fecha.month.toString().padLeft(2, '0')}'
          '${fecha.day.toString().padLeft(2, '0')}_'
          '${fecha.hour.toString().padLeft(2, '0')}'
          '${fecha.minute.toString().padLeft(2, '0')}.sqlite';

      final destino = await FilePicker.platform.saveFile(
        dialogTitle: 'Guardar respaldo de la base de datos',
        fileName: nombre,
        type: FileType.custom,
        allowedExtensions: ['sqlite', 'db'],
      );

      if (destino == null) return; // Usuario canceló

      await archivo.copy(destino);

      if (!context.mounted) return;
      _mostrarInfo(context, 'Respaldo creado', 'Base de datos respaldada en: $destino');
    } catch (e) {
      if (!context.mounted) return;
      _mostrarError(context, 'No se pudo crear el respaldo: $e');
    }
  }

  Future<void> _restaurarRespaldo(BuildContext context) async {
    try {
      final resultado = await FilePicker.platform.pickFiles(
        dialogTitle: 'Seleccionar archivo de respaldo',
        type: FileType.custom,
        allowedExtensions: ['sqlite', 'db'],
      );

      final origen = resultado?.files.single.path;
      if (origen == null) return; // Usuario canceló

      if (!context.mounted) return;
      final confirmar = await showDialog<bool>(
        context: context,
        builder: (context) {
          return ContentDialog(
            title: const Text('Restaurar base de datos'),
            content: const Text(
              'Se reemplazará la base de datos actual por el archivo '
              'seleccionado. Esta acción no se puede deshacer. '
              '¿Desea continuar?',
            ),
            actions: [
              Button(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Restaurar'),
              ),
            ],
          );
        },
      );

      if (confirmar != true) return;

      final rutaDb = await _rutaBaseDatos();
      await File(origen).copy(rutaDb);

      if (!context.mounted) return;
      await showDialog(
        context: context,
        builder: (context) {
          return ContentDialog(
            title: const Text('Restauración completada'),
            content: const Text(
              'La base de datos fue restaurada correctamente.\n\n'
              'Reinicie la aplicación para que los cambios se carguen.',
            ),
            actions: [
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (!context.mounted) return;
      _mostrarError(context, 'No se pudo restaurar la base de datos: $e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cree una copia de seguridad de la base de datos local o '
          'restaure una copia existente.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton(
              onPressed: () => _crearRespaldo(context),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FluentIcons.save_as),
                  SizedBox(width: 8),
                  Text('Crear respaldo'),
                ],
              ),
            ),
            Button(
              onPressed: () => _restaurarRespaldo(context),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FluentIcons.open_file),
                  SizedBox(width: 8),
                  Text('Restaurar desde archivo'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
