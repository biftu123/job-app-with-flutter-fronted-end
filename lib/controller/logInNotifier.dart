import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jobapp/mainScreen.dart';
import 'package:jobapp/model/request/loginrequst.dart';
import 'package:jobapp/model/request/upskill.dart';
import 'package:jobapp/model/request/userupdaterequstmodel.dart';

import 'package:jobapp/profileDetails.dart';
import 'package:jobapp/service/helper/authhelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class logInNotfier extends ChangeNotifier {
  bool _obscureText = true;
  bool get obscureText => _obscureText;
  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _firsttime = true;
  bool get firsttime => _firsttime;
  set firsttime(bool newState) {
    _firsttime = newState;
    notifyListeners();
  }

  userlogin(Login model) {
    AuthHelper.login(model).then((response) {
      if (response && firsttime) {
        Get.snackbar('succeslogin', "your are successfull login",
            snackPosition:
                SnackPosition.TOP, // Optional: Set position (default is BOTTOM)
            backgroundColor: Colors.blue, // Optional: Set background color
            duration: Duration(seconds: 2));
        Get.off(ProfileDetails());
      } else if (response && !firsttime) {
        Get.snackbar('succeslogin', "your are successfull login",
            snackPosition:
                SnackPosition.TOP, // Optional: Set position (default is BOTTOM)
            backgroundColor: Colors.blue, // Optional: Set background color
            duration: Duration(seconds: 2));
        Get.off(mainScreen());
      } else {
        Get.snackbar('Failedlogin', "your are Failed login",
            snackPosition:
                SnackPosition.TOP, // Optional: Set position (default is BOTTOM)
            backgroundColor: Color.fromRGBO(
                243, 33, 33, 1), // Optional: Set background color
            duration: Duration(seconds: 2));
      }
    });
  }

  updateuser(UserupdaterequstModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    print(userId);
    if (userId != null) {
      AuthHelper.updateuser(
        model,
      ).then((response) {
        if (response) {
          Get.snackbar('succesupdate', "your are successfull login",
              snackPosition: SnackPosition
                  .TOP, // Optional: Set position (default is BOTTOM)
              backgroundColor: Colors.blue, // Optional: Set background color
              duration: Duration(seconds: 2));
          Get.off(const mainScreen());
        } else {
          Get.snackbar('Failedupdate', "your are Failed update",
              snackPosition: SnackPosition
                  .TOP, // Optional: Set position (default is BOTTOM)
              backgroundColor: Color.fromRGBO(
                  243, 33, 33, 1), // Optional: Set background color
              duration: Duration(seconds: 2));
        }
      });
    }
  }

  upskill(Upskill model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    
    if (userId != null) {
      AuthHelper.updateskill(model).then((response) {
        if (response) {
          Get.snackbar('succesupdate', "your are successfull login",
              snackPosition: SnackPosition
                  .TOP, // Optional: Set position (default is BOTTOM)
              backgroundColor: Colors.blue, // Optional: Set background color
              duration: Duration(seconds: 2));
          Get.off(const mainScreen());
        } else {
          Get.snackbar('Failedupdate', "your are Failed update",
              snackPosition: SnackPosition
                  .TOP, // Optional: Set position (default is BOTTOM)
              backgroundColor: Color.fromRGBO(
                  243, 33, 33, 1), // Optional: Set background color
              duration: Duration(seconds: 2));
        }
      });
    } else {}
  }

  userlogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.setBool('loggIn', false);
    firsttime = false;
  }
}
