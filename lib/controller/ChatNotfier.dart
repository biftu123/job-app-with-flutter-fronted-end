import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:jobapp/model/response/getChat.dart';


import 'package:jobapp/service/helper/chathelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chatnotfier extends ChangeNotifier {
  late Future<List<Getchat>> chatsList;
 // late Future<List<RecivedMessage>> messageList;
  List<String> _online_user = [];
  bool _typing = false;
  bool get typing => _typing;
  set typingStatus(bool newstatus) {
    _typing = newstatus;
    notifyListeners();
  }

  List<String> get onlineuser => _online_user;
  set(List<String> newlist) {
    _online_user = newlist;
    notifyListeners();
  }

  String? userId;
  getChats() async {
    chatsList = ChatHelper.getconversation();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
  }

  //getmessage(String chatId) async {
   // messageList = MessageHelper.getMessage(chatId);
 // }

  String msgTime(String timestamp) {
    DateTime now = DateTime.now();
    DateTime messageTime = DateTime.parse(timestamp);
    if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day == messageTime.day) {
      return DateFormat.Hm().format(messageTime);
    } else if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day - messageTime.day == 1) {
      return "Yesterday";
    } else {
      return DateFormat.yMd().format(messageTime);
    }
  }
}
