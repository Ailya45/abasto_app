import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

typedef _RtlGetVersionNative = Int32 Function(Pointer<_OsVersionInfo>);
typedef _RtlGetVersion = int Function(Pointer<_OsVersionInfo>);

final class _OsVersionInfo extends Struct {
  @Uint32()
  external int dwOSVersionInfoSize;

  @Uint32()
  external int dwMajorVersion;

  @Uint32()
  external int dwMinorVersion;

  @Uint32()
  external int dwBuildNumber;

  @Uint32()
  external int dwPlatformId;

  @Array(128)
  external Array<Uint16> szCSDVersion;
}

/// Devuelve el número de build real de Windows (0 si no es Windows o falla).
///
/// Usa RtlGetVersion de ntdll, que siempre reporta el build real (el de
/// `Platform.operatingSystemVersion` puede venir enmascarado como 10.0.19044).
int windowsBuildNumber() {
  if (!Platform.isWindows) return 0;
  try {
    final ntdll = DynamicLibrary.open('ntdll.dll');
    final rtlGetVersion = ntdll.lookupFunction<_RtlGetVersionNative, _RtlGetVersion>(
      'RtlGetVersion',
    );
    final info = calloc<_OsVersionInfo>();
    try {
      info.ref.dwOSVersionInfoSize = sizeOf<_OsVersionInfo>();
      // RtlGetVersion devuelve STATUS_SUCCESS (0) al tener éxito.
      final status = rtlGetVersion(info);
      if (status != 0) return 0;
      return info.ref.dwBuildNumber;
    } finally {
      calloc.free(info);
    }
  } catch (_) {
    return 0;
  }
}
