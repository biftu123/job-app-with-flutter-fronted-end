import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jobapp/controller/profileNotifir.dart';

import 'package:provider/provider.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
   void initState() {
    super.initState();
    // Call the getuser() method here to fetch the user data
    Provider.of<Profilenotifir>(context, listen: false).getuser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
        ),
      ),
      body: Consumer<Profilenotifir>(
        builder: (context, Profilenotifir, child) {
          Profilenotifir.getuser();
          return FutureBuilder(
              future: Profilenotifir.profile,
              builder: (context, snapshopt) {
                if (snapshopt.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshopt.hasError) {
                  return Text('error');
                } else {
                  var userdata = snapshopt.data;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                         CircleAvatar(
                                backgroundImage: NetworkImage(userdata!.profile),
                              )
                           
                      ],
                    ),
                  );
                }
              });
        },
      ),
    );
  }
}
