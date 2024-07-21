import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobapp/model/request/requstForSendMessege.dart';
import 'package:jobapp/model/response/RecivedMessage.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MessageHelper {
  static Future<List<RecivedMessage>> getMessage(String chatId,int offset) async {
    final client = http.Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final requestHeaders = {
      'content-type': 'application/json',
      'token': 'job $token'
    };

    try {
      final response = await client.get(
        Uri.parse("http://192.168.100.4:3001/message/$chatId?page=${offset.toString()}"),
             // Replace with your API endpoint
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var messages = recivedMessageFromJson(response.body);

        return messages;
      } else {
        throw Exception('Failed to get chats');
      }
    } catch (e) {
      throw Exception('An error occurred while getting chats: $e');
    } finally {
      client.close();
    }
  }

  static Future<List<dynamic>> applychat(RequestForSendMessege model) async {
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
          Uri.parse("http://192.168.100.4:3001/message/sendmessage"),
          headers: requestHeaders,
          body: jsonEncode(model.toJson()));

      if (response.statusCode == 200) {
        RecivedMessage message =
            RecivedMessage.fromJson(jsonDecode(response.body));
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        return [true, message, responseMap];
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
