import 'package:flutter/material.dart';

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

    userlogin(BuildContext context, Login model) {
    AuthHelper.login(model).then((response) {
      if (response && firsttime) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ProfileDetails()),
        );
      } else if (response && !firsttime) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const mainScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed'),
            key: const Key('login_failed_snackbar'), // Add a unique key
          ),
        );
      }
    });
  }

  
  updateuser(BuildContext context, UserupdaterequstModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    print(userId);
    if (userId != null) {
      AuthHelper.updateuser(model, ).then((response) {
        if (response) {
         
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const mainScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('update failed'),
              key: const Key('update_failed_snackbar'), // Add a unique key
            ),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User ID not found'),
          key: const Key('user_id_not_found_snackbar'), // Add a unique key
        ),
      );
    }
  }

   upskill(BuildContext context, Upskill model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    print(userId);
    if (userId != null) {
      AuthHelper.updateskill(model).then((response) {
        if (response) {
         
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const mainScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('update failed'),
              key: const Key('update_failed_snackbar'), // Add a unique key
            ),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User ID not found'),
          key: const Key('user_id_not_found_snackbar'), // Add a unique key
        ),
      );
    }
  }


  userlogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.setBool('loggIn', false);
  }
}
