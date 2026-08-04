import 'package:abasto_app/config/helpers/formaters.dart';
import 'package:abasto_app/domain/entities/facturacion.dart';
import 'package:abasto_app/domain/entities/venta.dart';
import 'package:abasto_app/presentation/providers/facturacion/facturacion_provider.dart';
import 'package:abasto_app/presentation/providers/storage/local_storage_provider.dart';
import 'package:abasto_app/presentation/widgets/custom_table_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistorialVentasScreen extends ConsumerWidget {
  const HistorialVentasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ventasAsync = ref.watch(streamVentasProvider);

    return ScaffoldPage(
      header: const PageHeader(title: Text('Historial de Ventas')),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ventasAsync.when(
          data: (ventas) => ventas.isEmpty
              ? const Center(child: Text('No hay ventas registradas'))
              : CustomTableWidget<Venta>(
                  items: ventas,
                  columns: [
                    TableColumn(
                      title: 'Fecha',
                      flex: 3,
                      cellBuilder: (item) =>
                          Text(formatearFechaHora(item.date)),
                    ),
                    TableColumn(
                      title: 'Método de pago',
                      flex: 2,
                      cellBuilder: (item) => Text(item.metodoPago),
                    ),
                    TableColumn(
                      title: 'Tasa (Bs/\$)',
                      flex: 2,
                      cellBuilder: (item) =>
                          Text(item.tasaDolarUsada.toStringAsFixed(2)),
                    ),
                    TableColumn(
                      title: 'Total (\$)',
                      flex: 2,
                      cellBuilder: (item) =>
                          Text('\$ ${item.montoTotalDolar.toStringAsFixed(2)}'),
                    ),
                    TableColumn(
                      title: 'Total (Bs)',
                      flex: 2,
                      cellBuilder: (item) => Text(
                        'Bs. ${(item.montoTotalDolar * item.tasaDolarUsada * 1.16).toStringAsFixed(2)}',
                      ),
                    ),
                    TableColumn(
                      title: 'Detalle',
                      width: 80,
                      cellBuilder: (item) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(FluentIcons.view, size: 14),
                            onPressed: () =>
                                _mostrarDetalle(context, ref, item),
                          ),
                        ],
                      ),
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
                  ref.invalidate(streamVentasProvider);
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
                Text('Cargando ventas...'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _mostrarDetalle(
    BuildContext context,
    WidgetRef ref,
    Venta venta,
  ) async {
    try {
      final detalle = await ref
          .read(localStorageRepositoryProvider)
          .getDetalleVenta(venta.id);

      if (!context.mounted) return;

      showDialog(
        context: context,
        builder: (context) {
          final size = MediaQuery.of(context).size;

          return ContentDialog(
            // Establecemos límites seguros basados en el tamaño de la pantalla
            constraints: BoxConstraints(
              maxWidth: (size.width * 0.8).clamp(
                600.0,
                900.0,
              ), // Entre 600px y 900px máximo
              maxHeight: (size.height * 0.7).clamp(400.0, 600.0),
            ),
            title: Text(
              'Detalle de la venta - ${formatearFechaHora(venta.date)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            content: SizedBox(
              width: double
                  .infinity, // Ocupa todo el ancho que le concedió el ContentDialog
              height: size.height * 0.5,
              child: CustomTableWidget<Facturacion>(
                items: detalle,
                rowPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                columns: [
                  TableColumn(
                    title: 'Código',
                    flex: 2,
                    cellBuilder: (item) => Text(
                      item.productoCodigo,
                      style: const TextStyle(fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Producto',
                    flex: 5, // 👈 Se mantiene el espacio amplio para el nombre
                    cellBuilder: (item) => Text(
                      item.productoNombre,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TableColumn(
                    title: 'Cant.',
                    flex: 1,
                    titleTextAlign: TextAlign.right,
                    cellBuilder: (item) => Text(
                      '${item.cantidadVendida}',
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  TableColumn(
                    title: 'P. Unit (\$)',
                    flex: 2,
                    titleTextAlign: TextAlign.right,
                    cellBuilder: (item) => Text(
                      '\$${item.precioUnitario.toStringAsFixed(2)}',
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  TableColumn(
                    title: 'Subtotal (\$)',
                    flex: 2,
                    titleTextAlign: TextAlign.right,
                    cellBuilder: (item) => Text(
                      '\$${item.subTotal.toStringAsFixed(2)}',
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              FilledButton(
                child: const Text('Cerrar'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (context.mounted) {
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
}
