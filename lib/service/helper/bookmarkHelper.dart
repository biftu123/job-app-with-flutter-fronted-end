import 'dart:convert';

import 'package:jobapp/model/request/bookmarkrequst.dart';
import 'package:jobapp/model/response/allbookmark.dart';
import 'package:jobapp/model/response/bookmarkresponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BookmarkHelper {
  static Future<List<dynamic>> getuser(Bookmarkrequest model) async {
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
          Uri.parse("http://192.168.100.4:3001/bookmark/create"),
          headers: requestHeaders,
          body: jsonEncode(model.toJson()));

      if (response.statusCode == 200) {
        var bookmarkId = bookmarkresponseFromJson(response.body).id;
        return [true, bookmarkId];
      } else {
        return [false];
      }
    } catch (error) {
      // Handle potent
      throw Exception('Failed to get user profile: $error');
    } finally {
      client.close();
    }
  }

  static Future<bool> deletebookmark(String jobId) async {
    final client = http.Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // ignore: unnecessary_brace_in_string_interps
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
      'token': 'job $token'
    };

    try {
      var response = await client.delete(
          Uri.parse("http://192.168.100.4:3001/bookmark/${jobId}"),
          headers: requestHeaders);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      // Handle potential errors from the http package
      throw Exception('Failed to get user profile: $error');
    } finally {
      client.close();
    }
  }

  static Future<List<Allbookmark>> getJobs() async {
    final client = http.Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final requestHeaders = {
      'content-type': 'application/json',
      'token': 'job $token'
    };

    final response = await client.get(
      Uri.parse(
          "http://192.168.100.4:3001/bookmark"), // Replace with your API endpoint
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final responseBody = response.body;
      var bookmarklist = allbookmarkFromJson(responseBody);
      return bookmarklist;
    } else {
      throw Exception('faild get bookmark');
      
    }
  }
}
