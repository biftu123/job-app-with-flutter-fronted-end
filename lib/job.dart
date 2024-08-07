// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobapp/controller/bookmarknotifier.dart';

import 'package:jobapp/controller/jobNotifire.dart';
import 'package:jobapp/home.dart/home.dart';

import 'package:jobapp/model/request/bookmarkrequst.dart';
import 'package:jobapp/model/request/requstForSendMessege.dart';
import 'package:jobapp/model/request/requstforinitmessage.dart';
import 'package:jobapp/service/helper/MessageHelper.dart';
import 'package:jobapp/service/helper/chathelper.dart';

import 'package:provider/provider.dart';

class job extends StatefulWidget {
  const job({
    Key? key,
    required this.title,
    required this.id,
  }) : super(key: key);
  final String title;
  final String id;

  @override
  State<job> createState() => _jobState();
}

class _jobState extends State<job> {
  @override
  Widget build(BuildContext context) {
    return Consumer<jobNotifier>(
      builder: (context, jobNotifier, child) {
        jobNotifier.jobgets(widget.id);
        return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Get.back(),
              ),
              actions: [
                Consumer<BookmarkmarkNotifier>(
                  builder: (context, bookmarkmarkNotifier, child) {
                    bookmarkmarkNotifier.loadjob();
                    return GestureDetector(
                        onTap: () {
                          if (bookmarkmarkNotifier.jobs.contains(widget.id)) {
                            bookmarkmarkNotifier.Deletebokmark(widget.id);
                          } else {
                            Bookmarkrequest model =
                                Bookmarkrequest(job: widget.id);
                            bookmarkmarkNotifier.Addbokmark(model, widget.id);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: !bookmarkmarkNotifier.jobs.contains(widget.id)
                              ? Icon(Icons.bookmark_add_outlined)
                              : Icon(Icons.bookmark_remove_outlined),
                        ));
                  },
                )
              ],
            ),
            body: FutureBuilder(
                future: jobNotifier.job,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("error ocured ${snapshot.error}");
                  } else {
                    var jobd = snapshot.data;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        children: [
                          ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.30,
                                color: Color.fromARGB(255, 134, 133, 129),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(jobd!.imageUrl),
                                        radius: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      jobd.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      jobd.location,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 70,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          jobd.period,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.24,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              jobd.salary,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              jobd.contract,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Job descrption",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                jobd.title,
                                maxLines: 8,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Job Requirements",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: ListView.builder(
                                    itemCount: jobd.requirments.length,
                                    itemBuilder: (context, index) {
                                      final req = jobd.requirments[index];

                                      return Text(
                                        "$req",
                                        maxLines: 8,
                                        textAlign: TextAlign.justify,
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: TextButton(
                                onPressed: () {
                                  Requstforsinitmessage model =
                                      Requstforsinitmessage(id: jobd.AgentId);
                                  ChatHelper.applyChat(model).then((response) {
                                    if (response[0]) {
                                      RequestForSendMessege model =
                                          RequestForSendMessege(
                                              chatId: response[1],
                                              content:
                                                  "went to apply to this job",
                                              receiver: jobd.AgentId);
                                      MessageHelper.applychat(model)
                                          .whenComplete(() {
                                        Get.to(Home());
                                      });
                                    }
                                  });
                                },
                                child: Text("Apply For")),
                          )
                        ],
                      ),
                    );
                  }
                }));
      },
    );
  }
}
