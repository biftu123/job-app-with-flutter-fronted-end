import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:jobapp/bookmarktile.dart';
import 'package:jobapp/controller/bookmarknotifier.dart';
import 'package:jobapp/job.dart';
import 'package:provider/provider.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({Key? key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
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
      ),
      body: Consumer<BookmarkmarkNotifier>(
        builder: (context, bookmarkmarkNotifier, child) {
          bookmarkmarkNotifier.getbookmarks();
          return FutureBuilder(
            future: bookmarkmarkNotifier.bookmarklist,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                print('${snapshot.error}');
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.data!.isEmpty) {
                return Text('no data');
              } else {
                var jobs = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: jobs!.length,
                  itemBuilder: (context, index) {
                    final jobt = jobs[index];
                    
                    print(jobt.job.id); // Handle null case
                    return Bookmarktile(
                      onTap: () {
                        Get.to(() => job(title:jobt.job.company , id: jobt.job.id));
                      },
                      job: jobt,
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
