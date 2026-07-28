// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $ProductosTable extends Productos
    with TableInfo<$ProductosTable, Producto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codigoBarrasMeta = const VerificationMeta(
    'codigoBarras',
  );
  @override
  late final GeneratedColumn<String> codigoBarras = GeneratedColumn<String>(
    'codigo_barras',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 150,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoriaMeta = const VerificationMeta(
    'categoria',
  );
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
    'categoria',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _precioUnitarioDolarMeta =
      const VerificationMeta('precioUnitarioDolar');
  @override
  late final GeneratedColumn<double> precioUnitarioDolar =
      GeneratedColumn<double>(
        'precio_unitario_dolar',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _cantidadStockMeta = const VerificationMeta(
    'cantidadStock',
  );
  @override
  late final GeneratedColumn<int> cantidadStock = GeneratedColumn<int>(
    'cantidad_stock',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    codigoBarras,
    nombre,
    categoria,
    precioUnitarioDolar,
    cantidadStock,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'productos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Producto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('codigo_barras')) {
      context.handle(
        _codigoBarrasMeta,
        codigoBarras.isAcceptableOrUnknown(
          data['codigo_barras']!,
          _codigoBarrasMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_codigoBarrasMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('categoria')) {
      context.handle(
        _categoriaMeta,
        categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta),
      );
    }
    if (data.containsKey('precio_unitario_dolar')) {
      context.handle(
        _precioUnitarioDolarMeta,
        precioUnitarioDolar.isAcceptableOrUnknown(
          data['precio_unitario_dolar']!,
          _precioUnitarioDolarMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioUnitarioDolarMeta);
    }
    if (data.containsKey('cantidad_stock')) {
      context.handle(
        _cantidadStockMeta,
        cantidadStock.isAcceptableOrUnknown(
          data['cantidad_stock']!,
          _cantidadStockMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cantidadStockMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codigoBarras};
  @override
  Producto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Producto(
      codigoBarras: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codigo_barras'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      categoria: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categoria'],
      ),
      precioUnitarioDolar: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio_unitario_dolar'],
      )!,
      cantidadStock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cantidad_stock'],
      )!,
    );
  }

  @override
  $ProductosTable createAlias(String alias) {
    return $ProductosTable(attachedDatabase, alias);
  }
}

class Producto extends DataClass implements Insertable<Producto> {
  final String codigoBarras;
  final String nombre;
  final String? categoria;
  final double precioUnitarioDolar;
  final int cantidadStock;
  const Producto({
    required this.codigoBarras,
    required this.nombre,
    this.categoria,
    required this.precioUnitarioDolar,
    required this.cantidadStock,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['codigo_barras'] = Variable<String>(codigoBarras);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || categoria != null) {
      map['categoria'] = Variable<String>(categoria);
    }
    map['precio_unitario_dolar'] = Variable<double>(precioUnitarioDolar);
    map['cantidad_stock'] = Variable<int>(cantidadStock);
    return map;
  }

  ProductosCompanion toCompanion(bool nullToAbsent) {
    return ProductosCompanion(
      codigoBarras: Value(codigoBarras),
      nombre: Value(nombre),
      categoria: categoria == null && nullToAbsent
          ? const Value.absent()
          : Value(categoria),
      precioUnitarioDolar: Value(precioUnitarioDolar),
      cantidadStock: Value(cantidadStock),
    );
  }

  factory Producto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Producto(
      codigoBarras: serializer.fromJson<String>(json['codigoBarras']),
      nombre: serializer.fromJson<String>(json['nombre']),
      categoria: serializer.fromJson<String?>(json['categoria']),
      precioUnitarioDolar: serializer.fromJson<double>(
        json['precioUnitarioDolar'],
      ),
      cantidadStock: serializer.fromJson<int>(json['cantidadStock']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigoBarras': serializer.toJson<String>(codigoBarras),
      'nombre': serializer.toJson<String>(nombre),
      'categoria': serializer.toJson<String?>(categoria),
      'precioUnitarioDolar': serializer.toJson<double>(precioUnitarioDolar),
      'cantidadStock': serializer.toJson<int>(cantidadStock),
    };
  }

