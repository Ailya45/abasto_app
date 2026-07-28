// ─── Mapper: Producto (Drift) → Product (dominio) ───────────────────────────
import 'package:abasto_app/config/database/local_database.dart';
import 'package:abasto_app/domain/entities/movimiento_inventario.dart';
import 'package:abasto_app/domain/entities/product.dart';

Product toProduct(Producto row) => Product(
  barcode: row.codigoBarras,
  name: row.nombre,
  category: row.categoria,
  price: row.precioUnitarioDolar,
  stock: row.cantidadStock,
);

MovimientoInventario toMovimientoInventario(MovimientosInventarioData row) =>
    MovimientoInventario(
      productoCodigo: row.productoCodigo,
      nombreProducto: row.nombreProducto,
      stockAnterior: row.stockAnterior,
      stockNuevo: row.stockNuevo,
      fecha: row.fecha,
      tipoMovimiento: row.tipoMovimiento,
      motivo: row.motivo ?? '',
    );
