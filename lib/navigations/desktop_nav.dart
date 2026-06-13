import 'package:first_app/navigations/nav_controller.dart';
import 'package:flutter/material.dart';

class DesktopNavigation extends StatelessWidget{
  final NavController controller;
  final Function(int) onPageChanged;

  const DesktopNavigation({
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
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
            selectedIndex: index,
            onDestinationSelected: onPageChanged,
            labelType: NavigationRailLabelType.all,
            destinations: const[
              NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
              NavigationRailDestination(icon: Icon(Icons.build), label: Text('Service')),
              NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Setting')),
            ],
          ),
          Expanded(child: NavData.pages[index]),
        ],
      )

    );
  }
}