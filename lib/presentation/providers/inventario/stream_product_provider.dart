import 'package:abasto_app/domain/entities/movimiento_inventario.dart';
import 'package:abasto_app/domain/entities/product.dart';
import 'package:abasto_app/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamProductProvider = StreamProvider<List<Product>>((ref) {
  final db = ref.watch(localStorageRepositoryProvider);
  return db.watchAllProducts();
});

final streamHistorialInventarioProvider = StreamProvider<List<MovimientoInventario>>((ref) {
  final db = ref.watch(localStorageRepositoryProvider);
  return db.watchInventarioMovimientos();
});