import 'package:abasto_app/config/helpers/formaters.dart';
import 'package:abasto_app/domain/entities/movimiento_inventario.dart';
import 'package:abasto_app/presentation/providers/inventario/stream_product_provider.dart';
import 'package:abasto_app/presentation/widgets/custom_table_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistorialInventarioScreen extends ConsumerWidget {
  const HistorialInventarioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historialAsync = ref.watch(streamHistorialInventarioProvider);
    return ScaffoldPage(
      header: const PageHeader(title: Text('Historial de Inventario')),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: historialAsync.when(
          data: (historial) => historial.isEmpty
              ? const Center(child: Text('No hay movimientos de inventario'))
              : CustomTableWidget<MovimientoInventario>(
            items: historial,
            columns: [
              TableColumn(
                title: 'Fecha',
                flex: 2,
                cellBuilder: (item) => Text(formatearFechaHora(item.fecha)),
              ),
              TableColumn(
                title: 'Producto',
                flex: 4,
                cellBuilder: (item) => Text(
                  item.nombreProducto,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TableColumn(
                title: 'Stock Anterior',
                flex: 2,
                cellBuilder: (item) => Text('${item.stockAnterior} uds'),
              ),
              TableColumn(
                title: 'Stock Nuevo',
                flex: 2,
                cellBuilder: (item) => Text('${item.stockNuevo}'),
              ),
              TableColumn(
                title: 'Movimiento',
                flex: 2,
                cellBuilder: (item) => Text(item.tipoMovimiento),
              ),
              TableColumn(
                title: 'Motivo',
                flex: 2,
                cellBuilder: (item) => Text(item.motivo),
              ),
            ],
          ),
          error: (error, stack) => Center(
            child: InfoBar(
              title: const Text('Error al cargar'),
              content: Text(error.toString()),
              severity: InfoBarSeverity.error,
              isLong: true,
              action: FilledButton(
                child: const Text('Reintentar'),
                onPressed: () {
                  ref.invalidate(streamHistorialInventarioProvider);
                },
              ),
            ),
          ),
          loading: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProgressRing(),
                SizedBox(height: 16),
                Text('Cargando historial...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
