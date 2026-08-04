import 'package:abasto_app/domain/entities/venta.dart';
import 'package:abasto_app/presentation/providers/facturacion/facturacion_provider.dart';
import 'package:abasto_app/presentation/widgets/glass_card.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResumenPagoPanel extends ConsumerStatefulWidget {
  final FocusNode busquedaFocusNode;
  const ResumenPagoPanel({super.key, required this.busquedaFocusNode});

  @override
  ConsumerState<ResumenPagoPanel> createState() => _ResumenPagoPanelState();
}

class _ResumenPagoPanelState extends ConsumerState<ResumenPagoPanel> {
  final TextEditingController _montoRecibidoController =
      TextEditingController();
  final TextEditingController _precioBsController = TextEditingController();
  final TextEditingController _precioBsIvaController = TextEditingController();
  final TextEditingController _vueltoController = TextEditingController();

  static const List<String> _metodosPago = [
    'Efectivo',
    'Biopago',
    'Tarjeta de debito',
    'Tarjeta de credito',
    'Pago movil',
  ];

  @override
  void dispose() {
    _montoRecibidoController.dispose();
    _precioBsController.dispose();
    _precioBsIvaController.dispose();
    _vueltoController.dispose();

    super.dispose();
  }

  bool get _esEfectivo => state.metodoPago == 'Efectivo';

  FacturacionState get state => ref.watch(facturacionProvider);

  double get _montoRecibido =>
      double.tryParse(_montoRecibidoController.text.replaceAll(',', '.')) ?? 0;

  double get _vuelto => _esEfectivo ? _montoRecibido - state.totalBsIva : 0;

  bool get _puedeFinalizar =>
      state.items.isNotEmpty &&
      state.metodoPago != null &&
      state.tasaDolar > 0 &&
      !state.hayStockInsuficiente &&
      (!_esEfectivo ||
          (_montoRecibido >= state.totalBsIva && _montoRecibido > 0));

  /// Actualiza el texto de un campo de solo lectura sin crear controladores en cada build.
  TextBox _textoBs(
    TextEditingController controller,
    double valor, {
    required String placeholder,
  }) {
    final texto = valor == 0 ? '' : 'Bs. ${valor.toStringAsFixed(2)}';
    if (controller.text != texto) {
      controller.text = texto;
    }
    return TextBox(
      controller: controller,
      placeholder: placeholder,
      readOnly: true,
    );
  }

  Future<void> _finalizarVenta() async {
    final esEfectivo = _esEfectivo;
    final monto = esEfectivo ? _montoRecibido : state.totalBsIva;

    try {
      final venta = await ref
          .read(facturacionProvider.notifier)
          .finalizarVenta(montoRecibido: monto);
      _montoRecibidoController.clear();

      if (mounted) {
       await _mostrarResultadoVenta(venta, monto, esEfectivo);

        WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && widget.busquedaFocusNode.canRequestFocus) {
          widget.busquedaFocusNode.requestFocus();
        }
      });
      }
    } catch (e) {
      if (mounted) {
        displayInfoBar(
          context,
          builder: (context, close) {
            return InfoBar(
              title: const Text('Error'),
              content: Text(e.toString()),
              severity: InfoBarSeverity.error,
              action: IconButton(
                icon: const Icon(FluentIcons.clear),
                onPressed: close,
              ),
            );
          },
        );
      }
    }
  }

  Future<void> _mostrarResultadoVenta(
    Venta venta,
    double montoRecibido,
    bool esEfectivo,
  ) async {
    final vuelto =
        montoRecibido - venta.montoTotalDolar * venta.tasaDolarUsada * 1.16;
    final mostrarVuelto = esEfectivo && vuelto > 0;

    await showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
          title: const Text('Venta registrada'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Método de pago: ${venta.metodoPago}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Total a pagar: Bs. '
                '${(venta.montoTotalDolar * venta.tasaDolarUsada * 1.16).toStringAsFixed(2)}',
              ),
              if (mostrarVuelto) ...[
                const SizedBox(height: 8),
                Text('Monto recibido: Bs. ${montoRecibido.toStringAsFixed(2)}'),
                Text(
                  'Vuelto: Bs. ${vuelto.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ],
          ),
          actions: [
            FilledButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.pop(context);
                widget.busquedaFocusNode.requestFocus();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTotalPagar(context),
        Expanded(child: _buildResumenPagar(context)),
      ],
    );
  }

  Container _buildResumenPagar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.0),
        color: glassSurface(context, alpha: 0.45),
        border: glassBorder(context),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.center,
              'Resumen y Pago:',
              style: FluentTheme.of(
                context,
              ).typography.bodyStrong?.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 24),
            InfoLabel(
              label: 'Metodo de pago:',
              child: ComboBox<String>(
                value: state.metodoPago,
                placeholder: const Text('Seleccione un metodo de pago'),
                items: _metodosPago.map((metPago) {
                  return ComboBoxItem(value: metPago, child: Text(metPago));
                }).toList(),
                onChanged: (value) {
                  ref.read(facturacionProvider.notifier).setMetodoPago(value);
                },
              ),
            ),
            const SizedBox(height: 24),
            InfoLabel(
              label: 'Precio en Bs:',
              child: _textoBs(
                _precioBsController,
                state.totalBs,
                placeholder: 'Bs. 0.00',
              ),
            ),
            const SizedBox(height: 16),

            InfoLabel(
              label: 'Precio en Bs + IVA:',
              child: _textoBs(
                _precioBsIvaController,
                state.totalBsIva,
                placeholder: 'Bs. 0.00',
              ),
            ),
            const SizedBox(height: 16),

            InfoLabel(
              label: 'Total a pagar en Bs:',
              child: _textoBs(
                _precioBsIvaController,
                state.totalBsIva,
                placeholder: 'Bs. 0.00',
              ),
            ),

            if (_esEfectivo) ...[
              const SizedBox(height: 16),
              InfoLabel(
                label: 'Monto recibido (Bs):',
                child: TextBox(
                  controller: _montoRecibidoController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  placeholder: 'Bs. 0.00',
                  onChanged: (value) => setState(() {}),
                ),
              ),
              const SizedBox(height: 16),
              InfoLabel(
                label: 'Vuelto:',
                child: _textoBs(
                  _vueltoController,
                  _montoRecibido >= state.totalBsIva ? _vuelto : 0,
                  placeholder: 'Bs. 0.00',
                ),
              ),
            ],

            const SizedBox(height: 40),

            FilledButton(
              onPressed: _puedeFinalizar ? _finalizarVenta : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FluentIcons.payment_card),
                  SizedBox(width: 8),
                  Text("Finalizar Venta"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildTotalPagar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: glassSurface(context, alpha: 0.45),
        border: glassBorder(context),
      ),
      child: Column(
        children: [
          Text(
            "Total a pagar",
            style: FluentTheme.of(
              context,
            ).typography.bodyStrong?.copyWith(fontSize: 24),
          ),
          Text(
            "\$ ${state.totalDolar.toStringAsFixed(2)}",
            style: FluentTheme.of(context).typography.bodyStrong?.copyWith(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
