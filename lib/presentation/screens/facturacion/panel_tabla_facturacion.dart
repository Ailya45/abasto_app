import 'package:abasto_app/domain/entities/facturacion.dart';
import 'package:abasto_app/presentation/widgets/custom_table_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';

class PanelTablaFacturacion extends StatelessWidget {
  final List<Facturacion> listaProductos;

  const PanelTablaFacturacion({
    super.key,
    required this.listaProductos,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
            child: TextBox(
              placeholder: 'Buscar Producto',
              autofocus: true,
              prefix: const Icon(FluentIcons.search),
              style: FluentTheme.of(
                context,
              ).typography.bodyStrong?.copyWith(fontSize: 14),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              color: FluentTheme.of(context).cardColor,
              child: CustomTableWidget<Facturacion>(
                items: listaProductos,
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
                    cellBuilder: (item) => Text(
                      '\$ ${item.precioUnitario.toStringAsFixed(2)}',
                    ),
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
                          onChanged: (value) {},
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
                          onPressed: () {},
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
