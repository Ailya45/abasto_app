import 'package:abasto_app/config/helpers/os_version.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Indica si Windows 11 (build >= 22000) está disponible para usar el
/// backdrop nativo Mica. En caso contrario la app usa el fallback Acrylic.
final micaAvailableProvider = Provider<bool>((ref) {
  return windowsBuildNumber() >= 22000;
});
