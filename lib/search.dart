import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobapp/bifa.dart';
import 'package:jobapp/controller/verticalTile.dart';
import 'package:jobapp/job.dart';
import 'package:jobapp/model/response/jobresponsemodel.dart';
import 'package:jobapp/service/helper/jobhelper%20.dart';


class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  TextEditingController search = TextEditingController();
  Future<List<JobResponse>>? searchFuture;

  void performSearch() {
    String searchText = search.text.trim();
    if (searchText.isNotEmpty) {
      setState(() {
        searchFuture = JobHelper.searchjob(searchText);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: TextField(
          controller: search,
          decoration: InputDecoration(
            hintText: "Search here job",
            suffixIcon: GestureDetector(
              onTap: performSearch,
              child: Icon(Icons.search),
            ),
          ),
        ),
         leading:IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: search.text.isNotEmpty
            ? FutureBuilder<List<JobResponse>>(
                future: searchFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    var jobs = snapshot.data;
                    if (jobs!.isEmpty) {
                      return Bifa(text: "Job not found");
                    } else {
                      return ListView.builder(
                        itemCount: jobs.length,
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
                  } else {
                    return Bifa(text: "No data available");
                  }
                },
              )
            : Bifa(text: "Start searching jobs"),
      ),
    );
  }
}