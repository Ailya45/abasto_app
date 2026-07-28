import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'local_database.g.dart';

// ─────────────────────────────────────────────
// TABLAS
// ─────────────────────────────────────────────

class Productos extends Table {
  TextColumn get codigoBarras => text().withLength(min: 1, max: 50)();
  TextColumn get nombre => text().withLength(min: 1, max: 150)();
  TextColumn get categoria => text().nullable()();
  RealColumn get precioUnitarioDolar => real()();
  IntColumn get cantidadStock => integer()();

  @override
  Set<Column> get primaryKey => {codigoBarras};
}

class Ventas extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  DateTimeColumn get fecha => dateTime().withDefault(currentDateAndTime)();
  RealColumn get tasaDolarUsada => real()();
  RealColumn get montoTotalDolar => real()();
  TextColumn get metodoPago => text()(); // Ej: 'Efectivo', 'Biopago'
  RealColumn get montoTotalBs =>
      real()(); // Lo que pagó el cliente (puede ser mayor al total)

  @override
  Set<Column> get primaryKey => {id};
}

class DetalleVentas extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  TextColumn get ventaId =>
      text().withLength(min: 36, max: 36).references(Ventas, #id)();
  TextColumn get productoCodigo =>
      text().references(Productos, #codigoBarras)();
  RealColumn get precioUnitario => real()(); // Precio al momento de la venta
  RealColumn get cantidadVendida => real()();
  RealColumn get subTotal => real()(); // precioUnitario * cantidadVendida

  @override
  Set<Column> get primaryKey => {id};
}

class MovimientosInventario extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productoCodigo =>
      text().references(Productos, #codigoBarras)();
  TextColumn get nombreProducto => text()();
  TextColumn get tipoMovimiento =>
      text()(); // 'ENTRADA' (Compra/Ajuste), 'SALIDA' (Venta/Merma)
  IntColumn get stockAnterior => integer()();
  IntColumn get stockNuevo => integer()();
  DateTimeColumn get fecha => dateTime().withDefault(currentDateAndTime)();
  TextColumn get motivo =>
      text().nullable()(); // Ej: 'Venta Factura #12', 'Carga inicial'
}

/// Tabla de configuración general de la app (clave-valor).
/// Claves esperadas:
///   'tasa_dolar_bcv'  → tasa oficial BCV (String con número decimal)
///   'nombre_negocio'  → nombre del abasto
class Configuracion extends Table {
  TextColumn get clave => text()(); // PK — identificador único del setting
  TextColumn get valor => text()(); // Valor como String (parsear según clave)
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {clave};
}

// ─────────────────────────────────────────────
// BASE DE DATOS
// ─────────────────────────────────────────────

@DriftDatabase(
  tables: [
    Productos,
    Ventas,
    DetalleVentas,
    MovimientosInventario,
    Configuracion,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'abasto_database',
      native: DriftNativeOptions(
        // Cambiamos la función por defecto por nuestra lógica personalizada
        databaseDirectory: () async {
          // 1. Obtiene la ruta a "Documentos" del usuario
          final docsDir = await getApplicationDocumentsDirectory();

          // 2. Construye la ruta para la subcarpeta "db"
          final dbFolder = Directory(p.join(docsDir.path, 'db'));

          // 3. Crea la carpeta si aún no existe en la PC
          if (!await dbFolder.exists()) {
            await dbFolder.create(recursive: true);
          }

          // 4. Retorna el directorio donde driftDatabase creará 'abasto_database.sqlite'
          return dbFolder;
        },
    ),
    );
  }
}

final db = AppDatabase();