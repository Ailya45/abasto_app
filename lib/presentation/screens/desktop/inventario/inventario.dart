import 'package:abasto_app/domain/entities/product.dart';
import 'package:abasto_app/presentation/providers/inventario/stream_product_provider.dart';
import 'package:abasto_app/presentation/providers/productos/product_provider.dart';
import 'package:abasto_app/presentation/screens/desktop/inventario/actualizar_stock.dart';
import 'package:abasto_app/presentation/screens/desktop/inventario/editar_precio.dart';
import 'package:abasto_app/presentation/widgets/custom_table_widget.dart';
import 'package:abasto_app/presentation/widgets/glass_card.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InventarioScreen extends ConsumerWidget {
  const InventarioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productosAsync = ref.watch(streamProductProvider);

    return ScaffoldPage(
      header: const PageHeader(title: Text('Inventario')),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: productosAsync.when(
          loading: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProgressRing(),
                SizedBox(height: 16),
                Text('Cargando productos...'),
              ],
            ),
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
                  ref.invalidate(streamProductProvider);
                },
              ),
            ),
          ),
          data: (productos) => Container(
            decoration: BoxDecoration(
              color: glassSurface(context, alpha: 0.40),
              borderRadius: BorderRadius.circular(8),
              border: glassBorder(context),
            ),
            clipBehavior: Clip.antiAlias,
            child: CustomTableWidget<Product>(
              items: productos,
              columns: [
                // Columna 1: Código
                TableColumn(
                  title: 'Código',
                  flex: 2,
                  cellBuilder: (item) => Text(item.barcode),
                ),
                // Columna 2: Nombre del Producto
                TableColumn(
                  title: 'Producto',
                  flex: 4,
                  cellBuilder: (item) => Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                // Columna 3: Precio ($)
                TableColumn(
                  title: 'Precio (USD)',
                  flex: 2,
                  cellBuilder: (item) =>
                      Text('\$ ${item.price.toStringAsFixed(2)}'),
                ),
                // Columna 4: Stock
                TableColumn(
                  title: 'Stock',
                  flex: 2,
                  cellBuilder: (item) => Text('${item.stock} uds'),
                ),
                // Columna 5: Acciones (Ancho fijo)
                TableColumn(
                  title: 'Acciones',
                  width: 140,
                  cellBuilder: (item) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(FluentIcons.money, size: 14),
                        onPressed: () =>
                            _mostrarDialogoEditarPrecio(context, ref, item),
                      ),
                      IconButton(
                        icon: const Icon(FluentIcons.edit, size: 14),
                        onPressed: () => _mostrarDialogoAjusteStock(context, ref, item),
                      ),
                      IconButton(
                        icon: const Icon(FluentIcons.delete, size: 14),
                        onPressed: () => _mostrarDialogoEliminar(context, ref, item),
                      ),
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

  Future<void> _mostrarDialogoAjusteStock(BuildContext context, WidgetRef ref, Product item) async {
    final resultado = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AjustarStockDialog(
        nombreProducto: item.name,
        stockActual: item.stock,
      ),
    );

    if (resultado != null) {
      try {
        await ref.read(productProvider.notifier).procesarAjusteStock(item, resultado);

        if (context.mounted) {
          displayInfoBar(
            context,
            builder: (context, close) {
              return InfoBar(
                title: const Text('Stock actualizado'),
                content: Text(
                  'El stock de ${item.name} se actualizó correctamente.',
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
      } catch (e) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return ContentDialog(
                title: const Text('Error'),
                content: Text(
                  'No se pudo actualizar el stock: ${e.toString()}',
                ),
                actions: [
                  Button(
                    child: const Text('Cerrar'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  Future<void> _mostrarDialogoEditarPrecio(
    BuildContext context,
    WidgetRef ref,
    Product item,
  ) async {
    final nuevoPrecio = await showDialog<double>(
      context: context,
      builder: (context) => EditarPrecioDialog(
        nombreProducto: item.name,
        precioActual: item.price,
      ),
    );

    if (nuevoPrecio == null) return;

    try {
      await ref
          .read(productProvider.notifier)
          .updateProduct(item.copyWith(price: nuevoPrecio));

      if (context.mounted) {
        displayInfoBar(
          context,
          builder: (context, close) {
            return InfoBar(
              title: const Text('Precio actualizado'),
              content: Text(
                'El precio de ${item.name} se actualizó a '
                '\$ ${nuevoPrecio.toStringAsFixed(2)}.',
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
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return ContentDialog(
              title: const Text('Error'),
              content: Text(
                'No se pudo actualizar el precio: ${e.toString()}',
              ),
              actions: [
                Button(
                  child: const Text('Cerrar'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> _mostrarDialogoEliminar(BuildContext context, WidgetRef ref, Product item) async {
    showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
          title: const Text('Eliminar producto'),
          content: Text(
            '¿Está seguro de que desea eliminar el producto "${item.name}"?',
          ),
          actions: [
            Button(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
            ),
            Button(
              child: const Text('Eliminar'),
              onPressed: () async {
                try {
                  await ref.read(productProvider.notifier).deleteProduct(item);
                  if (context.mounted) Navigator.pop(context);
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context); // Cerrar el diálogo principal
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ContentDialog(
                          title: const Text('Error'),
                          content: Text(
                            'No se pudo eliminar el producto: ${e.toString()}',
                          ),
                          actions: [
                            Button(
                              child: const Text('Cerrar'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