  Producto copyWith({
    String? codigoBarras,
    String? nombre,
    Value<String?> categoria = const Value.absent(),
    double? precioUnitarioDolar,
    int? cantidadStock,
  }) => Producto(
    codigoBarras: codigoBarras ?? this.codigoBarras,
    nombre: nombre ?? this.nombre,
    categoria: categoria.present ? categoria.value : this.categoria,
    precioUnitarioDolar: precioUnitarioDolar ?? this.precioUnitarioDolar,
    cantidadStock: cantidadStock ?? this.cantidadStock,
  );
  Producto copyWithCompanion(ProductosCompanion data) {
    return Producto(
      codigoBarras: data.codigoBarras.present
          ? data.codigoBarras.value
          : this.codigoBarras,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      precioUnitarioDolar: data.precioUnitarioDolar.present
          ? data.precioUnitarioDolar.value
          : this.precioUnitarioDolar,
      cantidadStock: data.cantidadStock.present
          ? data.cantidadStock.value
          : this.cantidadStock,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Producto(')
          ..write('codigoBarras: $codigoBarras, ')
          ..write('nombre: $nombre, ')
          ..write('categoria: $categoria, ')
          ..write('precioUnitarioDolar: $precioUnitarioDolar, ')
          ..write('cantidadStock: $cantidadStock')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    codigoBarras,
    nombre,
    categoria,
    precioUnitarioDolar,
    cantidadStock,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Producto &&
          other.codigoBarras == this.codigoBarras &&
          other.nombre == this.nombre &&
          other.categoria == this.categoria &&
          other.precioUnitarioDolar == this.precioUnitarioDolar &&
          other.cantidadStock == this.cantidadStock);
}

class ProductosCompanion extends UpdateCompanion<Producto> {
  final Value<String> codigoBarras;
  final Value<String> nombre;
  final Value<String?> categoria;
  final Value<double> precioUnitarioDolar;
  final Value<int> cantidadStock;
  final Value<int> rowid;
  const ProductosCompanion({
    this.codigoBarras = const Value.absent(),
    this.nombre = const Value.absent(),
    this.categoria = const Value.absent(),
    this.precioUnitarioDolar = const Value.absent(),
    this.cantidadStock = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductosCompanion.insert({
    required String codigoBarras,
    required String nombre,
    this.categoria = const Value.absent(),
    required double precioUnitarioDolar,
    required int cantidadStock,
    this.rowid = const Value.absent(),
  }) : codigoBarras = Value(codigoBarras),
       nombre = Value(nombre),
       precioUnitarioDolar = Value(precioUnitarioDolar),
       cantidadStock = Value(cantidadStock);
  static Insertable<Producto> custom({
    Expression<String>? codigoBarras,
    Expression<String>? nombre,
    Expression<String>? categoria,
    Expression<double>? precioUnitarioDolar,
    Expression<int>? cantidadStock,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (codigoBarras != null) 'codigo_barras': codigoBarras,
      if (nombre != null) 'nombre': nombre,
      if (categoria != null) 'categoria': categoria,
      if (precioUnitarioDolar != null)
        'precio_unitario_dolar': precioUnitarioDolar,
      if (cantidadStock != null) 'cantidad_stock': cantidadStock,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductosCompanion copyWith({
    Value<String>? codigoBarras,
    Value<String>? nombre,
    Value<String?>? categoria,
    Value<double>? precioUnitarioDolar,
    Value<int>? cantidadStock,
    Value<int>? rowid,
  }) {
    return ProductosCompanion(
      codigoBarras: codigoBarras ?? this.codigoBarras,
      nombre: nombre ?? this.nombre,
      categoria: categoria ?? this.categoria,
      precioUnitarioDolar: precioUnitarioDolar ?? this.precioUnitarioDolar,
      cantidadStock: cantidadStock ?? this.cantidadStock,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigoBarras.present) {
      map['codigo_barras'] = Variable<String>(codigoBarras.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (precioUnitarioDolar.present) {
      map['precio_unitario_dolar'] = Variable<double>(
        precioUnitarioDolar.value,
      );
    }
    if (cantidadStock.present) {
      map['cantidad_stock'] = Variable<int>(cantidadStock.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductosCompanion(')
          ..write('codigoBarras: $codigoBarras, ')
          ..write('nombre: $nombre, ')
          ..write('categoria: $categoria, ')
          ..write('precioUnitarioDolar: $precioUnitarioDolar, ')
          ..write('cantidadStock: $cantidadStock, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VentasTable extends Ventas with TableInfo<$VentasTable, Venta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VentasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _tasaDolarUsadaMeta = const VerificationMeta(
    'tasaDolarUsada',
  );
  @override
  late final GeneratedColumn<double> tasaDolarUsada = GeneratedColumn<double>(
    'tasa_dolar_usada',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _montoTotalDolarMeta = const VerificationMeta(
    'montoTotalDolar',
  );
  @override
  late final GeneratedColumn<double> montoTotalDolar = GeneratedColumn<double>(
    'monto_total_dolar',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metodoPagoMeta = const VerificationMeta(
    'metodoPago',
  );
  @override
  late final GeneratedColumn<String> metodoPago = GeneratedColumn<String>(
    'metodo_pago',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _montoTotalBsMeta = const VerificationMeta(
    'montoTotalBs',
  );
  @override
  late final GeneratedColumn<double> montoTotalBs = GeneratedColumn<double>(
    'monto_total_bs',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fecha,
    tasaDolarUsada,
    montoTotalDolar,
    metodoPago,
    montoTotalBs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ventas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Venta> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    }
    if (data.containsKey('tasa_dolar_usada')) {
      context.handle(
        _tasaDolarUsadaMeta,
        tasaDolarUsada.isAcceptableOrUnknown(
          data['tasa_dolar_usada']!,
          _tasaDolarUsadaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tasaDolarUsadaMeta);
    }
    if (data.containsKey('monto_total_dolar')) {
      context.handle(
        _montoTotalDolarMeta,
        montoTotalDolar.isAcceptableOrUnknown(
          data['monto_total_dolar']!,
          _montoTotalDolarMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_montoTotalDolarMeta);
    }
    if (data.containsKey('metodo_pago')) {
      context.handle(
        _metodoPagoMeta,
        metodoPago.isAcceptableOrUnknown(data['metodo_pago']!, _metodoPagoMeta),
      );
    } else if (isInserting) {
      context.missing(_metodoPagoMeta);
    }
    if (data.containsKey('monto_total_bs')) {
      context.handle(
        _montoTotalBsMeta,
        montoTotalBs.isAcceptableOrUnknown(
          data['monto_total_bs']!,
          _montoTotalBsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_montoTotalBsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Venta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Venta(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
      tasaDolarUsada: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tasa_dolar_usada'],
      )!,
      montoTotalDolar: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monto_total_dolar'],
      )!,
      metodoPago: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metodo_pago'],
      )!,
      montoTotalBs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monto_total_bs'],
      )!,
    );
  }

  @override
  $VentasTable createAlias(String alias) {
    return $VentasTable(attachedDatabase, alias);
  }
}

class Venta extends DataClass implements Insertable<Venta> {
  final String id;
  final DateTime fecha;
  final double tasaDolarUsada;
  final double montoTotalDolar;
  final String metodoPago;
  final double montoTotalBs;
  const Venta({
    required this.id,
    required this.fecha,
    required this.tasaDolarUsada,
    required this.montoTotalDolar,
    required this.metodoPago,
    required this.montoTotalBs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['fecha'] = Variable<DateTime>(fecha);
    map['tasa_dolar_usada'] = Variable<double>(tasaDolarUsada);
    map['monto_total_dolar'] = Variable<double>(montoTotalDolar);
    map['metodo_pago'] = Variable<String>(metodoPago);
    map['monto_total_bs'] = Variable<double>(montoTotalBs);
    return map;
  }

  VentasCompanion toCompanion(bool nullToAbsent) {
    return VentasCompanion(
      id: Value(id),
      fecha: Value(fecha),
      tasaDolarUsada: Value(tasaDolarUsada),
      montoTotalDolar: Value(montoTotalDolar),
      metodoPago: Value(metodoPago),
      montoTotalBs: Value(montoTotalBs),
    );
  }

  factory Venta.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Venta(
      id: serializer.fromJson<String>(json['id']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      tasaDolarUsada: serializer.fromJson<double>(json['tasaDolarUsada']),
      montoTotalDolar: serializer.fromJson<double>(json['montoTotalDolar']),
      metodoPago: serializer.fromJson<String>(json['metodoPago']),
      montoTotalBs: serializer.fromJson<double>(json['montoTotalBs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fecha': serializer.toJson<DateTime>(fecha),
      'tasaDolarUsada': serializer.toJson<double>(tasaDolarUsada),
      'montoTotalDolar': serializer.toJson<double>(montoTotalDolar),
      'metodoPago': serializer.toJson<String>(metodoPago),
      'montoTotalBs': serializer.toJson<double>(montoTotalBs),
    };
  }

  Venta copyWith({
    String? id,
    DateTime? fecha,
    double? tasaDolarUsada,
    double? montoTotalDolar,
    String? metodoPago,
    double? montoTotalBs,
  }) => Venta(
    id: id ?? this.id,
    fecha: fecha ?? this.fecha,
    tasaDolarUsada: tasaDolarUsada ?? this.tasaDolarUsada,
    montoTotalDolar: montoTotalDolar ?? this.montoTotalDolar,
    metodoPago: metodoPago ?? this.metodoPago,
    montoTotalBs: montoTotalBs ?? this.montoTotalBs,
  );
  Venta copyWithCompanion(VentasCompanion data) {
    return Venta(
      id: data.id.present ? data.id.value : this.id,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      tasaDolarUsada: data.tasaDolarUsada.present
          ? data.tasaDolarUsada.value
          : this.tasaDolarUsada,
      montoTotalDolar: data.montoTotalDolar.present
          ? data.montoTotalDolar.value
          : this.montoTotalDolar,
      metodoPago: data.metodoPago.present
          ? data.metodoPago.value
          : this.metodoPago,
      montoTotalBs: data.montoTotalBs.present
          ? data.montoTotalBs.value
          : this.montoTotalBs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Venta(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('tasaDolarUsada: $tasaDolarUsada, ')
          ..write('montoTotalDolar: $montoTotalDolar, ')
          ..write('metodoPago: $metodoPago, ')
          ..write('montoTotalBs: $montoTotalBs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fecha,
    tasaDolarUsada,
    montoTotalDolar,
    metodoPago,
    montoTotalBs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Venta &&
          other.id == this.id &&
          other.fecha == this.fecha &&
          other.tasaDolarUsada == this.tasaDolarUsada &&
          other.montoTotalDolar == this.montoTotalDolar &&
          other.metodoPago == this.metodoPago &&
          other.montoTotalBs == this.montoTotalBs);
}

class VentasCompanion extends UpdateCompanion<Venta> {
  final Value<String> id;
  final Value<DateTime> fecha;
  final Value<double> tasaDolarUsada;
  final Value<double> montoTotalDolar;
  final Value<String> metodoPago;
  final Value<double> montoTotalBs;
  final Value<int> rowid;
  const VentasCompanion({
    this.id = const Value.absent(),
    this.fecha = const Value.absent(),
    this.tasaDolarUsada = const Value.absent(),
    this.montoTotalDolar = const Value.absent(),
    this.metodoPago = const Value.absent(),
    this.montoTotalBs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VentasCompanion.insert({
    required String id,
    this.fecha = const Value.absent(),
    required double tasaDolarUsada,
    required double montoTotalDolar,
    required String metodoPago,
    required double montoTotalBs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tasaDolarUsada = Value(tasaDolarUsada),
       montoTotalDolar = Value(montoTotalDolar),
       metodoPago = Value(metodoPago),
       montoTotalBs = Value(montoTotalBs);
  static Insertable<Venta> custom({
    Expression<String>? id,
    Expression<DateTime>? fecha,
    Expression<double>? tasaDolarUsada,
    Expression<double>? montoTotalDolar,
    Expression<String>? metodoPago,
    Expression<double>? montoTotalBs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fecha != null) 'fecha': fecha,
      if (tasaDolarUsada != null) 'tasa_dolar_usada': tasaDolarUsada,
      if (montoTotalDolar != null) 'monto_total_dolar': montoTotalDolar,
      if (metodoPago != null) 'metodo_pago': metodoPago,
      if (montoTotalBs != null) 'monto_total_bs': montoTotalBs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VentasCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? fecha,
    Value<double>? tasaDolarUsada,
    Value<double>? montoTotalDolar,
    Value<String>? metodoPago,
    Value<double>? montoTotalBs,
    Value<int>? rowid,
  }) {
    return VentasCompanion(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      tasaDolarUsada: tasaDolarUsada ?? this.tasaDolarUsada,
      montoTotalDolar: montoTotalDolar ?? this.montoTotalDolar,
      metodoPago: metodoPago ?? this.metodoPago,
      montoTotalBs: montoTotalBs ?? this.montoTotalBs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (tasaDolarUsada.present) {
      map['tasa_dolar_usada'] = Variable<double>(tasaDolarUsada.value);
    }
    if (montoTotalDolar.present) {
      map['monto_total_dolar'] = Variable<double>(montoTotalDolar.value);
    }
    if (metodoPago.present) {
      map['metodo_pago'] = Variable<String>(metodoPago.value);
    }
    if (montoTotalBs.present) {
      map['monto_total_bs'] = Variable<double>(montoTotalBs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VentasCompanion(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('tasaDolarUsada: $tasaDolarUsada, ')
          ..write('montoTotalDolar: $montoTotalDolar, ')
          ..write('metodoPago: $metodoPago, ')
          ..write('montoTotalBs: $montoTotalBs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DetalleVentasTable extends DetalleVentas
    with TableInfo<$DetalleVentasTable, DetalleVenta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DetalleVentasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ventaIdMeta = const VerificationMeta(
    'ventaId',
  );
  @override
  late final GeneratedColumn<String> ventaId = GeneratedColumn<String>(
    'venta_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ventas (id)',
    ),
  );
  static const VerificationMeta _productoCodigoMeta = const VerificationMeta(
    'productoCodigo',
  );
  @override
  late final GeneratedColumn<String> productoCodigo = GeneratedColumn<String>(
    'producto_codigo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES productos (codigo_barras)',
    ),
  );
  static const VerificationMeta _precioUnitarioMeta = const VerificationMeta(
    'precioUnitario',
  );
  @override
  late final GeneratedColumn<double> precioUnitario = GeneratedColumn<double>(
    'precio_unitario',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cantidadVendidaMeta = const VerificationMeta(
    'cantidadVendida',
  );
  @override
  late final GeneratedColumn<double> cantidadVendida = GeneratedColumn<double>(
    'cantidad_vendida',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subTotalMeta = const VerificationMeta(
    'subTotal',
  );
  @override
  late final GeneratedColumn<double> subTotal = GeneratedColumn<double>(
    'sub_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ventaId,
    productoCodigo,
    precioUnitario,
    cantidadVendida,
    subTotal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'detalle_ventas';
  @override
  VerificationContext validateIntegrity(
    Insertable<DetalleVenta> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('venta_id')) {
      context.handle(
        _ventaIdMeta,
        ventaId.isAcceptableOrUnknown(data['venta_id']!, _ventaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ventaIdMeta);
    }
    if (data.containsKey('producto_codigo')) {
      context.handle(
        _productoCodigoMeta,
        productoCodigo.isAcceptableOrUnknown(
          data['producto_codigo']!,
          _productoCodigoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productoCodigoMeta);
    }
    if (data.containsKey('precio_unitario')) {
      context.handle(
        _precioUnitarioMeta,
        precioUnitario.isAcceptableOrUnknown(
          data['precio_unitario']!,
          _precioUnitarioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioUnitarioMeta);
    }
    if (data.containsKey('cantidad_vendida')) {
      context.handle(
        _cantidadVendidaMeta,
        cantidadVendida.isAcceptableOrUnknown(
          data['cantidad_vendida']!,
          _cantidadVendidaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cantidadVendidaMeta);
    }
    if (data.containsKey('sub_total')) {
      context.handle(
        _subTotalMeta,
        subTotal.isAcceptableOrUnknown(data['sub_total']!, _subTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subTotalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DetalleVenta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DetalleVenta(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ventaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venta_id'],
      )!,
      productoCodigo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}producto_codigo'],
      )!,
      precioUnitario: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio_unitario'],
      )!,
      cantidadVendida: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cantidad_vendida'],
      )!,
      subTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sub_total'],
      )!,
    );
  }

  @override
  $DetalleVentasTable createAlias(String alias) {
    return $DetalleVentasTable(attachedDatabase, alias);
  }
}

class DetalleVenta extends DataClass implements Insertable<DetalleVenta> {
  final String id;
  final String ventaId;
  final String productoCodigo;
  final double precioUnitario;
  final double cantidadVendida;
  final double subTotal;
  const DetalleVenta({
    required this.id,
    required this.ventaId,
    required this.productoCodigo,
    required this.precioUnitario,
    required this.cantidadVendida,
    required this.subTotal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['venta_id'] = Variable<String>(ventaId);
    map['producto_codigo'] = Variable<String>(productoCodigo);
    map['precio_unitario'] = Variable<double>(precioUnitario);
    map['cantidad_vendida'] = Variable<double>(cantidadVendida);
    map['sub_total'] = Variable<double>(subTotal);
    return map;
  }

  DetalleVentasCompanion toCompanion(bool nullToAbsent) {
    return DetalleVentasCompanion(
      id: Value(id),
      ventaId: Value(ventaId),
      productoCodigo: Value(productoCodigo),
      precioUnitario: Value(precioUnitario),
      cantidadVendida: Value(cantidadVendida),
      subTotal: Value(subTotal),
    );
  }

  factory DetalleVenta.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DetalleVenta(
      id: serializer.fromJson<String>(json['id']),
      ventaId: serializer.fromJson<String>(json['ventaId']),
      productoCodigo: serializer.fromJson<String>(json['productoCodigo']),
      precioUnitario: serializer.fromJson<double>(json['precioUnitario']),
      cantidadVendida: serializer.fromJson<double>(json['cantidadVendida']),
      subTotal: serializer.fromJson<double>(json['subTotal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ventaId': serializer.toJson<String>(ventaId),
      'productoCodigo': serializer.toJson<String>(productoCodigo),
      'precioUnitario': serializer.toJson<double>(precioUnitario),
      'cantidadVendida': serializer.toJson<double>(cantidadVendida),
      'subTotal': serializer.toJson<double>(subTotal),
    };
  }

  DetalleVenta copyWith({
    String? id,
    String? ventaId,
    String? productoCodigo,
    double? precioUnitario,
    double? cantidadVendida,
    double? subTotal,
  }) => DetalleVenta(
    id: id ?? this.id,
    ventaId: ventaId ?? this.ventaId,
    productoCodigo: productoCodigo ?? this.productoCodigo,
    precioUnitario: precioUnitario ?? this.precioUnitario,
    cantidadVendida: cantidadVendida ?? this.cantidadVendida,
    subTotal: subTotal ?? this.subTotal,
  );
  DetalleVenta copyWithCompanion(DetalleVentasCompanion data) {
    return DetalleVenta(
      id: data.id.present ? data.id.value : this.id,
      ventaId: data.ventaId.present ? data.ventaId.value : this.ventaId,
      productoCodigo: data.productoCodigo.present
          ? data.productoCodigo.value
          : this.productoCodigo,
      precioUnitario: data.precioUnitario.present
          ? data.precioUnitario.value
          : this.precioUnitario,
      cantidadVendida: data.cantidadVendida.present
          ? data.cantidadVendida.value
          : this.cantidadVendida,
      subTotal: data.subTotal.present ? data.subTotal.value : this.subTotal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DetalleVenta(')
          ..write('id: $id, ')
          ..write('ventaId: $ventaId, ')
          ..write('productoCodigo: $productoCodigo, ')
          ..write('precioUnitario: $precioUnitario, ')
          ..write('cantidadVendida: $cantidadVendida, ')
          ..write('subTotal: $subTotal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ventaId,
    productoCodigo,
    precioUnitario,
    cantidadVendida,
    subTotal,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DetalleVenta &&
          other.id == this.id &&
          other.ventaId == this.ventaId &&
          other.productoCodigo == this.productoCodigo &&
          other.precioUnitario == this.precioUnitario &&
          other.cantidadVendida == this.cantidadVendida &&
          other.subTotal == this.subTotal);
}

class DetalleVentasCompanion extends UpdateCompanion<DetalleVenta> {
  final Value<String> id;
  final Value<String> ventaId;
  final Value<String> productoCodigo;
  final Value<double> precioUnitario;
  final Value<double> cantidadVendida;
  final Value<double> subTotal;
  final Value<int> rowid;
  const DetalleVentasCompanion({
    this.id = const Value.absent(),
    this.ventaId = const Value.absent(),
    this.productoCodigo = const Value.absent(),
    this.precioUnitario = const Value.absent(),
    this.cantidadVendida = const Value.absent(),
    this.subTotal = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DetalleVentasCompanion.insert({
    required String id,
    required String ventaId,
    required String productoCodigo,
    required double precioUnitario,
    required double cantidadVendida,
    required double subTotal,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ventaId = Value(ventaId),
       productoCodigo = Value(productoCodigo),
       precioUnitario = Value(precioUnitario),
       cantidadVendida = Value(cantidadVendida),
       subTotal = Value(subTotal);
  static Insertable<DetalleVenta> custom({
    Expression<String>? id,
    Expression<String>? ventaId,
    Expression<String>? productoCodigo,
    Expression<double>? precioUnitario,
    Expression<double>? cantidadVendida,
    Expression<double>? subTotal,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ventaId != null) 'venta_id': ventaId,
      if (productoCodigo != null) 'producto_codigo': productoCodigo,
      if (precioUnitario != null) 'precio_unitario': precioUnitario,
      if (cantidadVendida != null) 'cantidad_vendida': cantidadVendida,
      if (subTotal != null) 'sub_total': subTotal,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DetalleVentasCompanion copyWith({
    Value<String>? id,
    Value<String>? ventaId,
    Value<String>? productoCodigo,
    Value<double>? precioUnitario,
    Value<double>? cantidadVendida,
    Value<double>? subTotal,
    Value<int>? rowid,
  }) {
    return DetalleVentasCompanion(
      id: id ?? this.id,
      ventaId: ventaId ?? this.ventaId,
      productoCodigo: productoCodigo ?? this.productoCodigo,
      precioUnitario: precioUnitario ?? this.precioUnitario,
      cantidadVendida: cantidadVendida ?? this.cantidadVendida,
      subTotal: subTotal ?? this.subTotal,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ventaId.present) {
      map['venta_id'] = Variable<String>(ventaId.value);
    }
    if (productoCodigo.present) {
      map['producto_codigo'] = Variable<String>(productoCodigo.value);
    }
    if (precioUnitario.present) {
      map['precio_unitario'] = Variable<double>(precioUnitario.value);
    }
    if (cantidadVendida.present) {
      map['cantidad_vendida'] = Variable<double>(cantidadVendida.value);
    }
    if (subTotal.present) {
      map['sub_total'] = Variable<double>(subTotal.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DetalleVentasCompanion(')
          ..write('id: $id, ')
          ..write('ventaId: $ventaId, ')
          ..write('productoCodigo: $productoCodigo, ')
          ..write('precioUnitario: $precioUnitario, ')
          ..write('cantidadVendida: $cantidadVendida, ')
          ..write('subTotal: $subTotal, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MovimientosInventarioTable extends MovimientosInventario
    with TableInfo<$MovimientosInventarioTable, MovimientosInventarioData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovimientosInventarioTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productoCodigoMeta = const VerificationMeta(
    'productoCodigo',
  );
  @override
  late final GeneratedColumn<String> productoCodigo = GeneratedColumn<String>(
    'producto_codigo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES productos (codigo_barras)',
    ),
  );
  static const VerificationMeta _nombreProductoMeta = const VerificationMeta(
    'nombreProducto',
  );
  @override
  late final GeneratedColumn<String> nombreProducto = GeneratedColumn<String>(
    'nombre_producto',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMovimientoMeta = const VerificationMeta(
    'tipoMovimiento',
  );
  @override
  late final GeneratedColumn<String> tipoMovimiento = GeneratedColumn<String>(
    'tipo_movimiento',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockAnteriorMeta = const VerificationMeta(
    'stockAnterior',
  );
  @override
  late final GeneratedColumn<int> stockAnterior = GeneratedColumn<int>(
    'stock_anterior',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockNuevoMeta = const VerificationMeta(
    'stockNuevo',
  );
  @override
  late final GeneratedColumn<int> stockNuevo = GeneratedColumn<int>(
    'stock_nuevo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _motivoMeta = const VerificationMeta('motivo');
  @override
  late final GeneratedColumn<String> motivo = GeneratedColumn<String>(
    'motivo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productoCodigo,
    nombreProducto,
    tipoMovimiento,
    stockAnterior,
    stockNuevo,
    fecha,
    motivo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movimientos_inventario';
  @override
  VerificationContext validateIntegrity(
    Insertable<MovimientosInventarioData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('producto_codigo')) {
      context.handle(
        _productoCodigoMeta,
        productoCodigo.isAcceptableOrUnknown(
          data['producto_codigo']!,
          _productoCodigoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productoCodigoMeta);
    }
    if (data.containsKey('nombre_producto')) {
      context.handle(
        _nombreProductoMeta,
        nombreProducto.isAcceptableOrUnknown(
          data['nombre_producto']!,
          _nombreProductoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nombreProductoMeta);
    }
    if (data.containsKey('tipo_movimiento')) {
      context.handle(
        _tipoMovimientoMeta,
        tipoMovimiento.isAcceptableOrUnknown(
          data['tipo_movimiento']!,
          _tipoMovimientoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tipoMovimientoMeta);
    }
    if (data.containsKey('stock_anterior')) {
      context.handle(
        _stockAnteriorMeta,
        stockAnterior.isAcceptableOrUnknown(
          data['stock_anterior']!,
          _stockAnteriorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stockAnteriorMeta);
    }
    if (data.containsKey('stock_nuevo')) {
      context.handle(
        _stockNuevoMeta,
        stockNuevo.isAcceptableOrUnknown(data['stock_nuevo']!, _stockNuevoMeta),
      );
    } else if (isInserting) {
      context.missing(_stockNuevoMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    }
    if (data.containsKey('motivo')) {
      context.handle(
        _motivoMeta,
        motivo.isAcceptableOrUnknown(data['motivo']!, _motivoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovimientosInventarioData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovimientosInventarioData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productoCodigo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}producto_codigo'],
      )!,
      nombreProducto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre_producto'],
      )!,
      tipoMovimiento: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo_movimiento'],
      )!,
      stockAnterior: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_anterior'],
      )!,
      stockNuevo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_nuevo'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
      motivo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motivo'],
      ),
    );
  }

  @override
  $MovimientosInventarioTable createAlias(String alias) {
    return $MovimientosInventarioTable(attachedDatabase, alias);
  }
}

class MovimientosInventarioData extends DataClass
    implements Insertable<MovimientosInventarioData> {
  final int id;
  final String productoCodigo;
  final String nombreProducto;
  final String tipoMovimiento;
  final int stockAnterior;
  final int stockNuevo;
  final DateTime fecha;
  final String? motivo;
  const MovimientosInventarioData({
    required this.id,
    required this.productoCodigo,
    required this.nombreProducto,
    required this.tipoMovimiento,
    required this.stockAnterior,
    required this.stockNuevo,
    required this.fecha,
    this.motivo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['producto_codigo'] = Variable<String>(productoCodigo);
    map['nombre_producto'] = Variable<String>(nombreProducto);
    map['tipo_movimiento'] = Variable<String>(tipoMovimiento);
    map['stock_anterior'] = Variable<int>(stockAnterior);
    map['stock_nuevo'] = Variable<int>(stockNuevo);
    map['fecha'] = Variable<DateTime>(fecha);
    if (!nullToAbsent || motivo != null) {
      map['motivo'] = Variable<String>(motivo);
    }
    return map;
  }

  MovimientosInventarioCompanion toCompanion(bool nullToAbsent) {
    return MovimientosInventarioCompanion(
      id: Value(id),
      productoCodigo: Value(productoCodigo),
      nombreProducto: Value(nombreProducto),
      tipoMovimiento: Value(tipoMovimiento),
      stockAnterior: Value(stockAnterior),
      stockNuevo: Value(stockNuevo),
      fecha: Value(fecha),
      motivo: motivo == null && nullToAbsent
          ? const Value.absent()
          : Value(motivo),
    );
  }

  factory MovimientosInventarioData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovimientosInventarioData(
      id: serializer.fromJson<int>(json['id']),
      productoCodigo: serializer.fromJson<String>(json['productoCodigo']),
      nombreProducto: serializer.fromJson<String>(json['nombreProducto']),
      tipoMovimiento: serializer.fromJson<String>(json['tipoMovimiento']),
      stockAnterior: serializer.fromJson<int>(json['stockAnterior']),
      stockNuevo: serializer.fromJson<int>(json['stockNuevo']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      motivo: serializer.fromJson<String?>(json['motivo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productoCodigo': serializer.toJson<String>(productoCodigo),
      'nombreProducto': serializer.toJson<String>(nombreProducto),
      'tipoMovimiento': serializer.toJson<String>(tipoMovimiento),
      'stockAnterior': serializer.toJson<int>(stockAnterior),
      'stockNuevo': serializer.toJson<int>(stockNuevo),
      'fecha': serializer.toJson<DateTime>(fecha),
      'motivo': serializer.toJson<String?>(motivo),
    };
  }

  MovimientosInventarioData copyWith({
    int? id,
    String? productoCodigo,
    String? nombreProducto,
    String? tipoMovimiento,
    int? stockAnterior,
    int? stockNuevo,
    DateTime? fecha,
    Value<String?> motivo = const Value.absent(),
  }) => MovimientosInventarioData(
    id: id ?? this.id,
    productoCodigo: productoCodigo ?? this.productoCodigo,
    nombreProducto: nombreProducto ?? this.nombreProducto,
    tipoMovimiento: tipoMovimiento ?? this.tipoMovimiento,
    stockAnterior: stockAnterior ?? this.stockAnterior,
    stockNuevo: stockNuevo ?? this.stockNuevo,
    fecha: fecha ?? this.fecha,
    motivo: motivo.present ? motivo.value : this.motivo,
  );
  MovimientosInventarioData copyWithCompanion(
    MovimientosInventarioCompanion data,
  ) {
    return MovimientosInventarioData(
      id: data.id.present ? data.id.value : this.id,
      productoCodigo: data.productoCodigo.present
          ? data.productoCodigo.value
          : this.productoCodigo,
      nombreProducto: data.nombreProducto.present
          ? data.nombreProducto.value
          : this.nombreProducto,
      tipoMovimiento: data.tipoMovimiento.present
          ? data.tipoMovimiento.value
          : this.tipoMovimiento,
      stockAnterior: data.stockAnterior.present
          ? data.stockAnterior.value
          : this.stockAnterior,
      stockNuevo: data.stockNuevo.present
          ? data.stockNuevo.value
          : this.stockNuevo,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      motivo: data.motivo.present ? data.motivo.value : this.motivo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MovimientosInventarioData(')
          ..write('id: $id, ')
          ..write('productoCodigo: $productoCodigo, ')
          ..write('nombreProducto: $nombreProducto, ')
          ..write('tipoMovimiento: $tipoMovimiento, ')
          ..write('stockAnterior: $stockAnterior, ')
          ..write('stockNuevo: $stockNuevo, ')
          ..write('fecha: $fecha, ')
          ..write('motivo: $motivo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productoCodigo,
    nombreProducto,
    tipoMovimiento,
    stockAnterior,
    stockNuevo,
    fecha,
    motivo,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovimientosInventarioData &&
          other.id == this.id &&
          other.productoCodigo == this.productoCodigo &&
          other.nombreProducto == this.nombreProducto &&
          other.tipoMovimiento == this.tipoMovimiento &&
          other.stockAnterior == this.stockAnterior &&
          other.stockNuevo == this.stockNuevo &&
          other.fecha == this.fecha &&
          other.motivo == this.motivo);
}

class MovimientosInventarioCompanion
    extends UpdateCompanion<MovimientosInventarioData> {
  final Value<int> id;
  final Value<String> productoCodigo;
  final Value<String> nombreProducto;
  final Value<String> tipoMovimiento;
  final Value<int> stockAnterior;
  final Value<int> stockNuevo;
  final Value<DateTime> fecha;
  final Value<String?> motivo;
  const MovimientosInventarioCompanion({
    this.id = const Value.absent(),
    this.productoCodigo = const Value.absent(),
    this.nombreProducto = const Value.absent(),
    this.tipoMovimiento = const Value.absent(),
    this.stockAnterior = const Value.absent(),
    this.stockNuevo = const Value.absent(),
    this.fecha = const Value.absent(),
    this.motivo = const Value.absent(),
  });
  MovimientosInventarioCompanion.insert({
    this.id = const Value.absent(),
    required String productoCodigo,
    required String nombreProducto,
    required String tipoMovimiento,
    required int stockAnterior,
    required int stockNuevo,
    this.fecha = const Value.absent(),
    this.motivo = const Value.absent(),
  }) : productoCodigo = Value(productoCodigo),
       nombreProducto = Value(nombreProducto),
       tipoMovimiento = Value(tipoMovimiento),
       stockAnterior = Value(stockAnterior),
       stockNuevo = Value(stockNuevo);
  static Insertable<MovimientosInventarioData> custom({
    Expression<int>? id,
    Expression<String>? productoCodigo,
    Expression<String>? nombreProducto,
    Expression<String>? tipoMovimiento,
    Expression<int>? stockAnterior,
    Expression<int>? stockNuevo,
    Expression<DateTime>? fecha,
    Expression<String>? motivo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productoCodigo != null) 'producto_codigo': productoCodigo,
      if (nombreProducto != null) 'nombre_producto': nombreProducto,
      if (tipoMovimiento != null) 'tipo_movimiento': tipoMovimiento,
      if (stockAnterior != null) 'stock_anterior': stockAnterior,
      if (stockNuevo != null) 'stock_nuevo': stockNuevo,
      if (fecha != null) 'fecha': fecha,
      if (motivo != null) 'motivo': motivo,
    });
  }

  MovimientosInventarioCompanion copyWith({
    Value<int>? id,
    Value<String>? productoCodigo,
    Value<String>? nombreProducto,
    Value<String>? tipoMovimiento,
    Value<int>? stockAnterior,
    Value<int>? stockNuevo,
    Value<DateTime>? fecha,
    Value<String?>? motivo,
  }) {
    return MovimientosInventarioCompanion(
      id: id ?? this.id,
      productoCodigo: productoCodigo ?? this.productoCodigo,
      nombreProducto: nombreProducto ?? this.nombreProducto,
      tipoMovimiento: tipoMovimiento ?? this.tipoMovimiento,
      stockAnterior: stockAnterior ?? this.stockAnterior,
      stockNuevo: stockNuevo ?? this.stockNuevo,
      fecha: fecha ?? this.fecha,
      motivo: motivo ?? this.motivo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productoCodigo.present) {
      map['producto_codigo'] = Variable<String>(productoCodigo.value);
    }
    if (nombreProducto.present) {
      map['nombre_producto'] = Variable<String>(nombreProducto.value);
    }
    if (tipoMovimiento.present) {
      map['tipo_movimiento'] = Variable<String>(tipoMovimiento.value);
    }
    if (stockAnterior.present) {
      map['stock_anterior'] = Variable<int>(stockAnterior.value);
    }
    if (stockNuevo.present) {
      map['stock_nuevo'] = Variable<int>(stockNuevo.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (motivo.present) {
      map['motivo'] = Variable<String>(motivo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovimientosInventarioCompanion(')
          ..write('id: $id, ')
          ..write('productoCodigo: $productoCodigo, ')
          ..write('nombreProducto: $nombreProducto, ')
          ..write('tipoMovimiento: $tipoMovimiento, ')
          ..write('stockAnterior: $stockAnterior, ')
          ..write('stockNuevo: $stockNuevo, ')
          ..write('fecha: $fecha, ')
          ..write('motivo: $motivo')
          ..write(')'))
        .toString();
  }
}

class $ConfiguracionTable extends Configuracion
    with TableInfo<$ConfiguracionTable, ConfiguracionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfiguracionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _claveMeta = const VerificationMeta('clave');
  @override
  late final GeneratedColumn<String> clave = GeneratedColumn<String>(
    'clave',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<String> valor = GeneratedColumn<String>(
    'valor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [clave, valor, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'configuracion';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConfiguracionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('clave')) {
      context.handle(
        _claveMeta,
        clave.isAcceptableOrUnknown(data['clave']!, _claveMeta),
      );
    } else if (isInserting) {
      context.missing(_claveMeta);
    }
    if (data.containsKey('valor')) {
      context.handle(
        _valorMeta,
        valor.isAcceptableOrUnknown(data['valor']!, _valorMeta),
      );
    } else if (isInserting) {
      context.missing(_valorMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clave};
  @override
  ConfiguracionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConfiguracionData(
      clave: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clave'],
      )!,
      valor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valor'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ConfiguracionTable createAlias(String alias) {
    return $ConfiguracionTable(attachedDatabase, alias);
  }
}

class ConfiguracionData extends DataClass
    implements Insertable<ConfiguracionData> {
  final String clave;
  final String valor;
  final DateTime updatedAt;
  const ConfiguracionData({
    required this.clave,
    required this.valor,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['clave'] = Variable<String>(clave);
    map['valor'] = Variable<String>(valor);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ConfiguracionCompanion toCompanion(bool nullToAbsent) {
    return ConfiguracionCompanion(
      clave: Value(clave),
      valor: Value(valor),
      updatedAt: Value(updatedAt),
    );
  }

  factory ConfiguracionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConfiguracionData(
      clave: serializer.fromJson<String>(json['clave']),
      valor: serializer.fromJson<String>(json['valor']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clave': serializer.toJson<String>(clave),
      'valor': serializer.toJson<String>(valor),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ConfiguracionData copyWith({
    String? clave,
    String? valor,
    DateTime? updatedAt,
  }) => ConfiguracionData(
    clave: clave ?? this.clave,
    valor: valor ?? this.valor,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ConfiguracionData copyWithCompanion(ConfiguracionCompanion data) {
    return ConfiguracionData(
      clave: data.clave.present ? data.clave.value : this.clave,
      valor: data.valor.present ? data.valor.value : this.valor,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConfiguracionData(')
          ..write('clave: $clave, ')
          ..write('valor: $valor, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clave, valor, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConfiguracionData &&
          other.clave == this.clave &&
          other.valor == this.valor &&
          other.updatedAt == this.updatedAt);
}

class ConfiguracionCompanion extends UpdateCompanion<ConfiguracionData> {
  final Value<String> clave;
  final Value<String> valor;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ConfiguracionCompanion({
    this.clave = const Value.absent(),
    this.valor = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConfiguracionCompanion.insert({
    required String clave,
    required String valor,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : clave = Value(clave),
       valor = Value(valor);
  static Insertable<ConfiguracionData> custom({
    Expression<String>? clave,
    Expression<String>? valor,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clave != null) 'clave': clave,
      if (valor != null) 'valor': valor,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConfiguracionCompanion copyWith({
    Value<String>? clave,
    Value<String>? valor,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ConfiguracionCompanion(
      clave: clave ?? this.clave,
      valor: valor ?? this.valor,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clave.present) {
      map['clave'] = Variable<String>(clave.value);
    }
    if (valor.present) {
      map['valor'] = Variable<String>(valor.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfiguracionCompanion(')
          ..write('clave: $clave, ')
          ..write('valor: $valor, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductosTable productos = $ProductosTable(this);
  late final $VentasTable ventas = $VentasTable(this);
  late final $DetalleVentasTable detalleVentas = $DetalleVentasTable(this);
  late final $MovimientosInventarioTable movimientosInventario =
      $MovimientosInventarioTable(this);
  late final $ConfiguracionTable configuracion = $ConfiguracionTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    productos,
    ventas,
    detalleVentas,
    movimientosInventario,
    configuracion,
  ];
}

typedef $$ProductosTableCreateCompanionBuilder =
    ProductosCompanion Function({
      required String codigoBarras,
      required String nombre,
      Value<String?> categoria,
      required double precioUnitarioDolar,
      required int cantidadStock,
      Value<int> rowid,
    });
typedef $$ProductosTableUpdateCompanionBuilder =
    ProductosCompanion Function({
      Value<String> codigoBarras,
      Value<String> nombre,
      Value<String?> categoria,
      Value<double> precioUnitarioDolar,
      Value<int> cantidadStock,
      Value<int> rowid,
    });

final class $$ProductosTableReferences
    extends BaseReferences<_$AppDatabase, $ProductosTable, Producto> {
  $$ProductosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DetalleVentasTable, List<DetalleVenta>>
  _detalleVentasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.detalleVentas,
    aliasName: 'productos__codigo_barras__detalle_ventas__producto_codigo',
  );

  $$DetalleVentasTableProcessedTableManager get detalleVentasRefs {
    final manager = $$DetalleVentasTableTableManager($_db, $_db.detalleVentas)
        .filter(
          (f) => f.productoCodigo.codigoBarras.sqlEquals(
            $_itemColumn<String>('codigo_barras')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_detalleVentasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $MovimientosInventarioTable,
    List<MovimientosInventarioData>
  >
  _movimientosInventarioRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.movimientosInventario,
        aliasName:
            'productos__codigo_barras__movimientos_inventario__producto_codigo',
      );

  $$MovimientosInventarioTableProcessedTableManager
  get movimientosInventarioRefs {
    final manager =
        $$MovimientosInventarioTableTableManager(
          $_db,
          $_db.movimientosInventario,
        ).filter(
          (f) => f.productoCodigo.codigoBarras.sqlEquals(
            $_itemColumn<String>('codigo_barras')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(
      _movimientosInventarioRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductosTableFilterComposer
    extends Composer<_$AppDatabase, $ProductosTable> {
  $$ProductosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get codigoBarras => $composableBuilder(
    column: $table.codigoBarras,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precioUnitarioDolar => $composableBuilder(
    column: $table.precioUnitarioDolar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cantidadStock => $composableBuilder(
    column: $table.cantidadStock,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> detalleVentasRefs(
    Expression<bool> Function($$DetalleVentasTableFilterComposer f) f,
  ) {
    final $$DetalleVentasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.codigoBarras,
      referencedTable: $db.detalleVentas,
      getReferencedColumn: (t) => t.productoCodigo,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetalleVentasTableFilterComposer(
            $db: $db,
            $table: $db.detalleVentas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> movimientosInventarioRefs(
    Expression<bool> Function($$MovimientosInventarioTableFilterComposer f) f,
  ) {
    final $$MovimientosInventarioTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.codigoBarras,
          referencedTable: $db.movimientosInventario,
          getReferencedColumn: (t) => t.productoCodigo,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MovimientosInventarioTableFilterComposer(
                $db: $db,
                $table: $db.movimientosInventario,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProductosTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductosTable> {
  $$ProductosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get codigoBarras => $composableBuilder(
    column: $table.codigoBarras,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precioUnitarioDolar => $composableBuilder(
    column: $table.precioUnitarioDolar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cantidadStock => $composableBuilder(
    column: $table.cantidadStock,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductosTable> {
  $$ProductosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get codigoBarras => $composableBuilder(
    column: $table.codigoBarras,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<double> get precioUnitarioDolar => $composableBuilder(
    column: $table.precioUnitarioDolar,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cantidadStock => $composableBuilder(
    column: $table.cantidadStock,
    builder: (column) => column,
  );

  Expression<T> detalleVentasRefs<T extends Object>(
    Expression<T> Function($$DetalleVentasTableAnnotationComposer a) f,
  ) {
    final $$DetalleVentasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.codigoBarras,
      referencedTable: $db.detalleVentas,
      getReferencedColumn: (t) => t.productoCodigo,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetalleVentasTableAnnotationComposer(
            $db: $db,
            $table: $db.detalleVentas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> movimientosInventarioRefs<T extends Object>(
    Expression<T> Function($$MovimientosInventarioTableAnnotationComposer a) f,
  ) {
    final $$MovimientosInventarioTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.codigoBarras,
          referencedTable: $db.movimientosInventario,
          getReferencedColumn: (t) => t.productoCodigo,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MovimientosInventarioTableAnnotationComposer(
                $db: $db,
                $table: $db.movimientosInventario,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProductosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductosTable,
          Producto,
          $$ProductosTableFilterComposer,
          $$ProductosTableOrderingComposer,
          $$ProductosTableAnnotationComposer,
          $$ProductosTableCreateCompanionBuilder,
          $$ProductosTableUpdateCompanionBuilder,
          (Producto, $$ProductosTableReferences),
          Producto,
          PrefetchHooks Function({
            bool detalleVentasRefs,
            bool movimientosInventarioRefs,
          })
        > {
  $$ProductosTableTableManager(_$AppDatabase db, $ProductosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> codigoBarras = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> categoria = const Value.absent(),
                Value<double> precioUnitarioDolar = const Value.absent(),
                Value<int> cantidadStock = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductosCompanion(
                codigoBarras: codigoBarras,
                nombre: nombre,
                categoria: categoria,
                precioUnitarioDolar: precioUnitarioDolar,
                cantidadStock: cantidadStock,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String codigoBarras,
                required String nombre,
                Value<String?> categoria = const Value.absent(),
                required double precioUnitarioDolar,
                required int cantidadStock,
                Value<int> rowid = const Value.absent(),
              }) => ProductosCompanion.insert(
                codigoBarras: codigoBarras,
                nombre: nombre,
                categoria: categoria,
                precioUnitarioDolar: precioUnitarioDolar,
                cantidadStock: cantidadStock,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({detalleVentasRefs = false, movimientosInventarioRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (detalleVentasRefs) db.detalleVentas,
                    if (movimientosInventarioRefs) db.movimientosInventario,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (detalleVentasRefs)
                        await $_getPrefetchedData<
                          Producto,
                          $ProductosTable,
                          DetalleVenta
                        >(
                          currentTable: table,
                          referencedTable: $$ProductosTableReferences
                              ._detalleVentasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductosTableReferences(
                                db,
                                table,
                                p0,
                              ).detalleVentasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productoCodigo == item.codigoBarras,
                              ),
                          typedResults: items,
                        ),
                      if (movimientosInventarioRefs)
                        await $_getPrefetchedData<
                          Producto,
                          $ProductosTable,
                          MovimientosInventarioData
                        >(
                          currentTable: table,
                          referencedTable: $$ProductosTableReferences
                              ._movimientosInventarioRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductosTableReferences(
                                db,
                                table,
                                p0,
                              ).movimientosInventarioRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productoCodigo == item.codigoBarras,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductosTable,
      Producto,
      $$ProductosTableFilterComposer,
      $$ProductosTableOrderingComposer,
      $$ProductosTableAnnotationComposer,
      $$ProductosTableCreateCompanionBuilder,
      $$ProductosTableUpdateCompanionBuilder,
      (Producto, $$ProductosTableReferences),
      Producto,
      PrefetchHooks Function({
        bool detalleVentasRefs,
        bool movimientosInventarioRefs,
      })
    >;
typedef $$VentasTableCreateCompanionBuilder =
    VentasCompanion Function({
      required String id,
      Value<DateTime> fecha,
      required double tasaDolarUsada,
      required double montoTotalDolar,
      required String metodoPago,
      required double montoTotalBs,
      Value<int> rowid,
    });
typedef $$VentasTableUpdateCompanionBuilder =
    VentasCompanion Function({
      Value<String> id,
      Value<DateTime> fecha,
      Value<double> tasaDolarUsada,
      Value<double> montoTotalDolar,
      Value<String> metodoPago,
      Value<double> montoTotalBs,
      Value<int> rowid,
    });

final class $$VentasTableReferences
    extends BaseReferences<_$AppDatabase, $VentasTable, Venta> {
  $$VentasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DetalleVentasTable, List<DetalleVenta>>
  _detalleVentasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.detalleVentas,
    aliasName: 'ventas__id__detalle_ventas__venta_id',
  );

  $$DetalleVentasTableProcessedTableManager get detalleVentasRefs {
    final manager = $$DetalleVentasTableTableManager(
      $_db,
      $_db.detalleVentas,
    ).filter((f) => f.ventaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_detalleVentasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VentasTableFilterComposer
    extends Composer<_$AppDatabase, $VentasTable> {
  $$VentasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tasaDolarUsada => $composableBuilder(
    column: $table.tasaDolarUsada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get montoTotalDolar => $composableBuilder(
    column: $table.montoTotalDolar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metodoPago => $composableBuilder(
    column: $table.metodoPago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get montoTotalBs => $composableBuilder(
    column: $table.montoTotalBs,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> detalleVentasRefs(
    Expression<bool> Function($$DetalleVentasTableFilterComposer f) f,
  ) {
    final $$DetalleVentasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.detalleVentas,
      getReferencedColumn: (t) => t.ventaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetalleVentasTableFilterComposer(
            $db: $db,
            $table: $db.detalleVentas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VentasTableOrderingComposer
    extends Composer<_$AppDatabase, $VentasTable> {
  $$VentasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tasaDolarUsada => $composableBuilder(
    column: $table.tasaDolarUsada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get montoTotalDolar => $composableBuilder(
    column: $table.montoTotalDolar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metodoPago => $composableBuilder(
    column: $table.metodoPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get montoTotalBs => $composableBuilder(
    column: $table.montoTotalBs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VentasTableAnnotationComposer
    extends Composer<_$AppDatabase, $VentasTable> {
  $$VentasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<double> get tasaDolarUsada => $composableBuilder(
    column: $table.tasaDolarUsada,
    builder: (column) => column,
  );

  GeneratedColumn<double> get montoTotalDolar => $composableBuilder(
    column: $table.montoTotalDolar,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metodoPago => $composableBuilder(
    column: $table.metodoPago,
    builder: (column) => column,
  );

  GeneratedColumn<double> get montoTotalBs => $composableBuilder(
    column: $table.montoTotalBs,
    builder: (column) => column,
  );

  Expression<T> detalleVentasRefs<T extends Object>(
    Expression<T> Function($$DetalleVentasTableAnnotationComposer a) f,
  ) {
    final $$DetalleVentasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.detalleVentas,
      getReferencedColumn: (t) => t.ventaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DetalleVentasTableAnnotationComposer(
            $db: $db,
            $table: $db.detalleVentas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VentasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VentasTable,
          Venta,
          $$VentasTableFilterComposer,
          $$VentasTableOrderingComposer,
          $$VentasTableAnnotationComposer,
          $$VentasTableCreateCompanionBuilder,
          $$VentasTableUpdateCompanionBuilder,
          (Venta, $$VentasTableReferences),
          Venta,
          PrefetchHooks Function({bool detalleVentasRefs})
        > {
  $$VentasTableTableManager(_$AppDatabase db, $VentasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VentasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VentasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VentasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<double> tasaDolarUsada = const Value.absent(),
                Value<double> montoTotalDolar = const Value.absent(),
                Value<String> metodoPago = const Value.absent(),
                Value<double> montoTotalBs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VentasCompanion(
                id: id,
                fecha: fecha,
                tasaDolarUsada: tasaDolarUsada,
                montoTotalDolar: montoTotalDolar,
                metodoPago: metodoPago,
                montoTotalBs: montoTotalBs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<DateTime> fecha = const Value.absent(),
                required double tasaDolarUsada,
                required double montoTotalDolar,
                required String metodoPago,
                required double montoTotalBs,
                Value<int> rowid = const Value.absent(),
              }) => VentasCompanion.insert(
                id: id,
                fecha: fecha,
                tasaDolarUsada: tasaDolarUsada,
                montoTotalDolar: montoTotalDolar,
                metodoPago: metodoPago,
                montoTotalBs: montoTotalBs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$VentasTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({detalleVentasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (detalleVentasRefs) db.detalleVentas,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (detalleVentasRefs)
                    await $_getPrefetchedData<
                      Venta,
                      $VentasTable,
                      DetalleVenta
                    >(
                      currentTable: table,
                      referencedTable: $$VentasTableReferences
                          ._detalleVentasRefsTable(db),
                      managerFromTypedResult: (p0) => $$VentasTableReferences(
                        db,
                        table,
                        p0,
                      ).detalleVentasRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.ventaId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$VentasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VentasTable,
      Venta,
      $$VentasTableFilterComposer,
      $$VentasTableOrderingComposer,
      $$VentasTableAnnotationComposer,
      $$VentasTableCreateCompanionBuilder,
      $$VentasTableUpdateCompanionBuilder,
      (Venta, $$VentasTableReferences),
      Venta,
      PrefetchHooks Function({bool detalleVentasRefs})
    >;
typedef $$DetalleVentasTableCreateCompanionBuilder =
    DetalleVentasCompanion Function({
      required String id,
      required String ventaId,
      required String productoCodigo,
      required double precioUnitario,
      required double cantidadVendida,
      required double subTotal,
      Value<int> rowid,
    });
typedef $$DetalleVentasTableUpdateCompanionBuilder =
    DetalleVentasCompanion Function({
      Value<String> id,
      Value<String> ventaId,
      Value<String> productoCodigo,
      Value<double> precioUnitario,
      Value<double> cantidadVendida,
      Value<double> subTotal,
      Value<int> rowid,
    });

final class $$DetalleVentasTableReferences
    extends BaseReferences<_$AppDatabase, $DetalleVentasTable, DetalleVenta> {
  $$DetalleVentasTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VentasTable _ventaIdTable(_$AppDatabase db) =>
      db.ventas.createAlias('detalle_ventas__venta_id__ventas__id');

  $$VentasTableProcessedTableManager get ventaId {
    final $_column = $_itemColumn<String>('venta_id')!;

    final manager = $$VentasTableTableManager(
      $_db,
      $_db.ventas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ventaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductosTable _productoCodigoTable(_$AppDatabase db) => db.productos
      .createAlias('detalle_ventas__producto_codigo__productos__codigo_barras');

  $$ProductosTableProcessedTableManager get productoCodigo {
    final $_column = $_itemColumn<String>('producto_codigo')!;

    final manager = $$ProductosTableTableManager(
      $_db,
      $_db.productos,
    ).filter((f) => f.codigoBarras.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productoCodigoTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DetalleVentasTableFilterComposer
    extends Composer<_$AppDatabase, $DetalleVentasTable> {
  $$DetalleVentasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cantidadVendida => $composableBuilder(
    column: $table.cantidadVendida,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subTotal => $composableBuilder(
    column: $table.subTotal,
    builder: (column) => ColumnFilters(column),
  );

  $$VentasTableFilterComposer get ventaId {
    final $$VentasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ventaId,
      referencedTable: $db.ventas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentasTableFilterComposer(
            $db: $db,
            $table: $db.ventas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductosTableFilterComposer get productoCodigo {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoCodigo,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.codigoBarras,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableFilterComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DetalleVentasTableOrderingComposer
    extends Composer<_$AppDatabase, $DetalleVentasTable> {
  $$DetalleVentasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cantidadVendida => $composableBuilder(
    column: $table.cantidadVendida,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subTotal => $composableBuilder(
    column: $table.subTotal,
    builder: (column) => ColumnOrderings(column),
  );

  $$VentasTableOrderingComposer get ventaId {
    final $$VentasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ventaId,
      referencedTable: $db.ventas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentasTableOrderingComposer(
            $db: $db,
            $table: $db.ventas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductosTableOrderingComposer get productoCodigo {
    final $$ProductosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoCodigo,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.codigoBarras,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableOrderingComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DetalleVentasTableAnnotationComposer
    extends Composer<_$AppDatabase, $DetalleVentasTable> {
  $$DetalleVentasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cantidadVendida => $composableBuilder(
    column: $table.cantidadVendida,
    builder: (column) => column,
  );

  GeneratedColumn<double> get subTotal =>
      $composableBuilder(column: $table.subTotal, builder: (column) => column);

  $$VentasTableAnnotationComposer get ventaId {
    final $$VentasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ventaId,
      referencedTable: $db.ventas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentasTableAnnotationComposer(
            $db: $db,
            $table: $db.ventas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductosTableAnnotationComposer get productoCodigo {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoCodigo,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.codigoBarras,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableAnnotationComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DetalleVentasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DetalleVentasTable,
          DetalleVenta,
          $$DetalleVentasTableFilterComposer,
          $$DetalleVentasTableOrderingComposer,
          $$DetalleVentasTableAnnotationComposer,
          $$DetalleVentasTableCreateCompanionBuilder,
          $$DetalleVentasTableUpdateCompanionBuilder,
          (DetalleVenta, $$DetalleVentasTableReferences),
          DetalleVenta,
          PrefetchHooks Function({bool ventaId, bool productoCodigo})
        > {
  $$DetalleVentasTableTableManager(_$AppDatabase db, $DetalleVentasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DetalleVentasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DetalleVentasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DetalleVentasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ventaId = const Value.absent(),
                Value<String> productoCodigo = const Value.absent(),
                Value<double> precioUnitario = const Value.absent(),
                Value<double> cantidadVendida = const Value.absent(),
                Value<double> subTotal = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DetalleVentasCompanion(
                id: id,
                ventaId: ventaId,
                productoCodigo: productoCodigo,
                precioUnitario: precioUnitario,
                cantidadVendida: cantidadVendida,
                subTotal: subTotal,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ventaId,
                required String productoCodigo,
                required double precioUnitario,
                required double cantidadVendida,
                required double subTotal,
                Value<int> rowid = const Value.absent(),
              }) => DetalleVentasCompanion.insert(
                id: id,
                ventaId: ventaId,
                productoCodigo: productoCodigo,
                precioUnitario: precioUnitario,
                cantidadVendida: cantidadVendida,
                subTotal: subTotal,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DetalleVentasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ventaId = false, productoCodigo = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ventaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ventaId,
                                referencedTable: $$DetalleVentasTableReferences
                                    ._ventaIdTable(db),
                                referencedColumn: $$DetalleVentasTableReferences
                                    ._ventaIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (productoCodigo) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productoCodigo,
                                referencedTable: $$DetalleVentasTableReferences
                                    ._productoCodigoTable(db),
                                referencedColumn: $$DetalleVentasTableReferences
                                    ._productoCodigoTable(db)
                                    .codigoBarras,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DetalleVentasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DetalleVentasTable,
      DetalleVenta,
      $$DetalleVentasTableFilterComposer,
      $$DetalleVentasTableOrderingComposer,
      $$DetalleVentasTableAnnotationComposer,
      $$DetalleVentasTableCreateCompanionBuilder,
      $$DetalleVentasTableUpdateCompanionBuilder,
      (DetalleVenta, $$DetalleVentasTableReferences),
      DetalleVenta,
      PrefetchHooks Function({bool ventaId, bool productoCodigo})
    >;
typedef $$MovimientosInventarioTableCreateCompanionBuilder =
    MovimientosInventarioCompanion Function({
      Value<int> id,
      required String productoCodigo,
      required String nombreProducto,
      required String tipoMovimiento,
      required int stockAnterior,
      required int stockNuevo,
      Value<DateTime> fecha,
      Value<String?> motivo,
    });
typedef $$MovimientosInventarioTableUpdateCompanionBuilder =
    MovimientosInventarioCompanion Function({
      Value<int> id,
      Value<String> productoCodigo,
      Value<String> nombreProducto,
      Value<String> tipoMovimiento,
      Value<int> stockAnterior,
      Value<int> stockNuevo,
      Value<DateTime> fecha,
      Value<String?> motivo,
    });

final class $$MovimientosInventarioTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MovimientosInventarioTable,
          MovimientosInventarioData
        > {
  $$MovimientosInventarioTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductosTable _productoCodigoTable(_$AppDatabase db) =>
      db.productos.createAlias(
        'movimientos_inventario__producto_codigo__productos__codigo_barras',
      );

  $$ProductosTableProcessedTableManager get productoCodigo {
    final $_column = $_itemColumn<String>('producto_codigo')!;

    final manager = $$ProductosTableTableManager(
      $_db,
      $_db.productos,
    ).filter((f) => f.codigoBarras.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productoCodigoTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MovimientosInventarioTableFilterComposer
    extends Composer<_$AppDatabase, $MovimientosInventarioTable> {
  $$MovimientosInventarioTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombreProducto => $composableBuilder(
    column: $table.nombreProducto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipoMovimiento => $composableBuilder(
    column: $table.tipoMovimiento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockAnterior => $composableBuilder(
    column: $table.stockAnterior,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockNuevo => $composableBuilder(
    column: $table.stockNuevo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductosTableFilterComposer get productoCodigo {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoCodigo,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.codigoBarras,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableFilterComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimientosInventarioTableOrderingComposer
    extends Composer<_$AppDatabase, $MovimientosInventarioTable> {
  $$MovimientosInventarioTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombreProducto => $composableBuilder(
    column: $table.nombreProducto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoMovimiento => $composableBuilder(
    column: $table.tipoMovimiento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockAnterior => $composableBuilder(
    column: $table.stockAnterior,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockNuevo => $composableBuilder(
    column: $table.stockNuevo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductosTableOrderingComposer get productoCodigo {
    final $$ProductosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoCodigo,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.codigoBarras,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableOrderingComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimientosInventarioTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovimientosInventarioTable> {
  $$MovimientosInventarioTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombreProducto => $composableBuilder(
    column: $table.nombreProducto,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tipoMovimiento => $composableBuilder(
    column: $table.tipoMovimiento,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stockAnterior => $composableBuilder(
    column: $table.stockAnterior,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stockNuevo => $composableBuilder(
    column: $table.stockNuevo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get motivo =>
      $composableBuilder(column: $table.motivo, builder: (column) => column);

  $$ProductosTableAnnotationComposer get productoCodigo {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoCodigo,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.codigoBarras,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableAnnotationComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MovimientosInventarioTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovimientosInventarioTable,
          MovimientosInventarioData,
          $$MovimientosInventarioTableFilterComposer,
          $$MovimientosInventarioTableOrderingComposer,
          $$MovimientosInventarioTableAnnotationComposer,
          $$MovimientosInventarioTableCreateCompanionBuilder,
          $$MovimientosInventarioTableUpdateCompanionBuilder,
          (MovimientosInventarioData, $$MovimientosInventarioTableReferences),
          MovimientosInventarioData,
          PrefetchHooks Function({bool productoCodigo})
        > {
  $$MovimientosInventarioTableTableManager(
    _$AppDatabase db,
    $MovimientosInventarioTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovimientosInventarioTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MovimientosInventarioTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MovimientosInventarioTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> productoCodigo = const Value.absent(),
                Value<String> nombreProducto = const Value.absent(),
                Value<String> tipoMovimiento = const Value.absent(),
                Value<int> stockAnterior = const Value.absent(),
                Value<int> stockNuevo = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<String?> motivo = const Value.absent(),
              }) => MovimientosInventarioCompanion(
                id: id,
                productoCodigo: productoCodigo,
                nombreProducto: nombreProducto,
                tipoMovimiento: tipoMovimiento,
                stockAnterior: stockAnterior,
                stockNuevo: stockNuevo,
                fecha: fecha,
                motivo: motivo,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String productoCodigo,
                required String nombreProducto,
                required String tipoMovimiento,
                required int stockAnterior,
                required int stockNuevo,
                Value<DateTime> fecha = const Value.absent(),
                Value<String?> motivo = const Value.absent(),
              }) => MovimientosInventarioCompanion.insert(
                id: id,
                productoCodigo: productoCodigo,
                nombreProducto: nombreProducto,
                tipoMovimiento: tipoMovimiento,
                stockAnterior: stockAnterior,
                stockNuevo: stockNuevo,
                fecha: fecha,
                motivo: motivo,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MovimientosInventarioTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productoCodigo = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productoCodigo) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productoCodigo,
                                referencedTable:
                                    $$MovimientosInventarioTableReferences
                                        ._productoCodigoTable(db),
                                referencedColumn:
                                    $$MovimientosInventarioTableReferences
                                        ._productoCodigoTable(db)
                                        .codigoBarras,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MovimientosInventarioTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovimientosInventarioTable,
      MovimientosInventarioData,
      $$MovimientosInventarioTableFilterComposer,
      $$MovimientosInventarioTableOrderingComposer,
      $$MovimientosInventarioTableAnnotationComposer,
      $$MovimientosInventarioTableCreateCompanionBuilder,
      $$MovimientosInventarioTableUpdateCompanionBuilder,
      (MovimientosInventarioData, $$MovimientosInventarioTableReferences),
      MovimientosInventarioData,
      PrefetchHooks Function({bool productoCodigo})
    >;
typedef $$ConfiguracionTableCreateCompanionBuilder =
    ConfiguracionCompanion Function({
      required String clave,
      required String valor,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ConfiguracionTableUpdateCompanionBuilder =
    ConfiguracionCompanion Function({
      Value<String> clave,
      Value<String> valor,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ConfiguracionTableFilterComposer
    extends Composer<_$AppDatabase, $ConfiguracionTable> {
  $$ConfiguracionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clave => $composableBuilder(
    column: $table.clave,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valor => $composableBuilder(
    column: $table.valor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ConfiguracionTableOrderingComposer
    extends Composer<_$AppDatabase, $ConfiguracionTable> {
  $$ConfiguracionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clave => $composableBuilder(
    column: $table.clave,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valor => $composableBuilder(
    column: $table.valor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConfiguracionTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConfiguracionTable> {
  $$ConfiguracionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clave =>
      $composableBuilder(column: $table.clave, builder: (column) => column);

  GeneratedColumn<String> get valor =>
      $composableBuilder(column: $table.valor, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ConfiguracionTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConfiguracionTable,
          ConfiguracionData,
          $$ConfiguracionTableFilterComposer,
          $$ConfiguracionTableOrderingComposer,
          $$ConfiguracionTableAnnotationComposer,
          $$ConfiguracionTableCreateCompanionBuilder,
          $$ConfiguracionTableUpdateCompanionBuilder,
          (
            ConfiguracionData,
            BaseReferences<
              _$AppDatabase,
              $ConfiguracionTable,
              ConfiguracionData
            >,
          ),
          ConfiguracionData,
          PrefetchHooks Function()
        > {
  $$ConfiguracionTableTableManager(_$AppDatabase db, $ConfiguracionTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConfiguracionTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConfiguracionTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConfiguracionTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> clave = const Value.absent(),
                Value<String> valor = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConfiguracionCompanion(
                clave: clave,
                valor: valor,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clave,
                required String valor,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConfiguracionCompanion.insert(
                clave: clave,
                valor: valor,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ConfiguracionTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConfiguracionTable,
      ConfiguracionData,
      $$ConfiguracionTableFilterComposer,
      $$ConfiguracionTableOrderingComposer,
      $$ConfiguracionTableAnnotationComposer,
      $$ConfiguracionTableCreateCompanionBuilder,
      $$ConfiguracionTableUpdateCompanionBuilder,
      (
        ConfiguracionData,
        BaseReferences<_$AppDatabase, $ConfiguracionTable, ConfiguracionData>,
      ),
      ConfiguracionData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductosTableTableManager get productos =>
      $$ProductosTableTableManager(_db, _db.productos);
  $$VentasTableTableManager get ventas =>
      $$VentasTableTableManager(_db, _db.ventas);
  $$DetalleVentasTableTableManager get detalleVentas =>
      $$DetalleVentasTableTableManager(_db, _db.detalleVentas);
  $$MovimientosInventarioTableTableManager get movimientosInventario =>
      $$MovimientosInventarioTableTableManager(_db, _db.movimientosInventario);
  $$ConfiguracionTableTableManager get configuracion =>
      $$ConfiguracionTableTableManager(_db, _db.configuracion);
}
