import 'package:abasto_app/domain/entities/product.dart';
import 'package:abasto_app/domain/repository/local_storage_repository.dart';
import 'package:abasto_app/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider = StateNotifierProvider((ref) {
  return StoraProductProvider(
    localRepositoryProivder: ref.watch(localStorageRepositoryProvider),
  );
});

class StoraProductProvider extends StateNotifier<List<Product>> {
  StoraProductProvider({required this.localRepositoryProivder}) : super([]);

  final LocalStorageRepository localRepositoryProivder;

  Future<void> addProduct(Product product) async {
    final isSaved = await localRepositoryProivder.isProductSaved(
      product.barcode,
    );

    if (isSaved) {
      throw Exception('El producto ya existe');
    }

    await localRepositoryProivder.addProduct(product);

    state = [...state, product];
  }

  Future<void> updateProduct(Product product) async {
    await localRepositoryProivder.updateProduct(product);

    state = state
        .map((p) => p.barcode == product.barcode ? product : p)
        .toList();
  }

  Future<void> procesarAjusteStock(Product item, Map<String, dynamic> resultado) async {
    //Recibimos el resultado del diálogo
    final tipoOperacion = resultado['tipoOperacion'] as String;
    final cantidadStr = resultado['cantidad'] as String;
    final motivo = resultado['motivo'] as String;
    final cantidad = int.tryParse(cantidadStr) ?? 0;


    //Validamos que la cantidad no sea cero si es SUMAR_RESTAR
    if (cantidad == 0 && tipoOperacion == 'SUMAR_RESTAR') return;
    
    int nuevoStock = item.stock;
    String tipoMovimiento = 'AJUSTE';

    //Logica de ajuste para SUMAR_RESTAR y CONTEO_FISICO
    if (tipoOperacion == 'SUMAR_RESTAR') {
      nuevoStock = item.stock + cantidad;
      tipoMovimiento = cantidad > 0 ? 'ENTRADA' : 'SALIDA';
    } else if (tipoOperacion == 'CONTEO_FISICO') {
      if (cantidad == item.stock) return; 
      nuevoStock = cantidad;
      tipoMovimiento = nuevoStock > item.stock ? 'ENTRADA' : 'SALIDA';
    }

    //Validamos que el stock no sea negativo en CONTEO_FISICO
    if (nuevoStock < 0) nuevoStock = 0; 
    
    //Actualizamos el stock del producto
    final updatedProduct = item.copyWith(stock: nuevoStock);
    
    //Llamamos al método ajusteStock
    await ajusteStock(
      updatedProduct,
      stockAnterior: item.stock,
      tipoMovimiento: tipoMovimiento,
      motivo: motivo,
    );
  }

  Future<void> ajusteStock(
    Product product, {
    required int stockAnterior,
    required String tipoMovimiento,
    required String motivo,
  }) async {
    await localRepositoryProivder.ajusteStock(
      product,
      stockAnterior: stockAnterior,
      tipoMovimiento: tipoMovimiento,
      motivo: motivo,
    );
    // Update the local state to reflect the new stock
    state = state.map((p) => p.barcode == product.barcode ? product : p).toList();
  }

  Future<void> deleteProduct(Product product) async {
    await localRepositoryProivder.deleteProduct(product);

    state = state.where((p) => p.barcode != product.barcode).toList();
  }
}
