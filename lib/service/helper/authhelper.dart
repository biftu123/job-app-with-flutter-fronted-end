// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobapp/model/request/loginrequst.dart';
import 'package:jobapp/model/request/profilres.dart';

import 'package:jobapp/model/request/signuprequstmodel.dart';
import 'package:jobapp/model/request/upskill.dart';
import 'package:jobapp/model/request/userupdaterequstmodel.dart';
import 'package:jobapp/model/response/loginresonsemodel.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static Future<bool> login(Login model) async {
    final client = http.Client(); // Create an HTTP client instance
    Map<String, String> requestHeaders = {'content-type': 'application/json'};

    try {
      var response = await client.post(
          Uri.parse("http://192.168.97.23:4006/login"),
          body: jsonEncode(model),
          headers: requestHeaders);

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = loginresposemodelFromJson(response.body).token;
        String userId = loginresposemodelFromJson(response.body).id;
        String profile = loginresposemodelFromJson(response.body).profile;
        await prefs.setString("token", token);
        await prefs.setString("userId", userId);
        await prefs.setString("profile", profile);
        await prefs.setBool("loggIn", true);
        return true;
      } else {
        // Handle unsuccessful response (e.g., print error message)
        print("Login failed: Status code ${response.statusCode}");
        print(Error());
        return false;
      }
    } catch (error) {
      // Handle potential errors from the http package
      print("Error during login: $error");
      return false;
    } finally {
      client.close(); // Close the client when done to avoid resource leaks
    }
  }

  static Future<bool> updateuser(UserupdaterequstModel model) async {
    final client = http.Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // ignore: unnecessary_brace_in_string_interps
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
      'token': 'job $token'
    };

    try {
      var response = await client.put(
        Uri.parse("http://192.168.97.23:4006/users/update/"),
        body: jsonEncode(model),
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        // Handle unsuccessful response (e.g., print error message)
        print("Update failed: Status code ${response.statusCode}");
        return false;
      }
    } catch (error) {
      // Handle potential errors from the http package
      print("Error during update: $error");
      return false;
    } finally {
      client.close();
    }
  }

  static Future<ProfileRes> getuser() async {
    final client = http.Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // ignore: unnecessary_brace_in_string_interps
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
      'token': 'job $token'
    };

    try {
      var response = await client.get(
        Uri.parse("http://192.168.97.23:4006/users/getuser/"),
        
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var responseBody = response.body;
        if (responseBody.isNotEmpty) {
          var profile = profileResFromJson(responseBody);
          return profile;
        } else {
          throw Exception('Failed to get user profile: Empty response body');
        }
      } else {
        // Handle unsuccessful response (e.g., print error message)
        throw Exception('Failed to get user profile: ${response.statusCode}');
      }
    } catch (error) {
      // Handle potential errors from the http package
      throw Exception('Failed to get user profile: $error');
    } finally {
      client.close();
    }
  }

  // ignore: non_constant_identifier_names
  static Future<bool> SignUp(Signupmodel model) async {
    final client = http.Client(); // Create an HTTP client instance
    Map<String, String> requestHeaders = {'content-type': 'application/json'};

    try {
      var response = await client.post(
          Uri.parse("http://192.168.97.23:4006/register"),
          body: jsonEncode(model),
          headers: requestHeaders);

      if (response.statusCode == 200) {
        return true;
      } else {
        // Handle unsuccessful response (e.g., print error message)
        print("Login failed: Status code ${response.statusCode}");
        return false;
      }
    } catch (error) {
      // Handle potential errors from the http package
      print("Error during login: $error");
      return false;
    } finally {
      client.close(); // Close the client when done to avoid resource leaks
    }
  }

  static Future<bool> updateskill(Upskill model) async {
    final client = http.Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // ignore: unnecessary_brace_in_string_interps
    Map<String, String> requestHeaders = {
      'content-type': 'application/json',
      'token': 'job $token'
    };

    try {
      var response = await client.put(
        Uri.parse("http://192.168.97.23:4006/users/update/"),
        body: jsonEncode(model),
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        // Handle unsuccessful response (e.g., print error message)
        print("Update failed: Status code ${response.statusCode}");
        return false;
      }
    } catch (error) {
      // Handle potential errors from the http package
      print("Error during update: $error");
      return false;
    } finally {
      client.close();
    }
  }
}
