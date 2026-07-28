import 'package:abasto_app/domain/entities/product.dart';
import 'package:abasto_app/domain/entities/movimiento_inventario.dart';

abstract class LocalStorageDataSource {
  Future<void> addProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(Product product);
  Future<bool> isProductSaved(String barcode);
  Stream<List<Product>> watchAllProducts();
  Future<List<Product>> getProductsByCategory(String category);
  Stream<List<Product>> watchProductsByFilter(String name);
  Stream<Product?> watchProductByBarcode(String barcode);
  Stream<List<MovimientoInventario>> watchInventarioMovimientos();
  Future<void> ajusteStock(
    Product product, {
    required int stockAnterior,
    required String tipoMovimiento,
    required String motivo,
  });
}
