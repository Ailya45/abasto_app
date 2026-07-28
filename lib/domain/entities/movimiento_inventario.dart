class MovimientoInventario {
  final String productoCodigo;
  final String nombreProducto;
  final int stockAnterior;
  final int stockNuevo;
  final DateTime fecha;
  final String tipoMovimiento;
  final String motivo;

  MovimientoInventario({
    required this.productoCodigo,
    required this.nombreProducto,
    required this.stockAnterior,
    required this.stockNuevo,
    required this.fecha,
    required this.tipoMovimiento,
    required this.motivo,
  });

  MovimientoInventario copyWith({
    String? productoCodigo,
    String? nombreProducto,
    int? stockAnterior,
    int? stockNuevo,
    DateTime? fecha,
    String? tipoMovimiento,
    String? motivo,
  }) =>
      MovimientoInventario(
        productoCodigo: productoCodigo ?? this.productoCodigo,
        nombreProducto: nombreProducto ?? this.nombreProducto,
        stockAnterior: stockAnterior ?? this.stockAnterior,
        stockNuevo: stockNuevo ?? this.stockNuevo,
        fecha: fecha ?? this.fecha,
        tipoMovimiento: tipoMovimiento ?? this.tipoMovimiento,
        motivo: motivo ?? this.motivo,
      );
}