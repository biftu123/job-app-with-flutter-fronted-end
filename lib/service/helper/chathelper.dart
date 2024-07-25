import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobapp/model/request/requstforinitmessage.dart';
import 'package:jobapp/model/response/getChat.dart';
import 'package:jobapp/model/response/resposeforinitmessage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatHelper {
  static Future<List<Getchat>> getConversation() async {
    final client = http.Client();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      // Handle missing token (e.g., return empty list, show error message)
      print('Error: Missing token for getting conversations.');
      return [];
    }

    final requestHeaders = {
      'content-type': 'application/json',
      'token': 'job $token',
    };

    try {
      final response = await client.get(
        Uri.parse("http://192.168.100.4:3001/chat"), // Replace with your API endpoint
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final chats = getchatFromJson(response.body);
        return chats;
      } else {
        throw ChatException('Failed to get chats (status code: ${response.statusCode})');
      }
    } catch (error) {
      throw ChatException('An error occurred while getting chats: $error');
    } finally {
      client.close();
    }
  }

  static Future<List<dynamic>> applyChat(Requstforsinitmessage model) async {
    final client = http.Client();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      // Handle missing token (e.g., return error, show message)
      print('Error: Missing token for applying chat.');
      return [false, 'Missing token'];
    }

    final requestHeaders = {
      'content-type': 'application/json',
      'token': 'job $token',
    };

    try {
      final response = await client.post(
        Uri.parse("http://192.168.100.4:3001/chat/biftu"), // Replace with your API endpoint
        headers: requestHeaders,
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        
        final bookmarkId = responseforsinitmessageFromJson(response.body).id;
        return [true, bookmarkId];
      } else {
        return [false, 'Failed to apply chat (status code: ${response.statusCode})'];
      }
    } catch (error) {
      throw ChatException('Error applying chat: $error');
    } finally {
      client.close();
    }
  }
}

// Custom exception for ChatHelper errors
class ChatException implements Exception {
  final String message;

  ChatException(this.message);

  @override
  String toString() => message;
}
