import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jobapp/drawer/ZoomNotifier.dart';
import 'package:provider/provider.dart';

class drawerScreen extends StatefulWidget {
  final ValueSetter indexSetter;
  const drawerScreen({super.key, required this.indexSetter});

  @override
  State<drawerScreen> createState() => _drawerScreenState();
}

class _drawerScreenState extends State<drawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(builder: (contex, ZoomNotifier, child) {
      return GestureDetector(
        onDoubleTap: () {
          ZoomDrawer.of(context)!.toggle();
        },
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              drawerItem(
                  Icons.home,
                  " home",
                  0,
                  ZoomNotifier.currentIndex == 0
                      ? const Color.fromARGB(255, 187, 8, 8)
                      : Colors.grey),
              drawerItem(
                  Icons.message_rounded,
                  " chat",
                  1,
                  ZoomNotifier.currentIndex == 1
                      ? const Color.fromARGB(255, 187, 8, 8)
                      : Colors.grey),
              drawerItem(
                  Icons.bookmark_add_rounded,
                  " bookmark",
                  2,
                  ZoomNotifier.currentIndex == 2
                      ? const Color.fromARGB(255, 187, 8, 8)
                      : Colors.grey),
              drawerItem(
                  Icons.device_hub_rounded,
                  " device manager",
                  3,
                  ZoomNotifier.currentIndex == 3
                      ? const Color.fromARGB(255, 187, 8, 8)
                      : Colors.grey),
              drawerItem(
                  Icons.man_3_rounded,
                  " profile",
                  4,
                  ZoomNotifier.currentIndex == 4
                      ? const Color.fromARGB(255, 187, 8, 8)
                      : Colors.grey)
            ],
          ),
        ),
      );
    });
  }

  Widget drawerItem(IconData icon, String text, int index, Color color) {
    return GestureDetector(
      onTap: () {
        widget.indexSetter(index);

        // Update the current index in the ZoomNotifier
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w400, color: color),
            )
          ],
        ),
      ),
    );
  }
}
