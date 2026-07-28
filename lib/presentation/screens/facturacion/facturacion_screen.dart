import 'package:abasto_app/domain/entities/facturacion.dart';
import 'package:abasto_app/presentation/screens/facturacion/panel_tabla_facturacion.dart';
import 'package:abasto_app/presentation/screens/facturacion/resumen_pago_panel.dart';
import 'package:fluent_ui/fluent_ui.dart';

class FacturacionScreen extends StatelessWidget {
  FacturacionScreen({super.key});

  final List<Facturacion> listaProductos = [
    Facturacion(
      productoCodigo: '8385748',
      productoNombre: 'Harina de maiz',
      precioUnitario: 12.5,
      cantidadVendida: 1,
      subTotal: 12.5,
    ),
    Facturacion(
      productoCodigo: '7485748',
      productoNombre: 'Harina de maiz',
      precioUnitario: 12.5,
      cantidadVendida: 1,
      subTotal: 12.5,
    ),
    Facturacion(
      productoCodigo: '6485748',
      productoNombre: 'Harina de maiz',
      precioUnitario: 12.5,
      cantidadVendida: 1,
      subTotal: 12.5,
    ),
    Facturacion(
      productoCodigo: '5485748',
      productoNombre: 'Harina de maiz',
      precioUnitario: 12.5,
      cantidadVendida: 1,
      subTotal: 12.5,
    ),
    Facturacion(
      productoCodigo: '4485748',
      productoNombre: 'Harina de maiz',
      precioUnitario: 12.5,
      cantidadVendida: 1,
      subTotal: 12.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text('Facturación'),
        commandBar: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FluentIcons.money,
              size: 16,
              color: FluentTheme.of(context).accentColor,
            ),
            SizedBox(width: 8),

            SizedBox(
              width: 100,
              child: TextBox(
                placeholder: 'Ref. Dolar',
                style: FluentTheme.of(
                  context,
                ).typography.bodyStrong?.copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // PANEL IZQUIERDO: La Tabla (70% del espacio)
          PanelTablaFacturacion(listaProductos: listaProductos),

          // PANEL DERECHO: Espacio para los Totales y Pago (30% del espacio)
          Expanded(flex: 3, child: ResumenPagoPanel()),
        ],
      ),
    );
  }
}
