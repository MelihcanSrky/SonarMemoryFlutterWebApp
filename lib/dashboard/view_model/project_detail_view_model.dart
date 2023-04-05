import 'package:flutter_sonar_app/dashboard/models/analysis_issues.dart';
import 'package:flutter_sonar_app/dashboard/models/analysis_logs.dart';
import 'package:flutter_sonar_app/dashboard/models/project_branches_model.dart';
import 'package:flutter_sonar_app/dashboard/models/project_log_model.dart';
import 'package:flutter_sonar_app/dashboard/models/projects_n_branches_model.dart';
import 'package:flutter_sonar_app/dashboard/models/web_api_issues_model.dart';
import 'package:flutter_sonar_app/service/sonar_memory_api_service.dart';
import 'package:mobx/mobx.dart';
import 'dart:async';

import '../../service/sonar_web_api_service.dart';
import '../utils/strings.dart';

part 'project_detail_view_model.g.dart';

class ProjectDetailViewModel = _ProjectDetailViewModelBase
    with _$ProjectDetailViewModel;

abstract class _ProjectDetailViewModelBase with Store {
  @observable
  List<ProjectLogSubModel>? projectLogs;
  @observable
  List<ProjectsNBranchesModel>? project;
  @observable
  List<ProjectBranchesSubModel>? projectBranches;
  @observable
  String? branchUuid;
  @observable
  List<AnalysisIssuesModel>? analysisIssues;
  @observable
  List<AnalysisLogsModel>? analysisLogs;
  @observable
  bool? isProjectLoading;

  @action
  Future<void> getSingleProject(String projectUuid) async {
    isProjectLoading = true;
    project = await SonarMemoryApiService()
        .getProjectsNBranches(Strings.sonarmemory2, projectUuid);
    projectBranches = project!.first.projectBranches;
    isProjectLoading = false;
  }

  @action
  Future<void> getAnalysisLogs(String projectUuid) async {
    analysisLogs = await SonarMemoryApiService().getAnalysisLogs(projectUuid);
  }

  @action
  void setBranchUuid(String uuid) {
    branchUuid = uuid;
  }

  @action
  Future<void> deleteProject(String projectUuid) async {
    await SonarMemoryApiService().deleteProject(projectUuid);
  }

  @action
  Future<void> deleteBranch(String branchUuid) async {
    await SonarMemoryApiService().deleteProjectBranch(branchUuid);
  }

  @action
  Future<void> deleteAnalysisLogs(String analysisUuid) async {
    await SonarMemoryApiService().deleteAnalysisLogs(analysisUuid);
  }
}
