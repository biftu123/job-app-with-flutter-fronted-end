import 'package:http/http.dart' as http;
import 'package:jobapp/model/response/getjobres.dart';
import 'package:jobapp/model/response/jobresponsemodel.dart';

class JobHelper {
  static Future<List<JobResponse>> getJobs() async {
    final client = http.Client();
    final requestHeaders = {'content-type': 'application/json'};

    final response = await client.get(
      Uri.parse(
          "http://192.168.103.23:4006/job"), // Replace with your API endpoint
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final responseBody = response.body;
      var joblist = jobResponseFromJson(responseBody);
      return joblist;
    } else {
      throw Exception('faild get job');
    }
  }

  static Future<Getjobres> getJob(String jobId) async {
    final client = http.Client();
    final requestHeaders = {'content-type': 'application/json'};

    try {
      final response = await client.get(
        Uri.parse('http://192.168.103.23:4006/job/${jobId}'),
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        print(responseBody); // For debugging purposes, remove in production
        if (responseBody.isNotEmpty) {
          return getjobresFromJson(responseBody);
        } else {
          final errorMessage = 'Failed to get job: Empty response body';
          print(errorMessage); // Write error message to console log
          throw Exception('Failed to get job: Empty response body');
        }
      } else {
        // Handle unsuccessful response
        final errorMessage = 'Failed to get job: ${response.statusCode}';
        print(errorMessage); // Write error message to console log
        throw Exception('Failed to get job: ${response.statusCode}');
      }
    } catch (error) {
      // Handle potential errors from the http package
      final errorMessage = 'Failed to get job: $error';
      print(errorMessage); // Write error message to console log
      throw Exception('Failed to get user profile: $error');
    } finally {
      client.close();
    }
  }
}
