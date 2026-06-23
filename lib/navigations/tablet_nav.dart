import 'package:first_app/navigations/app_router.dart';
import 'package:first_app/navigations/nav_responsive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TabletNavigation extends StatelessWidget {
  //final NavController controller;
  final int index;
  final Widget child;
  final Function(int) onTap;

  const TabletNavigation({
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
      body: child,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // 🔥 important
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary,),
              child: Text('Menu', style: TextStyle(fontSize: 24))
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'), 
              onTap: () {
                onTap(0);
                context.pop();
              }
            ),
            ListTile(
              leading: const Icon(Icons.build),
              title: const Text('Service'), 
              onTap: () {
                onTap(1);
                context.pop();
              }
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'), 
              onTap: () {
                onTap(2);
                context.pop();
              }
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'), 
              onTap: () {
                onTap(2);
                context.pop();
              }
            ),
          ],
        ),
      ),
    );
  }

}







/*Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              color: Theme.of(context).colorScheme.primary,
              child: const Text('Menu', style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),*/