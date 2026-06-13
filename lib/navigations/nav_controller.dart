import 'package:first_app/screens/home_page.dart';
import 'package:first_app/screens/pages.dart';
import 'package:first_app/screens/service_page.dart';
import 'package:first_app/screens/setting_page.dart';
import 'package:flutter/material.dart';

class NavController {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void goTo(int index){
    _currentIndex = index;
  }
}

class NavData {
  static final List<Widget> pages = const [
    HomePage(),
    ServicePage(),
    SettingPage(),
    Pages(),
  ]; 

  static final List<String> titles = [
    'Home', 'Service', 'Setting', 'Pages'
  ];
}