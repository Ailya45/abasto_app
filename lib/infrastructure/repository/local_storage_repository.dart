import 'package:abasto_app/domain/datasource/local_storage_datasource.dart';
import 'package:abasto_app/domain/entities/facturacion.dart';
import 'package:abasto_app/domain/entities/movimiento_inventario.dart';
import 'package:abasto_app/domain/entities/product.dart';
import 'package:abasto_app/domain/entities/venta.dart';
import 'package:abasto_app/domain/repository/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDataSource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<void> addProduct(Product product) {
    return datasource.addProduct(product);
  }

  @override
  Future<void> deleteProduct(Product product) {
    return datasource.deleteProduct(product);
  }

  @override
  Future<bool> isProductSaved(String barcode) {
    return datasource.isProductSaved(barcode);
  }

  @override
  Future<void> updateProduct(Product product) {
    return datasource.updateProduct(product);
  }

  @override
  Stream<List<Product>> watchAllProducts() {
    return datasource.watchAllProducts();
  }

  @override
  Stream<Product?> watchProductByBarcode(String barcode) {
    return datasource.watchProductByBarcode(barcode);
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) {
    return datasource.getProductsByCategory(category);
  }

  @override
  Stream<List<Product>> watchProductsByFilter(String name) {
    return datasource.watchProductsByFilter(name);
  }

  @override
  Future<void> ajusteStock(
    Product product, {
    required int stockAnterior,
    required String tipoMovimiento,
    required String motivo,
  }) {
    return datasource.ajusteStock(
      product,
      stockAnterior: stockAnterior,
      tipoMovimiento: tipoMovimiento,
      motivo: motivo,
    );
  }
  
  @override
  Stream<List<MovimientoInventario>> watchInventarioMovimientos() {
    return datasource.watchInventarioMovimientos();
  }

  @override
  Future<Product?> getProductByBarcode(String barcode) {
    return datasource.getProductByBarcode(barcode);
  }

  @override
  Future<void> registrarVenta({
    required Venta venta,
    required List<Facturacion> detalle,
  }) {
    return datasource.registrarVenta(venta: venta, detalle: detalle);
  }

  @override
  Future<List<Facturacion>> getDetalleVenta(String ventaId) {
    return datasource.getDetalleVenta(ventaId);
  }

  @override
  Stream<List<Venta>> watchAllVentas() {
    return datasource.watchAllVentas();
  }

  @override
  Future<String?> getConfigValue(String clave) {
    return datasource.getConfigValue(clave);
  }

  @override
  Future<void> setConfigValue(String clave, String valor) {
    return datasource.setConfigValue(clave, valor);
  }
}
