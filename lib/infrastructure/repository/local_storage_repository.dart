import 'package:abasto_app/domain/datasource/local_storage_datasource.dart';
import 'package:abasto_app/domain/entities/movimiento_inventario.dart';
import 'package:abasto_app/domain/entities/product.dart';
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
}
