import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditarPrecioDialog extends ConsumerStatefulWidget {
  final String nombreProducto;
  final double precioActual;

  const EditarPrecioDialog({
    super.key,
    required this.nombreProducto,
    required this.precioActual,
  });

  @override
  ConsumerState<EditarPrecioDialog> createState() => _EditarPrecioDialogState();
}

class _EditarPrecioDialogState extends ConsumerState<EditarPrecioDialog> {
  final TextEditingController _precioController = TextEditingController();
  String? _error;

  @override
  void initState() {
    super.initState();
    _precioController.text = widget.precioActual.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _precioController.dispose();
    super.dispose();
  }

  void _guardar() {
    final valor = double.tryParse(
      _precioController.text.trim().replaceAll(',', '.'),
    );

    if (valor == null || valor <= 0) {
      setState(() => _error = 'Ingrese un precio válido mayor a 0');
      return;
    }

    Navigator.pop(context, valor);
  }

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text('Editar Precio: ${widget.nombreProducto}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Precio actual: \$ ${widget.precioActual.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          InfoLabel(label: 'Nuevo precio (USD):'),
          TextBox(
            controller: _precioController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            placeholder: 'Ej: 2.50',
            onSubmitted: (_) => _guardar(),
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(
              _error!,
              style: TextStyle(
                color: FluentTheme.of(context).resources.systemFillColorCritical,
              ),
            ),
          ],
        ],
      ),
      actions: [
        Button(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _guardar,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
