import 'dart:convert';
import 'package:flutter_sonar_app/dashboard/models/projects_n_branches_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../dashboard/models/analysis_issues.dart';
import '../dashboard/models/analysis_logs.dart';
import '../dashboard/models/issues_model.dart';
import '../dashboard/models/login_model.dart';
import '../dashboard/models/new_projectModel.dart';
import '../dashboard/models/measures_model.dart';
import '../dashboard/models/project_branches_model.dart';
import '../dashboard/models/response_model.dart';
import '../dashboard/models/web_api_issues_model.dart';
import '../dashboard/utils/constants.dart';

class SonarMemoryApiService {
  static const String _baseUrl = 'http://localhost:5000/api';
  static const apiKey = Constants.API_KEY;
  final encodedApiKey = base64.encode(utf8.encode(apiKey + ":"));

  Future<List<MeasuresModel>> getMeasures(String db, String projectUuid) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/$db/projects/$projectUuid/measures/$projectUuid?query=uuid,project_uuid,metric_uuid,value,text_value'));
    if (response.statusCode == 200) {
      final List<dynamic> measures = jsonDecode(response.body);
      return measures
          .map((measure) => MeasuresModel.fromJson(measure))
          .toList();
    } else {
      throw Exception('Failed to load Measures!');
    }
  }

  Future<List<IssuesModel>> getIssues(String db, String projectUuid) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/$db/projects/$projectUuid/issues/$projectUuid?query=kee,severity,project_uuid,status'));
    if (response.statusCode == 200) {
      final List<dynamic> issues = jsonDecode(response.body);
      return issues.map((issue) => IssuesModel.fromJson(issue)).toList();
    } else {
      throw Exception('Failed to load Issues!');
    }
  }

  Future<ResponseModel> postProject(NewProjectModel project) async {
    final response =
        await http.post(Uri.parse('$_baseUrl/sonarmemory2/projects/create'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(project));
    if (response.statusCode == 201) {
      return ResponseModel(status: 201, message: "Successfully added Project!");
    } else {
      throw Exception('Failed to add Project!');
    }
  }

  Future<ResponseModel> postProjectsBranches(
      PostProjectsBranchesModel projectBranch) async {
    final response = await http.post(
        Uri.parse('$_baseUrl/sonarmemory2/projects/postBranches'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(projectBranch));
    if (response.statusCode == 201) {
      return ResponseModel(status: 201, message: "Successfully added Project!");
    } else {
      throw Exception('Failed to add Project!');
    }
  }

  Future<List<AnalysisLogsModel>> getAnalysisLogs(String projectUuid) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/sonarmemory2/analysis/logs/$projectUuid'));
    if (response.statusCode == 200) {
      List<dynamic> analysisLogs = jsonDecode(response.body);
      analysisLogs = analysisLogs.reversed.toList();
      return analysisLogs
          .map((analysisLog) => AnalysisLogsModel.fromJson(analysisLog))
          .toList();
    } else {
      throw Exception('Failed to load Analysis Logs!');
    }
  }

  Future<ResponseModel> postAnalysisLogs(
      AnalysisLogsPostModel analysisLog) async {
    final response =
        await http.post(Uri.parse('$_baseUrl/sonarmemory2/analysis/logs'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(analysisLog));
    if (response.statusCode == 201) {
      return ResponseModel(status: 201, message: "Successfully added Project!");
    } else {
      throw Exception('Failed to add Project!');
    }
  }

  Future<ResponseModel> postAnalysisIssues(
      AnalysisIssuesPostModel issuesList) async {
    final response =
        await http.post(Uri.parse('$_baseUrl/sonarmemory2/analysis/issues'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(issuesList));
    if (response.statusCode == 201) {
      return ResponseModel(status: 201, message: "Successfully added Project!");
    } else {
      throw Exception('Failed to add Project!');
    }
  }

  Future<ResponseModel> updateProjectBranchDate(
      String branchUuid, String date) async {
    final response = await http.put(
        Uri.parse(
            '$_baseUrl/sonarmemory2/projects/branches/$branchUuid/updateBranch'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "branch": {"updated_at": date}
        }));
    if (response.statusCode == 200) {
      return ResponseModel(
          status: 200, message: "Successfully updated Project!");
    } else {
      throw Exception('Failed to update Project!');
    }
  }

  Future<List<ProjectsNBranchesModel>> getProjectsNBranches(
      String db, String? projectUuid) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/projects/${projectUuid ?? ''}${db == 'sonarmemory2' ? '?dbName=SonarMemory2' : ''}'));
    if (response.statusCode == 200) {
      final List<dynamic> projectsNBranches = jsonDecode(response.body);
      return projectsNBranches
          .map((projectsNBranch) =>
              ProjectsNBranchesModel.fromJson(projectsNBranch))
          .toList();
    } else {
      throw Exception('Failed to load Projects!');
    }
  }

  Future<ResponseModel> deleteProject(String projectUuid) async {
    final response = await http
        .put(Uri.parse('$_baseUrl/sonarmemory2/projects/$projectUuid/delete'));
    if (response.statusCode == 200) {
      return ResponseModel(
          status: 200, message: "Successfully deleted Project!");
    } else {
      throw Exception('Failed to delete Project!');
    }
  }

  Future<ResponseModel> deleteProjectBranch(String branchUuid) async {
    final response = await http.put(
        Uri.parse('$_baseUrl/sonarmemory2/projects/$branchUuid/deleteBranch'));
    if (response.statusCode == 200) {
      return ResponseModel(
          status: 200, message: "Successfully deleted Project Branch!");
    } else {
      throw Exception('Failed to delete Project Branch!');
    }
  }

  Future<ResponseModel> deleteAnalysisLogs(String analysisUuid) async {
    final response = await http.put(
        Uri.parse('$_baseUrl/sonarmemory2/analysis/logs/$analysisUuid/delete'));
    if (response.statusCode == 200) {
      return ResponseModel(
          status: 200, message: "Successfully deleted Analysis Logs!");
    } else {
      throw Exception('Failed to delete Analysis Logs!');
    }
  }

  //////// SonarQube

  Future<LoginModel> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/sonarQube/login'),
      body: jsonEncode({"username": username, "password": password}),
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
      Uri.parse('$_baseUrl/sonarQube/validate'),
      headers: <String, String>{
        "Authorization": "Basic $encodedApiKey",
      },
    );
    if (response.statusCode == 200) {
      return ValidModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load valid');
    }
  }

  Future<int> getSonarQubeIssues(
      String severity, String type, String projectKey, String branch) async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/sonarQube/issues?severities=$severity&types=$type&componentKeys=$projectKey&branch=$branch'),
      headers: <String, String>{
        "Authorization": "Basic $encodedApiKey",
      },
    );
    if (response.statusCode == 200) {
      return WebApiIssuesModel.fromJson(jsonDecode(response.body)).total!;
    } else {
      throw Exception(
          'Failed to load issues ' + response.statusCode.toString());
    }
  }
}
