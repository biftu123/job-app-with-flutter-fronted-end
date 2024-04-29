import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobapp/logIn.dart';

import 'package:jobapp/model/request/signuprequstmodel.dart';
import 'package:jobapp/service/helper/authhelper.dart';

class signUpNotfier extends ChangeNotifier {
  bool _obscureText = true;
  bool get obscureText => _obscureText;
  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  userSignUp( Signupmodel model) {
    AuthHelper.SignUp(model).then((response) => {
      if(response){
         Get.snackbar('succeslogin', "your are successfull login",
            snackPosition:
                SnackPosition.TOP, // Optional: Set position (default is BOTTOM)
            backgroundColor: Colors.blue, // Optional: Set background color
            duration: Duration(seconds: 2)),
    Get.off(LogIn())
      }else (){
         Get.snackbar('Failedlogin', "your are Failed login",
            snackPosition:
                SnackPosition.TOP, // Optional: Set position (default is BOTTOM)
            backgroundColor: Color.fromRGBO(
                243, 33, 33, 1), // Optional: Set background color
            duration: Duration(seconds: 2));
 
      }
    });
  }
}
