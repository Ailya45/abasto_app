class Facturacion {
  final String productoCodigo;
  final String productoNombre;
  final double precioUnitario;
  final int cantidadVendida;
  final double subTotal;

  Facturacion({
    required this.productoCodigo,
    required this.precioUnitario,
    required this.cantidadVendida,
    required this.subTotal,
    required this.productoNombre,
  });

  Facturacion copyWith({
  String? ventaId,
  String? productoCodigo,
  String? productoNombre,
  double? precioUnitario,
  int? cantidadVendida,
  double? subTotal,
}) {
  return Facturacion(
    productoCodigo: productoCodigo ?? this.productoCodigo,
    precioUnitario: precioUnitario ?? this.precioUnitario,
    cantidadVendida: cantidadVendida ?? this.cantidadVendida,
    subTotal: subTotal ?? this.subTotal,
    productoNombre: productoNombre ?? this.productoNombre,
  );
}
}


