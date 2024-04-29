import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobapp/controller/jobNotifire.dart';
import 'package:jobapp/controller/verticalTile.dart';
import 'package:jobapp/job.dart';

import 'package:provider/provider.dart';

class ViewAllJob extends StatelessWidget {
  const ViewAllJob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs"),
        centerTitle: true,
        leading:IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all( 20),
        child: Consumer<jobNotifier>(
          builder: (context, jobNotifier, child) {
            jobNotifier.jobget();
            return FutureBuilder(
              future: jobNotifier.joblist,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  print('${snapshot.error}');
                  return Text("Error: ${snapshot.error}");
                } else {
                  var jobs = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: jobs!.length,
                    itemBuilder: (context, index) {
                      final jobt = jobs[index];
                      return verticaltile(
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
            );
          },
        ),
      ),
    );
  }
}