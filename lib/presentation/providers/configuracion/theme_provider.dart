import 'package:abasto_app/domain/repository/local_storage_repository.dart';
import 'package:abasto_app/presentation/providers/storage/local_storage_provider.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Swatches de colores de acento disponibles en la aplicación.
final Map<String, AccentColor> kAccentSwatches = {
  'blue': Colors.blue,
  'green': Colors.green,
  'teal': Colors.teal,
  'purple': Colors.purple,
  'orange': Colors.orange,
  'magenta': Colors.magenta,
  'red': Colors.red,
};

class ThemeState {
  final ThemeMode themeMode;
  final String accentKey;

  const ThemeState({
    this.themeMode = ThemeMode.system,
    this.accentKey = 'blue',
  });

  AccentColor get accentColor =>
      kAccentSwatches[accentKey] ?? Colors.blue;

  FluentThemeData get light => FluentThemeData(
        brightness: Brightness.light,
        accentColor: accentColor,
      );

  FluentThemeData get dark => FluentThemeData(
        brightness: Brightness.dark,
        accentColor: accentColor,
      );

  ThemeState copyWith({ThemeMode? themeMode, String? accentKey}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      accentKey: accentKey ?? this.accentKey,
    );
  }
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier(this._repository) : super(const ThemeState());

  final LocalStorageRepository _repository;

  static const _claveTema = 'tema_app';
  static const _claveColor = 'color_app';

  Future<void> cargarPreferencias() async {
    final tema = await _repository.getConfigValue(_claveTema);
    final color = await _repository.getConfigValue(_claveColor);

    ThemeMode modo = ThemeMode.system;
    switch (tema) {
      case 'light':
        modo = ThemeMode.light;
      case 'dark':
        modo = ThemeMode.dark;
    }

    final acento = kAccentSwatches.containsKey(color) ? color! : 'blue';
    state = state.copyWith(themeMode: modo, accentKey: acento);
  }

  void setThemeMode(ThemeMode modo) {
    state = state.copyWith(themeMode: modo);
    final valor = switch (modo) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    _repository.setConfigValue(_claveTema, valor);
  }

  void setAccent(String key) {
    if (!kAccentSwatches.containsKey(key)) return;
    state = state.copyWith(accentKey: key);
    _repository.setConfigValue(_claveColor, key);
  }
}

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
      final notifier = ThemeNotifier(
        ref.watch(localStorageRepositoryProvider),
      );
      Future.microtask(notifier.cargarPreferencias);
      return notifier;
    });
