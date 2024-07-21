import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobapp/model/request/bookmarkrequst.dart';
import 'package:jobapp/model/response/allbookmark.dart';
import 'package:jobapp/service/helper/bookmarkHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkmarkNotifier extends ChangeNotifier {
  Future<List<AllbookMark>>? bookmarklist;
  List<String> _jobs = [];
  List<String> get jobs => _jobs;
  set jobs(List<String> newlist) {
    _jobs = newlist;
    notifyListeners();
  }

  Future<void> addjobs(String jobId) async {
    final prefs = await SharedPreferences.getInstance();
    if (_jobs .isNotEmpty) {
      _jobs.insert(0, jobId);
      prefs.setStringList("jobId", jobs);
      notifyListeners();
    }
  }

  Future<void> removejobs(String jobId) async {
    final prefs = await SharedPreferences.getInstance();
    if (_jobs.isNotEmpty) {
      _jobs.remove(jobId);
      prefs.setStringList("jobId", jobs);
      notifyListeners();
    }
  }

  Future<void> loadjob() async {
    final pref = await SharedPreferences.getInstance();
    final jobs = pref.getStringList("jobId");
    if (jobs !.isNotEmpty) {
      _jobs = jobs;
      notifyListeners();
    }
  }

  Addbokmark(Bookmarkrequest model, String jobId) {
    BookmarkHelper.getuser(model).then((response) {
      if (response[0]) {
        addjobs(jobId);
        Get.snackbar(
            'succesfull add bookmark', "your are successfull add book mark",
            snackPosition:
                SnackPosition.TOP, // Optional: Set position (default is BOTTOM)
            backgroundColor: Colors.blue, // Optional: Set background color
            duration: Duration(seconds: 2));
      } else {
        Get.snackbar('Failed add bookmark', "Failed add bookmark",
            snackPosition:
                SnackPosition.TOP, // Optional: Set position (default is BOTTOM)
            backgroundColor: Color.fromRGBO(
                243, 33, 33, 1), // Optional: Set background color
            duration: Duration(seconds: 2));
      }
    });
  }

  Deletebokmark(String jobId) {
    BookmarkHelper.deletebookmark(jobId).then((response) {
      if (response) {
        removejobs(jobId);
        Get.snackbar('succesfull Delete bookmark',
            "your are successfull delete book mark",
            snackPosition:
                SnackPosition.TOP, // Optional: Set position (default is BOTTOM)
            backgroundColor: Colors.blue, // Optional: Set background color
            duration: Duration(seconds: 2));
      } else {
        Get.snackbar('Failed Delete bookmark', "Failed Delete bookmark",
            snackPosition:
                SnackPosition.TOP, // Optional: Set position (default is BOTTOM)
            backgroundColor: Color.fromRGBO(
                243, 33, 33, 1), // Optional: Set background color
            duration: Duration(seconds: 2));
      }
    });
  }

  getbookmarks() async {
  bookmarklist=  BookmarkHelper.getJobs();
  }
}
