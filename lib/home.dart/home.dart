import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jobapp/controller/jobNotifire.dart';
import 'package:jobapp/controller/verticalTile.dart';
import 'package:jobapp/home.dart/heading.dart';
import 'package:jobapp/home.dart/jobholding.dart';
import 'package:jobapp/home.dart/searchwidget.dart';
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
  void initState() {
      Provider.of<jobNotifier>(context, listen: false).jobget();
    // TODO: implement initState
    super.initState();
  }
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
            child: CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage('assets/images/page1.jpg'),
            ),
          ),
        ],
      ),
      body: Consumer<jobNotifier>(
        builder: (context, jobNotifier, child) {
          jobNotifier.jobget();
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
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>const search()),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    heading(
                      text: 'Popular jobs',
                      OnTap: () {},
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
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => job(
                                          title: jobt.company,
                                          id: jobt.id,
                                        ),
                                      ),
                                    );
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
                      height: MediaQuery.of(context).size.height*0.2,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return verticaltile(
                            onTap: () {},
                          );
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