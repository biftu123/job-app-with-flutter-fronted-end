import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:jobapp/controller/profileNotifir.dart';
import 'package:jobapp/update_profile.dart';

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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                    radius: 55,
                                    backgroundImage:
                                        NetworkImage(userdata!.profile)),
                                Column(
                                  children: [
                                    Text(
                                      userdata.username,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(userdata.email,
                                        style: TextStyle(fontSize: 15))
                                  ],
                                  
                                ),
                                Expanded(child: TextButton.icon(onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UpdateProfile(skill: userdata.skill)));
                                }, icon: Icon(Icons.edit,size: 20,), label: Text("Update profile")))
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text('Additional Addresss',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.phone_android_rounded),
                                    Text(userdata.phonenumber),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined),
                                    Text(userdata.location),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text('Professional skills',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
           Container(
                                    height:
                                        MediaQuery.of(context).size.height * 0.4,
                                    child: ListView.builder(
                                        itemCount: userdata.skill.length,
                                        itemBuilder: ((context, index) {
                                          return Container(
                                            height: 40,
                                            child: Card(
                                              child: Text(userdata.skill[index]),
                                            ),
                                          );
                                        })),
                                  ),
                                  
                                
                              ],
                            ),
                          ],
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
