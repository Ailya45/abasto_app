import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AjustarStockDialog extends ConsumerStatefulWidget {
  final String nombreProducto;
  final int stockActual;

  const AjustarStockDialog({
    super.key,
    required this.nombreProducto,
    required this.stockActual,
  });

  @override
  ConsumerState<AjustarStockDialog> createState() => _AjustarStockDialogState();
}

class _AjustarStockDialogState extends ConsumerState<AjustarStockDialog> {
  // Estado local del diálogo
  String _tipoOperacion = 'SUMAR_RESTAR'; // 'SUMAR_RESTAR' o 'CONTEO_FISICO'
  String _motivo = 'Compra / Nuevo Lote';
  final TextEditingController _cantidadController = TextEditingController();

  // Lista de motivos predefinidos
  final List<String> _motivosSumarResta = [
    'Compra / Nuevo Lote',
    'Mercancía Dañada / Vencida',
    'Devolución de Cliente',
  ];

  final List<String> _motivosConteoFisico = [
    'Ajuste por Conteo Físico',
    'Error de Tipeo Previo',
    'Auditoría de Inventario',
  ];

  @override
  Widget build(BuildContext context) {
    // Definimos qué lista de motivos mostrar según la operación
    final listaMotivosActuales = _tipoOperacion == 'SUMAR_RESTAR'
        ? _motivosSumarResta
        : _motivosConteoFisico;

    return ContentDialog(
      title: Text('Ajustar Stock: ${widget.nombreProducto}'),
      content: Column(
        mainAxisSize: MainAxisSize
            .min, // 👈 IMPORTANTE: Para que el diálogo no ocupe toda la pantalla vertical
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stock actual en sistema: ${widget.stockActual}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // 1. ComboBox: Tipo de Ajuste
          InfoLabel(label: 'Tipo de operación:'),
          ComboBox<String>(
            value: _tipoOperacion,
            isExpanded: true, // Ocupa todo el ancho disponible
            items: const [
              ComboBoxItem(
                value: 'SUMAR_RESTAR',
                child: Text('Sumar / Restar cantidad (+ / -)'),
              ),
              ComboBoxItem(
                value: 'CONTEO_FISICO',
                child: Text('Fijar stock real (Conteo físico)'),
              ),
            ],
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  _tipoOperacion = val;
                  // Restablecemos el motivo al cambiar de tipo
                  _motivo = val == 'SUMAR_RESTAR'
                      ? _motivosSumarResta.first
                      : _motivosConteoFisico.first;
                });
              }
            },
          ),
          const SizedBox(height: 12),

          // 2. Campo para ingresar el número
          InfoLabel(
            label: _tipoOperacion == 'SUMAR_RESTAR'
                ? 'Cantidad a ingresar o retirar (ej: 12 o -2):'
                : 'Nuevo stock total contado:',
          ),
          TextBox(
            controller: _cantidadController,
            keyboardType: TextInputType.number,
            placeholder: _tipoOperacion == 'SUMAR_RESTAR' ? 'Ej: 10' : 'Ej: 45',
          ),
          const SizedBox(height: 12),

          // 3. ComboBox: Motivo del Ajuste
          InfoLabel(label: 'Motivo del ajuste:'),
          ComboBox<String>(
            value: _motivo,
            isExpanded: true,
            items: listaMotivosActuales.map((m) {
              return ComboBoxItem(value: m, child: Text(m));
            }).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _motivo = val);
            },
          ),
        ],
      ),
      actions: [
        // Botón Cancelar
        Button(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.pop(context, null), // Retorna null
        ),

        // Botón Guardar
        FilledButton(
          child: const Text('Guardar Ajuste'),
          onPressed: () {
            final valorIngresado = _cantidadController.text;
            if (valorIngresado.isEmpty) return;

            // Devolvemos el resultado empaquetado
            Navigator.pop(context, {
              'tipoOperacion': _tipoOperacion,
              'cantidad': valorIngresado,
              'motivo': _motivo,
            });
          },
        ),
      ],
    );
  }
}
