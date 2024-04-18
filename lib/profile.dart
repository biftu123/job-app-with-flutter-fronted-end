import 'package:flutter/material.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jobapp/controller/profileNotifir.dart';
import 'package:jobapp/model/request/profilres.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
          ),
        ),
        body: Consumer<profilenotifir>(
          builder: (context, profilenotifir, child) {
            profilenotifir.getuser();
            return FutureBuilder<ProfileRes>(
                future: profilenotifir.profile,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('error occur${snapshot.error}');
                  } else {
                    final userdata = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView(
                          children: [
                            Container(
                              color: const Color.fromARGB(255, 173, 179, 185),
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                          userdata!.profile)),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
                                      Text(
                                        userdata.username,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.add_location_alt_rounded,
                                            size: 15,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            userdata.location,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 60,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Icon(Icons.edit),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Column(
                              children: [
                                Container(
                                  color:
                                      const Color.fromARGB(255, 173, 179, 185),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.file_open,
                                        size: 28,
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'resume jobhub',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            'job',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {},
                                        child: const Text("Edit"),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  color:
                                      const Color.fromARGB(255, 173, 179, 185),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child:  Text(
                                      userdata.email,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  color:
                                      const Color.fromARGB(255, 173, 179, 185),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child:  Text(
                                      userdata.phonenumber,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  color:
                                      const Color.fromARGB(255, 173, 179, 185),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'Skills',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  color:
                                      const Color.fromARGB(255, 173, 179, 185),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  child: ListView.builder(
                                    itemCount: userdata.skill.length,
                                    itemBuilder: (context, index) {
                                      final req = userdata.skill[index];
                                      return Card(
                                        child: ListTile(
                                          title: Text(req),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                });
          },
        ));
  }
}
