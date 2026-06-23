import 'package:first_app/navigations/app_router.dart';
import 'package:first_app/navigations/nav_responsive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class MobileNavigation extends StatelessWidget{

  final int index;
  final Widget child;
  final Function(int) onTap;

  const MobileNavigation({
    super.key,
    required this.index,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        title: Text(
          NavMenu.titles[index].toUpperCase(), 
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [  
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => context.push(AppRoutes.profile),
            ),
          )
        ],
      ),
      //body: NavMenu.pages[index],
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        currentIndex: index,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Service'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting'),
        ],
      ),
    );
  }
}
