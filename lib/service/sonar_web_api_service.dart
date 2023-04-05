import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../dashboard/models/login_model.dart';
import '../dashboard/models/web_api_issues_model.dart';
import '../dashboard/utils/constants.dart';

class SonarWebApiService {
  static const String _baseUrl = 'http://sonar.netcad.com:9000/api';
  static const apiKey = Constants.API_KEY;
  final encodedApiKey = base64.encode(utf8.encode(apiKey + ":"));

  Future<LoginModel> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(
          '$_baseUrl/authentication/login?login=$username&password=$password'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return LoginModel(status: true);
    } else {
      throw Exception('Failed to load login');
    }
  }

  Future<ValidModel> getValid() async {
    final response = await http.get(
        Uri.parse('$_baseUrl/authentication/validate'),
        headers: <String, String>{
          "Authorization": "Basic $encodedApiKey",
        });
    if (response.statusCode == 200) {
      return ValidModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load valid');
    }
  }

  Future<int> getIssues(
      String severity, String type, String projectKey, String branch) async {
    final response = await http.get(
        Uri.parse(
            '$_baseUrl/issues/search?severities=$severity&types=$type&componentKeys=$projectKey&branch=$branch'),
        headers: <String, String>{
          "Authorization": "Basic $encodedApiKey",
        });
    if (response.statusCode == 200) {
      return WebApiIssuesModel.fromJson(jsonDecode(response.body)).total!;
    } else {
      throw Exception(
          'Failed to load issues ' + response.statusCode.toString());
    }
  }
}
