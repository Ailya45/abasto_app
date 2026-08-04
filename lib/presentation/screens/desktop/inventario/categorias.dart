import 'package:abasto_app/domain/entities/product.dart';
import 'package:abasto_app/presentation/providers/inventario/stream_product_provider.dart';
import 'package:abasto_app/presentation/widgets/glass_card.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// Información calculada de una categoría del inventario.
class _InfoCategoria {
  final String nombre;
  final List<Product> productos;
  final double totalPrecioUnitario;
  final double porcentajeValor;

  _InfoCategoria({
    required this.nombre,
    required this.productos,
    required this.totalPrecioUnitario,
    required this.porcentajeValor,
  });
}

class CategoriasScreen extends ConsumerWidget {
  const CategoriasScreen({super.key});

  static const String _sinCategoria = 'Sin categoría';

  List<_InfoCategoria> _agruparCategorias(List<Product> productos) {
    if (productos.isEmpty) return [];

    final agrupados = <String, List<Product>>{};
    for (final producto in productos) {
      final categoria = (producto.category == null ||
              producto.category!.trim().isEmpty ||
              producto.category == _sinCategoria)
          ? _sinCategoria
          : producto.category!.trim();
      agrupados.putIfAbsent(categoria, () => []).add(producto);
    }

    final totalValor = productos.fold<double>(
      0,
      (sum, p) => sum + (p.price * p.stock),
    );

    final categorias = agrupados.entries.map((entry) {
      final lista = entry.value;
      final valorCategoria = lista.fold<double>(
        0,
        (sum, p) => sum + (p.price * p.stock),
      );
      return _InfoCategoria(
        nombre: entry.key,
        productos: lista,
        totalPrecioUnitario: lista.fold(0, (sum, p) => sum + p.price),
        porcentajeValor: totalValor == 0
            ? 0
            : (valorCategoria / totalValor) * 100,
      );
    }).toList();

    categorias.sort((a, b) => b.porcentajeValor.compareTo(a.porcentajeValor));
    return categorias;
  }

  Future<void> _mostrarModalCategoria(
    BuildContext context,
    _InfoCategoria categoria,
  ) async {
    await showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
          title: Text(categoria.nombre),
          content: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 480,
              maxHeight: 480,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'N° de productos: ${categoria.productos.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total precio unitario: '
                  '\$ ${categoria.totalPrecioUnitario.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 8),
                Text(
                  'Porcentaje del inventario: '
                  '${categoria.porcentajeValor.toStringAsFixed(2)}%',
                ),
                const SizedBox(height: 16),
                const Text(
                  'Productos:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: categoria.productos.length,
                    separatorBuilder: (_, _) => const Divider(
                      style: DividerThemeData(verticalMargin: EdgeInsets.zero),
                    ),
                    itemBuilder: (context, index) => Text(
                      '• ${categoria.productos[index].name}',
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTarjeta(BuildContext context, _InfoCategoria categoria) {
    return GestureDetector(
      onTap: () => _mostrarModalCategoria(context, categoria),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: glassBorder(context),
          color: glassSurface(context, alpha: 0.55),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: FluentTheme.of(context).shadowColor.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  FluentIcons.category_classification,
                  size: 18,
                  color: FluentTheme.of(context).accentColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    categoria.nombre,
                    style: FluentTheme.of(
                      context,
                    ).typography.bodyStrong?.copyWith(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '${categoria.productos.length} producto'
              '${categoria.productos.length == 1 ? '' : 's'}',
              style: FluentTheme.of(context).typography.body,
            ),
            const SizedBox(height: 4),
            Text(
              '${categoria.porcentajeValor.toStringAsFixed(1)}% del inventario',
              style: FluentTheme.of(context).typography.body,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productosAsync = ref.watch(streamProductProvider);

    return ScaffoldPage(
      header: const PageHeader(title: Text('Categorías')),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: productosAsync.when(
          loading: () => const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProgressRing(),
                SizedBox(height: 16),
                Text('Cargando categorías...'),
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
          data: (productos) {
            final categorias = _agruparCategorias(productos);

            if (categorias.isEmpty) {
              return const Center(
                child: Text('No hay productos en el inventario'),
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                final columnas =
                    (constraints.maxWidth / 280).floor().clamp(2, 4);
                return MasonryGridView.count(
                  crossAxisCount: columnas,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  itemCount: categorias.length,
                  itemBuilder: (context, index) =>
                      _buildTarjeta(context, categorias[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
