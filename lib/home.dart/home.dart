import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jobapp/controller/verticalTile.dart';
import 'package:jobapp/home.dart/heading.dart';
import 'package:jobapp/home.dart/jobholding.dart';
import 'package:jobapp/home.dart/searchwidget.dart';
import 'package:jobapp/job.dart';
import 'package:jobapp/search.dart';

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
            child: CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage('assets/images/page1.jpg'),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Search \n Find & Apply",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              SearchWidget(onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => search()));
              }),
              SizedBox(
                height: 10,
              ),
              heading(
                text: 'Popular jobs',
                OnTap: () {},
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return JobHolding(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  job(title: "Facebook", id: "m")));
                        },
                      );
                    }),
              ),
              heading(
                text: 'Recent jobs',
                OnTap: () {},
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return verticaltile(
                        onTap: () {},
                      );
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
