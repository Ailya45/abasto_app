import 'dart:async';

import 'package:abasto_app/domain/entities/facturacion.dart';
import 'package:abasto_app/domain/entities/product.dart';
import 'package:abasto_app/domain/entities/venta.dart';
import 'package:abasto_app/domain/repository/local_storage_repository.dart';
import 'package:abasto_app/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final facturacionProvider = StateNotifierProvider<FacturacionProvider, FacturacionState>(
  (ref) {
    return FacturacionProvider(
      localRepositoryProivder: ref.watch(localStorageRepositoryProvider),
    );
  },
);

final streamVentasProvider = StreamProvider<List<Venta>>((ref) {
  final db = ref.watch(localStorageRepositoryProvider);
  return db.watchAllVentas();
});

class FacturacionState {
  final List<Facturacion> items;
  final double tasaDolar;
  final String? metodoPago;

  const FacturacionState({
    this.items = const [],
    this.tasaDolar = 0,
    this.metodoPago,
  });

  double get totalDolar => items.fold(
    0,
    (sum, item) => sum + (item.precioUnitario * item.cantidadVendida),
  );

  double get totalBs => totalDolar * tasaDolar;

  double get iva => totalBs * 0.16;

  double get totalBsIva => totalBs + iva;

  FacturacionState copyWith({
    List<Facturacion>? items,
    double? tasaDolar,
    String? metodoPago,
  }) {
    return FacturacionState(
      items: items ?? this.items,
      tasaDolar: tasaDolar ?? this.tasaDolar,
      metodoPago: metodoPago ?? this.metodoPago,
    );
  }
}

class FacturacionProvider extends StateNotifier<FacturacionState> {
  FacturacionProvider({required this.localRepositoryProivder})
    : super(const FacturacionState());

  final LocalStorageRepository localRepositoryProivder;

  /// Carga la tasa guardada en Configuracion (si existe) y la aplica al estado.
  Future<double> cargarTasaInicial() async {
    final valor = await localRepositoryProivder.getConfigValue('tasa_dolar_bcv');
    final tasa = double.tryParse(valor ?? '');
    if (tasa != null && tasa > 0) {
      state = state.copyWith(tasaDolar: tasa);
    }
    return state.tasaDolar;
  }

  void setTasaDolar(double tasa, {bool persist = true}) {
    if (tasa < 0) return;
    state = state.copyWith(tasaDolar: tasa);
    if (persist) {
      localRepositoryProivder.setConfigValue(
        'tasa_dolar_bcv',
        tasa.toString(),
      );
    }
  }

  void setMetodoPago(String? metodo) {
    state = state.copyWith(metodoPago: metodo);
  }

  /// Busca el producto por código de barras (o nombre exacto) y lo agrega a la
  /// venta. Si ya está en la lista, incrementa su cantidad.
  Future<void> buscarYAgregar(String query) async {
    final producto = await _buscarProducto(query);
    if (producto == null) {
      throw Exception('Producto no encontrado: $query');
    }
    await agregarProducto(producto);
  }

  Future<Product?> _buscarProducto(String query) async {
    final codigo = query.trim();
    if (codigo.isEmpty) return null;

    final porBarcode = await localRepositoryProivder.getProductByBarcode(codigo);
    if (porBarcode != null) return porBarcode;

    final todos = await localRepositoryProivder.watchAllProducts().first;
    for (final producto in todos) {
      if (producto.name.toLowerCase() == codigo.toLowerCase()) {
        return producto;
      }
    }
    return null;
  }

  Future<void> agregarProducto(Product producto) async {
    final items = List<Facturacion>.from(state.items);
    final index = items.indexWhere(
      (item) => item.productoCodigo == producto.barcode,
    );

    if (index == -1) {
      if (producto.stock <= 0) {
        throw Exception(
          'No hay stock disponible de ${producto.name}',
        );
      }
      items.add(
        Facturacion(
          productoCodigo: producto.barcode,
          productoNombre: producto.name,
          precioUnitario: producto.price,
          cantidadVendida: 1,
          subTotal: producto.price,
        ),
      );
    } else {
      final item = items[index];
      final nuevaCantidad = item.cantidadVendida + 1;
      if (nuevaCantidad > producto.stock) {
        throw Exception(
          'Stock insuficiente de ${producto.name} (disponible: ${producto.stock})',
        );
      }
      items[index] = item.copyWith(
        cantidadVendida: nuevaCantidad,
        subTotal: item.precioUnitario * nuevaCantidad,
      );
    }

    state = state.copyWith(items: items);
  }

  Future<void> cambiarCantidad(String codigo, int cantidad) async {
    if (cantidad < 1) return;

    final items = List<Facturacion>.from(state.items);
    final index = items.indexWhere((item) => item.productoCodigo == codigo);
    if (index == -1) return;

    final item = items[index];
    final producto = await localRepositoryProivder.getProductByBarcode(codigo);
    if (producto != null && cantidad > producto.stock) {
      throw Exception(
        'Stock insuficiente de ${producto.name} (disponible: ${producto.stock})',
      );
    }

    items[index] = item.copyWith(
      cantidadVendida: cantidad,
      subTotal: item.precioUnitario * cantidad,
    );
    state = state.copyWith(items: items);
  }

  void eliminarItem(String codigo) {
    state = state.copyWith(
      items: state.items
          .where((item) => item.productoCodigo != codigo)
          .toList(),
    );
  }

  Future<Venta> finalizarVenta({required double montoRecibido}) async {
    if (state.items.isEmpty) {
      throw Exception('No hay productos en la venta');
    }
    if (state.metodoPago == null) {
      throw Exception('Seleccione un método de pago');
    }
    if (state.tasaDolar <= 0) {
      throw Exception('Ingrese la tasa del dólar');
    }

    final venta = Venta(
      id: const Uuid().v4(),
      metodoPago: state.metodoPago!,
      montoTotalDolar: state.totalDolar,
      montoTotalBs: montoRecibido,
      tasaDolarUsada: state.tasaDolar,
      date: DateTime.now(),
    );

    await localRepositoryProivder.registrarVenta(
      venta: venta,
      detalle: state.items,
    );

    state = const FacturacionState();
    return venta;
  }
}
