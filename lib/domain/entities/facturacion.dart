class Facturacion {
  final String productoCodigo;
  final String productoNombre;
  final double precioUnitario;
  final int cantidadVendida;
  final double subTotal;

  /// Stock disponible del producto al momento de agregarlo a la venta.
  /// Null en detalles históricos (no aplica validación de stock).
  final int? stockDisponible;

  Facturacion({
    required this.productoCodigo,
    required this.precioUnitario,
    required this.cantidadVendida,
    required this.subTotal,
    required this.productoNombre,
    this.stockDisponible,
  });

  Facturacion copyWith({
    String? ventaId,
    String? productoCodigo,
    String? productoNombre,
    double? precioUnitario,
    int? cantidadVendida,
    double? subTotal,
    int? stockDisponible,
  }) {
    return Facturacion(
      productoCodigo: productoCodigo ?? this.productoCodigo,
      precioUnitario: precioUnitario ?? this.precioUnitario,
      cantidadVendida: cantidadVendida ?? this.cantidadVendida,
      subTotal: subTotal ?? this.subTotal,
      productoNombre: productoNombre ?? this.productoNombre,
      stockDisponible: stockDisponible ?? this.stockDisponible,
    );
  }
}


