import 'package:abasto_app/domain/entities/facturacion.dart';
import 'package:abasto_app/presentation/providers/facturacion/facturacion_provider.dart';
import 'package:abasto_app/presentation/widgets/custom_table_widget.dart';
import 'package:abasto_app/presentation/widgets/glass_card.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PanelTablaFacturacion extends ConsumerStatefulWidget {
  final FocusNode busquedaFocusNode;

  const PanelTablaFacturacion({super.key, required this.busquedaFocusNode});

  @override
  ConsumerState<PanelTablaFacturacion> createState() =>
      _PanelTablaFacturacionState();
}

class _PanelTablaFacturacionState extends ConsumerState<PanelTablaFacturacion> {
  final TextEditingController _busquedaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _busquedaController.addListener(_onBusquedaChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.busquedaFocusNode.requestFocus();
      }
    });
  }

  void _onBusquedaChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _busquedaController.dispose();
    super.dispose();
  }

  void _refocusBusqueda() {
    Future.microtask(() {
      if (mounted && widget.busquedaFocusNode.canRequestFocus) {
        widget.busquedaFocusNode.requestFocus();
      }
    });
  }

  Future<void> _agregarProducto(String query) async {
    final texto = query.trim();
    if (texto.isEmpty) return;

    try {
      await ref.read(facturacionProvider.notifier).buscarYAgregar(texto);

      _busquedaController.clear();

      _refocusBusqueda();

      if (mounted) {
        displayInfoBar(
          context,
          builder: (context, close) {
            return InfoBar(
              title: const Text('Producto agregado'),
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
      _busquedaController.clear();

      _refocusBusqueda();

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

  Future<void> _quitarProducto(String porductoCodigo) async {
    try {
      ref.read(facturacionProvider.notifier).eliminarItem(porductoCodigo);

      _refocusBusqueda();
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

  Future<void> _cambiarCantidad(Facturacion item, int? cantidad) async {
    if (cantidad == null || cantidad == item.cantidadVendida) return;

    await ref
        .read(facturacionProvider.notifier)
        .cambiarCantidad(item.productoCodigo, cantidad);

    _refocusBusqueda();

    final stockDisponible = item.stockDisponible;
    if (mounted && stockDisponible != null && cantidad > stockDisponible) {
      displayInfoBar(
        context,
        builder: (context, close) {
          return InfoBar(
            title: const Text('Stock insuficiente'),
            content: Text(
              '${item.productoNombre}: solo hay $stockDisponible unidades '
              'disponibles. Corrige la cantidad para finalizar la venta.',
            ),
            severity: InfoBarSeverity.warning,
            action: IconButton(
              icon: const Icon(FluentIcons.clear),
              onPressed: close,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(facturacionProvider).items;

    return Expanded(
      flex: 7,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: TextBox(
              controller: _busquedaController,
              placeholder: 'Buscar Producto por código de barras',
              autofocus: true,
              focusNode: widget.busquedaFocusNode,
              prefix: const Icon(FluentIcons.search),
              suffix: _busquedaController.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(FluentIcons.clear, size: 14),
                      onPressed: () => _busquedaController.clear(),
                    ),
              style: FluentTheme.of(
                context,
              ).typography.bodyStrong?.copyWith(fontSize: 14),
              onSubmitted: _agregarProducto,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: glassSurface(context, alpha: 0.40),
                borderRadius: BorderRadius.circular(8),
                border: glassBorder(context),
              ),
              clipBehavior: Clip.antiAlias,
              child: CustomTableWidget<Facturacion>(
                items: items,
                mensajeVacio:
                    'Escanea o escribe un código de barras para iniciar la venta',
                columns: [
                  // Columna 1: Código
                  TableColumn(
                    title: 'Código',
                    flex: 2,
                    cellBuilder: (item) => Text(item.productoCodigo),
                  ),
                  // Columna 2: Nombre del Producto
                  TableColumn(
                    title: 'Nombre',
                    flex: 4,
                    cellBuilder: (item) => Text(
                      item.productoNombre,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Columna 3: Precio ($)
                  TableColumn(
                    title: 'P. Unitario',
                    flex: 2,
                    cellBuilder: (item) =>
                        Text('\$ ${item.precioUnitario.toStringAsFixed(2)}'),
                  ),
                  // Columna 4: Cantidad
                  TableColumn(
                    title: 'Cantidad',
                    flex: 2,
                    cellBuilder: (item) => Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 85,
                        child: NumberBox<int>(
                          value: item.cantidadVendida,
                          min: 1,
                          max: 999,
                          onChanged: (value) => _cambiarCantidad(item, value),
                          onEditingComplete: _refocusBusqueda,
                          mode: SpinButtonPlacementMode.none,
                          style: FluentTheme.of(
                            context,
                          ).typography.bodyStrong?.copyWith(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  // Columna 5: Subtotal
                  TableColumn(
                    title: 'Subtotal',
                    flex: 2,
                    cellBuilder: (item) =>
                        Text('Bs. ${item.subTotal.toStringAsFixed(2)}'),
                  ),
                  // Columna 6: Acciones
                  TableColumn(
                    title: 'Acciones',
                    width: 75,
                    cellBuilder: (item) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(FluentIcons.delete, size: 14),
                          onPressed: () => _quitarProducto(item.productoCodigo),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
