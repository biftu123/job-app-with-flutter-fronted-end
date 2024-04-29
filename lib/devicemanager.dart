import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jobapp/controller/logInNotifier.dart';
import 'package:jobapp/controller/onbordnotifier.dart';

import 'package:jobapp/deviceInfo.dart';

import 'package:provider/provider.dart';

class deviceManager extends StatefulWidget {
  const deviceManager({super.key});

  @override
  State<deviceManager> createState() => _deviceManagerState();
}

class _deviceManagerState extends State<deviceManager> {
  String hellow = DateTime.now().toString().substring(0, 11);

  @override
  Widget build(BuildContext context) {
    Provider.of<OnbordNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('chat page'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Text("you are logged in your acccount on these devices",
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                SizedBox(
                  height: 30,
                ),
                deviceInfo(
                    date: hellow,
                    Ipaddress: '10:10:171',
                    platform: 'mobile app',
                    device: 'Samsung m 14',
                    location: "addis abeba")
              ],
            ),
          ),
          Consumer<logInNotfier>(builder: (context, logInNotfier, child) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  logInNotfier.userlogout();
                },
                child: Text(
                  "Sign Out from all device",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            );
          })
        ],
      )),
    );
  }
}
