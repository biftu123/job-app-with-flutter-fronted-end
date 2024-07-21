import 'dart:convert';

import 'package:jobapp/model/request/requstforinitmessage.dart';
import 'package:jobapp/model/response/getChat.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChatHelper {
  static Future<List<Getchat>> getconversation() async {
    final client = http.Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final requestHeaders = {
      'content-type': 'application/json',
      'token': 'job $token'
    };

    try {
      final response = await client.get(
        Uri.parse(
            "http://192.168.100.4:3001/chat"), // Replace with your API endpoint
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var chats = getchatFromJson(response.body);
        
        return chats;
      } else {
        throw Exception('Failed to get chats');
      }
    } catch (e) {
      throw Exception('An error occurred while getting chats: $e');
    } finally {
      client.close();
    }
  }
   static Future<List<dynamic>> applychat(Requstforsinitmessage model) async {
    final client = http.Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // ignore: unnecessary_brace_in_string_interps
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
      'token': 'job $token'
    };

    try {
      var response = await client.post(
          Uri.parse("http://192.168.100.4:3001/chat/biftu"),
          headers: requestHeaders,
          body: jsonEncode(model.toJson()));

      if (response.statusCode == 200) {
        var bookmarkId = requstforsinitmessageFromJson(response.body).id;
        return [true, bookmarkId];
      } else {
        return [false];
      }
    } catch (error) {
      // Handle potential errors from the http package
      throw Exception('Failed to get user profile: $error');
    } finally {
      client.close();
    }
  }

 
}
