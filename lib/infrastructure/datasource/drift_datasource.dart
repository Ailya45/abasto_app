import 'package:abasto_app/config/database/local_database.dart';
import 'package:abasto_app/domain/datasource/local_storage_datasource.dart';
import 'package:abasto_app/domain/entities/product.dart';
import 'package:abasto_app/infrastructure/mappers/product_mapper.dart';
import 'package:drift/drift.dart';
import 'package:abasto_app/domain/entities/movimiento_inventario.dart';

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
}
