import 'package:first_app/navigations/app_router.dart';
import 'package:first_app/navigations/nav_responsive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DesktopNavigation extends StatelessWidget{
  //final NavController controller;
  final int index;
  final Widget child;
  final Function(int) onTap;

  const DesktopNavigation({
    super.key,
    required this.index,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    //final index = controller.currentIndex;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          NavMenu.titles[index].toUpperCase(), 
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push(AppRoutes.profile),
          ),
          const SizedBox(width: 8),
        ]
      ),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
            selectedIndex: index,
            onDestinationSelected: onTap,
            labelType: NavigationRailLabelType.all,
            destinations: const[
              NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
              NavigationRailDestination(icon: Icon(Icons.build), label: Text('Service')),
              NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Setting')),
            ],
          ),
          Expanded(child: child),
        ],
      )

    );
  }
}