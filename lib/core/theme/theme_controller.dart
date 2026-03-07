import 'package:flutter/material.dart';

/// Simple global controller for app theme mode.
///
/// Wraps a [ValueNotifier] so widgets can listen and rebuild when the
/// theme changes, and exposes helper methods to switch themes.
class ThemeController {
  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier<ThemeMode>(ThemeMode.system);

  static void setLight() {
    themeMode.value = ThemeMode.light;
  }

  static void setDark() {
    themeMode.value = ThemeMode.dark;
  }

  static void toggle() {
    themeMode.value =
        themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

