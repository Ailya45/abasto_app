import 'package:abasto_app/infrastructure/datasource/drift_datasource.dart';
import 'package:abasto_app/infrastructure/repository/local_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(DriftDatasource());
});