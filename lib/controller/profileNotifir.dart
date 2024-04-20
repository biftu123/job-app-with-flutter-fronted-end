import 'package:jobapp/model/request/profilres.dart';
import 'package:jobapp/service/helper/authhelper.dart';
import 'package:flutter/material.dart';
class Profilenotifir extends ChangeNotifier {
  Future<ProfileRes>? profile;

 getuser() async {
    profile = AuthHelper.getuser();
    
  }
}