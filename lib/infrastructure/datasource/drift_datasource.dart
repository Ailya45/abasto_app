import 'package:abasto_app/config/database/local_database.dart';
import 'package:abasto_app/domain/datasource/local_storage_datasource.dart';
import 'package:abasto_app/domain/entities/facturacion.dart';
import 'package:abasto_app/domain/entities/movimiento_inventario.dart';
import 'package:abasto_app/domain/entities/product.dart';
import 'package:abasto_app/domain/entities/venta.dart' as dominio;
import 'package:abasto_app/infrastructure/mappers/product_mapper.dart';
import 'package:abasto_app/infrastructure/mappers/venta_mapper.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class DriftDatasource extends LocalStorageDataSource {
  final AppDatabase database;

  DriftDatasource([AppDatabase? database]) : database = database ?? db;

  // ─── CRUD ────────────────────────────────────────────────────────────────────

  @override
  Future<void> addProduct(Product product) async {
    //construir query
    final query = database.select(database.productos);
    query.where((t) => t.codigoBarras.equals(product.barcode));

    final result = await query.get();

    if (result.isNotEmpty) throw Exception('El producto ya existe');

    //Ejecutar query

    await database.transaction(() async {
      // Insertar producto
      await database
          .into(database.productos)
          .insert(
            ProductosCompanion.insert(
              codigoBarras: product.barcode,
              nombre: product.name,
              categoria: Value(product.category),
              precioUnitarioDolar: product.price,
              cantidadStock: product.stock,
            ),
          );

      // Registrar movimiento de entrada si hay stock inicial
      if (product.stock > 0) {
        await database
            .into(database.movimientosInventario)
            .insert(
              MovimientosInventarioCompanion.insert(
                productoCodigo: product.barcode,
                nombreProducto: product.name,
                tipoMovimiento: 'ENTRADA',
                stockAnterior: 0,
                stockNuevo: product.stock,
                motivo: const Value('Carga inicial'),
              ),
            );
      }
    });
  }

  @override
  Future<void> updateProduct(Product product) async {
    // Buscar por PK (codigoBarras), no por nombre
    await (database.update(
      database.productos,
    )..where((t) => t.codigoBarras.equals(product.barcode))).write(
      ProductosCompanion(
        precioUnitarioDolar: Value(product.price),
        cantidadStock: Value(product.stock),
      ),
    );
  }

  @override
  Future<void> ajusteStock(
    Product product, {
    required int stockAnterior,
    required String tipoMovimiento,
    required String motivo,
  }) async {
    // 1. Actualizar el stock en la tabla de productos (Esto disparará el Stream)
    await (database.update(database.productos)
          ..where((t) => t.codigoBarras.equals(product.barcode)))
        .write(ProductosCompanion(cantidadStock: Value(product.stock)));

    // 2. Registrar el movimiento en el historial
    await database.transaction(() async {
      await database
          .into(database.movimientosInventario)
          .insert(
            MovimientosInventarioCompanion.insert(
              productoCodigo: product.barcode,
              nombreProducto: product.name,
              tipoMovimiento: tipoMovimiento,
              stockAnterior: stockAnterior,
              stockNuevo: product.stock,
              motivo: Value(motivo),
              fecha: Value(DateTime.now()),
            ),
          );
    });
  }

  @override
  Future<void> deleteProduct(Product product) async {
    // Borrar por PK (codigoBarras), no por nombre
    //construir query
    final query = database.delete(database.productos);
    query.where((t) => t.codigoBarras.equals(product.barcode));

    //Ejecutar query
    await query.go();

    await database.transaction(() async {
      await (database.delete(
        database.movimientosInventario,
      )..where((t) => t.productoCodigo.equals(product.barcode))).go();

      await (database.delete(
        database.productos,
      )..where((t) => t.codigoBarras.equals(product.barcode))).go();
    });
  }

  // ─── QUERIES DE LECTURA ──────────────────────────────────────────────────────

  @override
  Future<bool> isProductSaved(String barcode) async {
    //construir query
    final query = database.select(database.productos);
    query.where((t) => t.codigoBarras.equals(barcode));

    //Ejecutar query
    final result = await query.get();
    return result.isNotEmpty;
  }

  @override
  Stream<List<Product>> watchAllProducts() {
    //construir query
    final query = database.select(database.productos);

    //Ejecutar query
    final listProduct = query.watch();

    //retonat valor
    return listProduct.map((rows) => rows.map(toProduct).toList());
  }

  @override
  Stream<Product?> watchProductByBarcode(String barcode) {
    //construir query
    final query = database.select(database.productos);
    query.where((t) => t.codigoBarras.equals(barcode));

    //Ejecutar query
    final result = query.watchSingleOrNull();

    //retonar valor
    return result.map((row) => row == null ? null : toProduct(row));
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    //construir query
    final query = database.select(database.productos);
    query.where((t) => t.categoria.equals(category));

    //Ejecutar query
    final rows = await query.get();

    //retonar valor
    return rows.map(toProduct).toList();
  }

  @override
  Stream<List<Product>> watchProductsByFilter(String name) {
    //construir query
    final query = database.select(database.productos);
    query.where((t) => t.nombre.contains(name));

    //Ejecutar query
    final listProduct = query.watch();

    //retonar valor
    return listProduct.map((rows) => rows.map(toProduct).toList());
  }

  @override
  Stream<List<MovimientoInventario>> watchInventarioMovimientos() {
    //construir query
    final query = database.select(database.movimientosInventario);
    query.orderBy([
      (t) => OrderingTerm(expression: t.fecha, mode: OrderingMode.desc),
    ]);
    //Ejecutar query
    return query.watch().map((rows) => rows.map(toMovimientoInventario).toList());
  }

  // ─── FACTURACIÓN ────────────────────────────────────────────────────────────

  @override
  Future<Product?> getProductByBarcode(String barcode) async {
    //construir query
    final query = database.select(database.productos);
    query.where((t) => t.codigoBarras.equals(barcode));

    //Ejecutar query
    final row = await query.getSingleOrNull();

    //retornar valor
    return row == null ? null : toProduct(row);
  }

  @override
  Future<void> registrarVenta({
    required dominio.Venta venta,
    required List<Facturacion> detalle,
  }) async {
    await database.transaction(() async {
      // 1. Insertar la venta
      await database
          .into(database.ventas)
          .insert(
            VentasCompanion.insert(
              id: venta.id,
              fecha: Value(venta.date),
              tasaDolarUsada: venta.tasaDolarUsada,
              montoTotalDolar: venta.montoTotalDolar,
              metodoPago: venta.metodoPago,
              montoTotalBs: venta.montoTotalBs,
            ),
          );

      // 2. Insertar el detalle y descontar el stock de cada producto
      for (final item in detalle) {
        await database
            .into(database.detalleVentas)
            .insert(
              DetalleVentasCompanion.insert(
                id: const Uuid().v4(),
                ventaId: venta.id,
                productoCodigo: item.productoCodigo,
                precioUnitario: item.precioUnitario,
                cantidadVendida: item.cantidadVendida.toDouble(),
                subTotal: item.subTotal,
              ),
            );

        // Leer stock actual del producto
        final query = database.select(database.productos)
          ..where((t) => t.codigoBarras.equals(item.productoCodigo));
        final producto = await query.getSingleOrNull();

        if (producto == null) {
          throw Exception('El producto ${item.productoCodigo} no existe');
        }
        if (producto.cantidadStock < item.cantidadVendida) {
          throw Exception(
            'Stock insuficiente para ${item.productoNombre}: '
            'disponible ${producto.cantidadStock}',
          );
        }

        final stockNuevo = producto.cantidadStock - item.cantidadVendida;

        // Actualizar el stock del producto
        await (database.update(database.productos)
              ..where((t) => t.codigoBarras.equals(item.productoCodigo)))
            .write(ProductosCompanion(cantidadStock: Value(stockNuevo)));

        // Registrar el movimiento de salida por venta
        await database
            .into(database.movimientosInventario)
            .insert(
              MovimientosInventarioCompanion.insert(
                productoCodigo: item.productoCodigo,
                nombreProducto: item.productoNombre,
                tipoMovimiento: 'SALIDA',
                stockAnterior: producto.cantidadStock,
                stockNuevo: stockNuevo,
                motivo: const Value('Venta'),
              ),
            );
      }
    });
  }

  @override
  Future<List<Facturacion>> getDetalleVenta(String ventaId) async {
    //construir query con JOIN para obtener el nombre del producto
    final query = database.select(database.detalleVentas).join([
      innerJoin(
        database.productos,
        database.productos.codigoBarras.equalsExp(
          database.detalleVentas.productoCodigo,
        ),
      ),
    ])..where(database.detalleVentas.ventaId.equals(ventaId));

    //Ejecutar query
    final rows = await query.get();

    //retornar valor
    return rows.map((row) {
      final detalle = row.readTable(database.detalleVentas);
      final producto = row.readTable(database.productos);
      return Facturacion(
        productoCodigo: detalle.productoCodigo,
        productoNombre: producto.nombre,
        precioUnitario: detalle.precioUnitario,
        cantidadVendida: detalle.cantidadVendida.toInt(),
        subTotal: detalle.subTotal,
      );
    }).toList();
  }

  @override
  Stream<List<dominio.Venta>> watchAllVentas() {
    //construir query
    final query = database.select(database.ventas);
    query.orderBy([
      (t) => OrderingTerm(expression: t.fecha, mode: OrderingMode.desc),
    ]);

    //Ejecutar query
    return query.watch().map((rows) => rows.map(toVenta).toList());
  }

  // ─── CONFIGURACIÓN ──────────────────────────────────────────────────────────

  @override
  Future<String?> getConfigValue(String clave) async {
    //construir query
    final query = database.select(database.configuracion);
    query.where((t) => t.clave.equals(clave));

    //Ejecutar query
    final row = await query.getSingleOrNull();

    //retornar valor
    return row?.valor;
  }

  @override
  Future<void> setConfigValue(String clave, String valor) async {
    await database.into(database.configuracion).insert(
          ConfiguracionCompanion.insert(
            clave: clave,
            valor: valor,
            updatedAt: Value(DateTime.now()),
          ),
          onConflict: DoUpdate(
            (old) => ConfiguracionCompanion(
              valor: Value(valor),
              updatedAt: Value(DateTime.now()),
            ),
            target: [database.configuracion.clave],
          ),
        );
  }
}
