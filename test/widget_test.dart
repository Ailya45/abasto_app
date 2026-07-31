import 'dart:async';

import 'package:abasto_app/domain/entities/facturacion.dart';
import 'package:abasto_app/domain/entities/movimiento_inventario.dart';
import 'package:abasto_app/domain/entities/product.dart';
import 'package:abasto_app/domain/entities/venta.dart';
import 'package:abasto_app/domain/repository/local_storage_repository.dart';
import 'package:abasto_app/presentation/providers/facturacion/facturacion_provider.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeRepository extends LocalStorageRepository {
  final Map<String, Product> productos = {};
  final Map<String, String> config = {};
  Venta? ventaGuardada;
  List<Facturacion> detalleGuardado = [];

  @override
  Future<void> addProduct(Product product) async {
    productos[product.barcode] = product;
  }

  @override
  Future<void> updateProduct(Product product) async {
    productos[product.barcode] = product;
  }

  @override
  Future<void> deleteProduct(Product product) async {
    productos.remove(product.barcode);
  }

  @override
  Future<bool> isProductSaved(String barcode) async =>
      productos.containsKey(barcode);

  @override
  Stream<List<Product>> watchAllProducts() async* {
    yield productos.values.toList();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    return productos.values
        .where((p) => p.category == category)
        .toList();
  }

  @override
  Stream<List<Product>> watchProductsByFilter(String name) async* {
    yield productos.values
        .where((p) => p.name.contains(name))
        .toList();
  }

  @override
  Stream<Product?> watchProductByBarcode(String barcode) async* {
    yield productos[barcode];
  }

  @override
  Stream<List<MovimientoInventario>> watchInventarioMovimientos() async* {
    yield [];
  }

  @override
  Future<void> ajusteStock(
    Product product, {
    required int stockAnterior,
    required String tipoMovimiento,
    required String motivo,
  }) async {}

  @override
  Future<Product?> getProductByBarcode(String barcode) async =>
      productos[barcode];

  @override
  Future<void> registrarVenta({
    required Venta venta,
    required List<Facturacion> detalle,
  }) async {
    ventaGuardada = venta;
    detalleGuardado = detalle;
  }

  @override
  Future<List<Facturacion>> getDetalleVenta(String ventaId) async => [];

  @override
  Stream<List<Venta>> watchAllVentas() async* {
    yield [];
  }

  @override
  Future<String?> getConfigValue(String clave) async => config[clave];

  @override
  Future<void> setConfigValue(String clave, String valor) async {
    config[clave] = valor;
  }
}

void main() {
  late _FakeRepository repository;
  late FacturacionProvider provider;

  setUp(() {
    repository = _FakeRepository();
    repository.productos['111'] = Product(
      barcode: '111',
      name: 'Harina',
      price: 10,
      stock: 5,
    );
    repository.productos['222'] = Product(
      barcode: '222',
      name: 'Azucar',
      price: 2,
      stock: 2,
    );
    provider = FacturacionProvider(
      localRepositoryProivder: repository,
    );
  });

  group('FacturacionState', () {
    test('calcula totales con IVA', () {
      final state = FacturacionState(
        items: [
          Facturacion(
            productoCodigo: '111',
            productoNombre: 'Harina',
            precioUnitario: 10,
            cantidadVendida: 2,
            subTotal: 20,
          ),
        ],
        tasaDolar: 100,
      );

      expect(state.totalDolar, 20);
      expect(state.totalBs, 2000);
      expect(state.iva, 320);
      expect(state.totalBsIva, 2320);
    });
  });

  group('FacturacionProvider', () {
    test('agrega un producto nuevo por codigo', () async {
      await provider.buscarYAgregar('111');

      expect(provider.state.items, hasLength(1));
      expect(provider.state.items.first.productoNombre, 'Harina');
      expect(provider.state.items.first.cantidadVendida, 1);
      expect(provider.state.items.first.subTotal, 10);
    });

    test('busca tambien por nombre exacto', () async {
      await provider.buscarYAgregar('azucar');

      expect(provider.state.items, hasLength(1));
      expect(provider.state.items.first.productoCodigo, '222');
    });

    test('incrementa cantidad si el producto ya esta', () async {
      await provider.buscarYAgregar('111');
      await provider.buscarYAgregar('111');

      expect(provider.state.items, hasLength(1));
      expect(provider.state.items.first.cantidadVendida, 2);
      expect(provider.state.items.first.subTotal, 20);
    });

    test('lanza error si el producto no existe', () async {
      expect(() => provider.buscarYAgregar('999'), throwsException);
    });

    test('lanza error si no hay stock', () async {
      repository.productos['333'] = Product(
        barcode: '333',
        name: 'Sin stock',
        price: 1,
        stock: 0,
      );
      for (var i = 0; i < 5; i++) {
        await provider.buscarYAgregar('111');
      }

      await expectLater(
        provider.buscarYAgregar('111'),
        throwsException,
      );
    });

    test('cambiarCantidad actualiza el subtotal', () async {
      await provider.buscarYAgregar('111');
      await provider.cambiarCantidad('111', 3);

      expect(provider.state.items.first.cantidadVendida, 3);
      expect(provider.state.items.first.subTotal, 30);
    });

    test('cambiarCantidad respeta el stock', () async {
      await provider.buscarYAgregar('222');

      expect(
        () => provider.cambiarCantidad('222', 3),
        throwsException,
      );
    });

    test('eliminarItem quita el producto', () async {
      await provider.buscarYAgregar('111');
      await provider.buscarYAgregar('222');
      provider.eliminarItem('111');

      expect(provider.state.items, hasLength(1));
      expect(provider.state.items.first.productoCodigo, '222');
    });

    test('setTasaDolar persiste en la configuracion', () async {
      provider.setTasaDolar(120);

      expect(provider.state.tasaDolar, 120);
      expect(repository.config['tasa_dolar_bcv'], '120.0');
    });

    test('finalizarVenta guarda y limpia el estado', () async {
      provider.setTasaDolar(100);
      provider.setMetodoPago('Efectivo');
      await provider.buscarYAgregar('111');
      await provider.buscarYAgregar('111');

      final venta = await provider.finalizarVenta(montoRecibido: 3000);

      expect(venta.metodoPago, 'Efectivo');
      expect(venta.montoTotalDolar, 20);
      expect(venta.tasaDolarUsada, 100);
      expect(venta.montoTotalBs, 3000);
      expect(repository.ventaGuardada, isNotNull);
      expect(repository.detalleGuardado, hasLength(1));
      expect(provider.state.items, isEmpty);
      expect(provider.state.metodoPago, isNull);
    });

    test('finalizarVenta valida que haya productos', () async {
      expect(
        () => provider.finalizarVenta(montoRecibido: 100),
        throwsException,
      );
    });

    test('finalizarVenta valida el metodo de pago', () async {
      provider.setTasaDolar(100);
      await provider.buscarYAgregar('111');

      expect(
        () => provider.finalizarVenta(montoRecibido: 100),
        throwsException,
      );
    });

    test('finalizarVenta valida la tasa del dolar', () async {
      provider.setMetodoPago('Efectivo');
      await provider.buscarYAgregar('111');

      expect(
        () => provider.finalizarVenta(montoRecibido: 100),
        throwsException,
      );
    });

    test('cargarTasaInicial lee la tasa guardada', () async {
      repository.config['tasa_dolar_bcv'] = '95.5';

      final tasa = await provider.cargarTasaInicial();

      expect(tasa, 95.5);
      expect(provider.state.tasaDolar, 95.5);
    });
  });
}
