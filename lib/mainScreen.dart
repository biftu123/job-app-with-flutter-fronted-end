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
  const mainScreen({Key? key}) : super(key: key);

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(
      builder: (context, zoomNotifier, child) {
        return ZoomDrawer(
          menuScreen: drawerScreen(indexSetter: (index) {
            zoomNotifier.currentIndex = index;
          }),
          mainScreen: currentScreen(),
          borderRadius: 10,
          angle: 0.0,
          slideWidth:250,
          showShadow: true,
        );
      },
    );
  }

  Widget currentScreen() {
    final zoomNotifier = Provider.of<ZoomNotifier>(context );
    switch (zoomNotifier.currentIndex) {
      case 0:
        return const Home();
      case 1:
        return const chat();
      case 2:
        return const Home(); // Consider a different screen for index 2
      case 3:
        return const deviceManager();
      case 4:
        return const profile();
      default:
        return const Home();
    }
  }
}
