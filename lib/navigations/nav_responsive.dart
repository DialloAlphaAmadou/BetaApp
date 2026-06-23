import 'package:first_app/navigations/app_router.dart';
import 'package:first_app/navigations/desktop_nav.dart';
import 'package:first_app/navigations/mobile_nav.dart';
import 'package:first_app/navigations/tablet_nav.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavResponsive extends StatefulWidget{
  final Widget child;
  const NavResponsive({super.key, required this.child});

  @override
  State<NavResponsive> createState() => _NavResponsiveSate();
}

class _NavResponsiveSate extends State<NavResponsive>{

  void onTap(int i){
    context.go(NavMenu.routes[i]);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final location = GoRouterState.of(context).uri.path;
    final index = NavMenu.routes.indexOf(location);

    if(width < 600){
      return MobileNavigation(index: index, onTap: onTap, child: widget.child,);
    }else if(width <1024){
      return TabletNavigation(index: index, onTap: onTap, child: widget.child,);
    }else{
      return DesktopNavigation(index: index, onTap: onTap, child: widget.child,);
    }
  }
}


class NavMenu {

  static const routes = [
    AppRoutes.home,
    AppRoutes.services,
    AppRoutes.settings,
    AppRoutes.profile,
  ];

  static const titles = [
    'Home',
    'Service',
    'Setting',
    'Profile',
  ];

}
