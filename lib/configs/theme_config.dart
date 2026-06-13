import 'package:flutter/material.dart';

class ThemeConfig {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
  
  static void toggleTheme(bool darkMode) {
    themeNotifier.value = darkMode ? ThemeMode.dark : ThemeMode.light;
  }

  static void toggleTheme1() {
    themeNotifier.value =
        themeNotifier.value == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;
  }
}