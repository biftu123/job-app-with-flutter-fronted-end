import 'package:flutter/material.dart';
import 'package:jobapp/model/request/profilres.dart';

import 'package:jobapp/service/helper/authhelper.dart';

class profilenotifir extends ChangeNotifier {
   Future<ProfileRes>? profile;
  getuser() {
    profile = AuthHelper.getuser();
  }
}
