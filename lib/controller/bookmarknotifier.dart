import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobapp/model/request/bookmarkrequst.dart';
import 'package:jobapp/model/response/allbookmark.dart';
import 'package:jobapp/service/helper/bookmarkHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkmarkNotifier extends ChangeNotifier {
  Future<List<Allbookmark>>? bookmarklist;
  List<String> _jobs = [];
  List<String> get jobs => _jobs;
  set jobs(List<String> newlist) {
    _jobs = newlist;
    notifyListeners();
  }

  Future<void> addjobs(String jobId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_jobs.isNotEmpty) {
        _jobs.insert(0, jobId);
        prefs.setStringList("jobId", jobs);
        notifyListeners();
      }
    } catch (error) {
      // Handle any errors that occurred during adding jobs
      print('Error: $error');
    }
  }

  Future<void> removejobs(String jobId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_jobs.isNotEmpty) {
        _jobs.remove(jobId);
        prefs.setStringList("jobId", jobs);
        notifyListeners();
      }
    } catch (error) {
      // Handle any errors that occurred during removing jobs
      print('Error: $error');
    }
  }

  Future<void> loadjob() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final jobs = pref.getStringList("jobId");
      if (jobs != null && jobs.isNotEmpty) {
        _jobs = jobs;
        notifyListeners();
      }
    } catch (error) {
      // Handle any errors that occurred during loading jobs
      print('Error: $error');
    }
  }

 Addbokmark(Bookmarkrequest model, String jobId) {
  BookmarkHelper.getuser(model).then((response) {
    if ( response[0]) {
      addjobs(jobId);
      Get.snackbar(
        'Successful add bookmark',
        "You have successfully added a bookmark",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        'Failed add bookmark',
        "Failed to add bookmark",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color.fromRGBO(233, 162, 162, 1),
        duration: Duration(seconds: 2),
      );
    }
  });
}
        

  Deletebokmark(String jobId) {
    BookmarkHelper.deletebookmark(jobId).then((response) {
      try {
        if (response) {
          removejobs(jobId);
          Get.snackbar(
            'Successful delete bookmark',
            "You have successfully deleted a bookmark",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.blue,
            duration: Duration(seconds: 2),
          );
        } else {
          Get.snackbar(
            'Failed delete bookmark',
            "Failed to delete bookmark",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Color.fromRGBO(243, 33, 33, 1),
            duration: Duration(seconds: 2),
          );
        }
      } catch (error) {
        // Handle any errors that occurred during deleting bookmark
        print('Error: $error');
      }
    });
  }

  getbookmarks() async {
    try {
      bookmarklist = BookmarkHelper.getJobs();
    } catch (error) {
      // Handle any errors that occurred during getting bookmarks
      print('Error: $error');
    }
  }
}