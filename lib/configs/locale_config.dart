import 'package:flutter/material.dart';

class LocaleConfig {
  static final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('en'));

  static void changeLocale(String langCode) {
    localeNotifier.value = Locale(langCode);
  }
}