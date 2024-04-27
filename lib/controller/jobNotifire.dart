import 'package:flutter/material.dart';
import 'package:jobapp/model/response/getjobres.dart';
import 'package:jobapp/model/response/jobresponsemodel.dart';
import 'package:jobapp/service/helper/jobhelper%20.dart';

class jobNotifier extends ChangeNotifier {
  Future<List<JobResponse>>? joblist;
  Future<Getjobres>? job;
  jobget() async {
    joblist = JobHelper.getJobs();
  }

  jobgets(String jobId) async {
    job = JobHelper.getJob(jobId);
  }
}
