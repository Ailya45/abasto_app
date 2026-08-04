import 'package:abasto_app/config/database/local_database.dart';
import 'package:abasto_app/domain/entities/venta.dart' as dominio;

dominio.Venta toVenta(Venta row) => dominio.Venta(
  id: row.id,
  metodoPago: row.metodoPago,
  montoTotalDolar: row.montoTotalDolar,
  montoTotalBs: row.montoTotalBs,
  tasaDolarUsada: row.tasaDolarUsada,
  date: row.fecha,
);
