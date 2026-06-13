import 'package:first_app/navigations/nav_controller.dart';
import 'package:flutter/material.dart';

class MobileNavigation extends StatelessWidget{

  final NavController controller;
  final Function(int) onPageChanged;

  const MobileNavigation({
    super.key,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final index = controller.currentIndex;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          NavData.titles[index].toUpperCase(), 
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: NavData.pages[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        currentIndex: index,
        onTap: onPageChanged,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Service'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting'),
          BottomNavigationBarItem(icon: Icon(Icons.pages), label: 'Pages'),
        ],
      ),
    );
  }
}