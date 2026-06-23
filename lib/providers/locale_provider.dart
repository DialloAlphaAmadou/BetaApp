import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('fr'));

  void setLocale(Locale locale) {
    state = locale;
  }

  void setFrench() {
    state = const Locale('fr');
  }

  void setEnglish() {
    state = const Locale('en');
  }

  void toggleLanguage() {
    state = state.languageCode == 'fr'
        ? const Locale('en')
        : const Locale('fr');
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>( (ref) => LocaleNotifier(), );