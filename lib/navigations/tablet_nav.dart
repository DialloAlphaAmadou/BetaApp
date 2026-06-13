import 'package:first_app/navigations/nav_controller.dart';
import 'package:flutter/material.dart';

class TabletNavigation extends StatelessWidget {
  final NavController controller;
  final Function(int) onPageChanged;

  const TabletNavigation({
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
                onPageChanged(0);
                Navigator.pop(context);
              }
            ),
            ListTile(
              leading: const Icon(Icons.build),
              title: const Text('Service'), 
              onTap: () {
                onPageChanged(1);
                Navigator.pop(context);
              }
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'), 
              onTap: () {
                onPageChanged(2);
                Navigator.pop(context);
              }
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'), 
              onTap: () {
                onPageChanged(2);
                Navigator.pop(context);
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