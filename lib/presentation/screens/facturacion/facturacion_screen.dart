import 'package:abasto_app/presentation/providers/facturacion/facturacion_provider.dart';
import 'package:abasto_app/presentation/screens/facturacion/panel_tabla_facturacion.dart';
import 'package:abasto_app/presentation/screens/facturacion/resumen_pago_panel.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FacturacionScreen extends ConsumerStatefulWidget {
  const FacturacionScreen({super.key});

  @override
  ConsumerState<FacturacionScreen> createState() => _FacturacionScreenState();
}

class _FacturacionScreenState extends ConsumerState<FacturacionScreen> {
  final FocusNode _lectorFocusNode = FocusNode();
  final TextEditingController _tasaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarTasa();
  }

  Future<void> _cargarTasa() async {
    final tasa = await ref.read(facturacionProvider.notifier).cargarTasaInicial();
    if (mounted && tasa > 0) {
      _tasaController.text = tasa.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _tasaController.dispose();
    _lectorFocusNode.dispose();
    super.dispose();
  }

  double? _parsearTasa(String value) {
    return double.tryParse(value.replaceAll(',', '.'));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Facturación'),
        commandBar: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FluentIcons.money,
              size: 16,
              color: FluentTheme.of(context).accentColor,
            ),
            const SizedBox(width: 8),

            SizedBox(
              width: 100,
              child: TextBox(
                controller: _tasaController,
                placeholder: 'Ref. Dolar',
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: FluentTheme.of(
                  context,
                ).typography.bodyStrong?.copyWith(fontSize: 14),
                onChanged: (value) {
                  final tasa = _parsearTasa(value);
                  if (tasa != null && tasa > 0) {
                    ref
                        .read(facturacionProvider.notifier)
                        .setTasaDolar(tasa, persist: false);
                  }
                },
                onSubmitted: (value) {
                  final tasa = _parsearTasa(value);
                  if (tasa != null && tasa > 0) {
                    ref
                        .read(facturacionProvider.notifier)
                        .setTasaDolar(tasa, persist: true);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // PANEL IZQUIERDO: La Tabla (70% del espacio)
          PanelTablaFacturacion(busquedaFocusNode: _lectorFocusNode),

          // PANEL DERECHO: Espacio para los Totales y Pago (30% del espacio)
          Expanded(
            flex: 3,
            child: ResumenPagoPanel(busquedaFocusNode: _lectorFocusNode),
          ),
        ],
      ),
    );
  }
}
