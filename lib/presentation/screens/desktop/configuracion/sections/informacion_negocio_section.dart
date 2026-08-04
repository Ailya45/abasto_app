import 'package:abasto_app/presentation/providers/storage/local_storage_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InformacionNegocioSection extends ConsumerStatefulWidget {
  const InformacionNegocioSection({super.key});

  @override
  ConsumerState<InformacionNegocioSection> createState() =>
      _InformacionNegocioSectionState();
}

class _InformacionNegocioSectionState
    extends ConsumerState<InformacionNegocioSection> {
  static const _claves = {
    'nombre': 'nombre_negocio',
    'rif': 'rif_negocio',
    'direccion': 'direccion_negocio',
    'telefono': 'telefono_negocio',
  };

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _rifController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();

  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _rifController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  Future<void> _cargarDatos() async {
    final repo = ref.read(localStorageRepositoryProvider);
    final nombre = await repo.getConfigValue(_claves['nombre']!);
    final rif = await repo.getConfigValue(_claves['rif']!);
    final direccion = await repo.getConfigValue(_claves['direccion']!);
    final telefono = await repo.getConfigValue(_claves['telefono']!);

    if (!mounted) return;
    setState(() {
      _nombreController.text = nombre ?? '';
      _rifController.text = rif ?? '';
      _direccionController.text = direccion ?? '';
      _telefonoController.text = telefono ?? '';
      _cargando = false;
    });
  }

  Future<void> _guardar() async {
    final repo = ref.read(localStorageRepositoryProvider);
    await repo.setConfigValue(_claves['nombre']!, _nombreController.text.trim());
    await repo.setConfigValue(_claves['rif']!, _rifController.text.trim());
    await repo.setConfigValue(
      _claves['direccion']!,
      _direccionController.text.trim(),
    );
    await repo.setConfigValue(
      _claves['telefono']!,
      _telefonoController.text.trim(),
    );

    if (!mounted) return;
    displayInfoBar(
      context,
      builder: (context, close) {
        return InfoBar(
          title: const Text('Información guardada'),
          content: const Text(
            'Los datos del negocio se guardaron correctamente.',
          ),
          severity: InfoBarSeverity.success,
          action: IconButton(
            icon: const Icon(FluentIcons.clear),
            onPressed: close,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_cargando) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: ProgressRing()),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Complete la información de su comercio. Los campos están '
          'guardados en la base de datos de la aplicación.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 16),
        InfoLabel(
          label: 'Nombre del abasto / comercio',
          child: TextBox(
            controller: _nombreController,
            placeholder: 'Ej: Abasto "La Esquina"',
          ),
        ),
        const SizedBox(height: 12),
        InfoLabel(
          label: 'RIF / Identificación Fiscal',
          child: TextBox(
            controller: _rifController,
            placeholder: 'Ej: J-12345678-9',
          ),
        ),
        const SizedBox(height: 12),
        InfoLabel(
          label: 'Dirección física',
          child: TextBox(
            controller: _direccionController,
            placeholder: 'Ej: Av. Principal, Local 3, Caracas',
            maxLines: 3,
          ),
        ),
        const SizedBox(height: 12),
        InfoLabel(
          label: 'Teléfono de contacto',
          child: TextBox(
            controller: _telefonoController,
            placeholder: 'Ej: 0412-1234567',
          ),
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: _guardar,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(FluentIcons.save),
              SizedBox(width: 8),
              Text('Guardar información'),
            ],
          ),
        ),
      ],
    );
  }
}
