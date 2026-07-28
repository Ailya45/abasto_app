import 'package:intl/intl.dart';

String formatearFechaHora(DateTime fecha) {
  return DateFormat('dd/MM/yyyy hh:mm a').format(fecha);
}