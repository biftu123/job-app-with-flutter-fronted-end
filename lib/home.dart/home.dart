import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:jobapp/controller/jobNotifire.dart';
import 'package:jobapp/controller/profileNotifir.dart';
import 'package:jobapp/controller/verticalTile.dart';
import 'package:jobapp/home.dart/heading.dart';
import 'package:jobapp/home.dart/jobholding.dart';
import 'package:jobapp/home.dart/searchwidget.dart';
import 'package:jobapp/home.dart/viewalljob.dart';
import 'package:jobapp/job.dart';

import 'package:jobapp/search.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Consumer<Profilenotifir>(
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
                      return Column(
                        children: [ CircleAvatar(
                          backgroundImage: NetworkImage(userdata!.profile),
                          radius: 18,
                        ),
                        Expanded(child: Text(userdata.username))
                        ]
                      );
                    }
                  });
            }),
          ),
        ],
      ),
      body: Consumer<jobNotifier>(
        builder: (context, jobNotifier, child) {
          jobNotifier.jobget();
          jobNotifier.recentjob();
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Search \n Find & Apply",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SearchWidget(
                      onTap: () {
                        Get.to(() => search());
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    heading(
                      text: 'Popular jobs',
                      OnTap: () {
                        Get.to(() => ViewAllJob());
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.34,
                      child: FutureBuilder(
                        future: jobNotifier.joblist,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            print('${snapshot.error}');
                            return Text("Error: ${snapshot.error}");
                          } else {
                            var jobs = snapshot.data;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: jobs!.length,
                              itemBuilder: (context, index) {
                                final jobt = jobs[index];
                                return JobHolding(
                                  onTap: () {
                                    Get.to(() =>
                                        job(title: jobt.company, id: jobt.id));
                                  },
                                  job: jobt,
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                    heading(
                      text: 'Recent jobs',
                      OnTap: () {},
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: FutureBuilder(
                        future: jobNotifier.recent,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            var recents = snapshot.data;
                            return Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  child: verticaltile(
                                    onTap: () {
                                      Get.to(() => job(
                                          title: recents!.company,
                                          id: recents.id));
                                    },
                                    job: recents,
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
