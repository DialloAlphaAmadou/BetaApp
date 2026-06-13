import 'package:first_app/navigations/desktop_nav.dart';
import 'package:first_app/navigations/mobile_nav.dart';
import 'package:first_app/navigations/nav_controller.dart';
import 'package:first_app/navigations/tablet_nav.dart';
import 'package:flutter/material.dart';

class NavResponsive extends StatefulWidget{

  const NavResponsive({ super.key });

  @override
  State<NavResponsive> createState() => _NavResponsiveSate();
}

class _NavResponsiveSate extends State<NavResponsive>{
  final NavController controller = NavController();

  void onPageChanged(int index){
    setState(() {
      controller.goTo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if(width < 600){
      return MobileNavigation(controller: controller, onPageChanged: onPageChanged);
    }else if(width <1024){
      return TabletNavigation(controller: controller, onPageChanged: onPageChanged);
    }else{
      return DesktopNavigation(controller: controller, onPageChanged: onPageChanged);
    }
  }
}