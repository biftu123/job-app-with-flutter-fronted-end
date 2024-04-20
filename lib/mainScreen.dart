// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:jobapp/chat.dart';
import 'package:jobapp/devicemanager.dart';
import 'package:jobapp/drawer/ZoomNotifier.dart';
import 'package:jobapp/drawer/drawerScreen.dart';
import 'package:jobapp/home.dart/home.dart';
import 'package:jobapp/profile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(builder: (context, ZoomNotifier, child) {
      return ZoomDrawer(
        menuScreen: drawerScreen(indexSetter: (index) {
          ZoomNotifier.currentIndex = index;
        }),
        mainScreen: currentScreen(),
        borderRadius: 10,
        angle: 0.0,
        slideWidth: 250.0,
        showShadow: true,
      );
    });
  }

  Widget currentScreen() {
    var zoomnotifirer = Provider.of<ZoomNotifier>(context);
    switch (zoomnotifirer.currentIndex) {
      case 0:
        return const Home();
        break;
      case 1:
        return const chat();
        break;
      case 2:
        return const Home();
        break;
      case 3:
        return const deviceManager();
        break;
      case 4:
        return const profile();
        break;
      default:
        return const Home();
    }
  }
}
