import 'package:abasto_app/domain/entities/facturacion.dart';
import 'package:abasto_app/domain/entities/movimiento_inventario.dart';
import 'package:abasto_app/domain/entities/product.dart';
import 'package:abasto_app/domain/entities/venta.dart';

abstract class LocalStorageRepository {
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

  // ─── Facturación ───────────────────────────────────────────────────────────
  Future<Product?> getProductByBarcode(String barcode);
  Future<void> registrarVenta({
    required Venta venta,
    required List<Facturacion> detalle,
  });
  Future<List<Facturacion>> getDetalleVenta(String ventaId);
  Stream<List<Venta>> watchAllVentas();

  // ─── Configuración ─────────────────────────────────────────────────────────
  Future<String?> getConfigValue(String clave);
  Future<void> setConfigValue(String clave, String valor);
}