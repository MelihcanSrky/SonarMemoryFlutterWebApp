import 'dart:developer';

import 'package:flutter_sonar_app/dashboard/models/analysis_logs.dart';
import 'package:flutter_sonar_app/dashboard/models/projects_n_branches_model.dart';
import 'package:flutter_sonar_app/dashboard/models/new_projectModel.dart';
import 'package:flutter_sonar_app/dashboard/models/web_api_issues_model.dart';
import 'package:flutter_sonar_app/service/sonar_memory_api_service.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

import '../../service/sonar_web_api_service.dart';
import '../models/analysis_issues.dart';
import '../models/issues_model.dart';
import '../models/login_model.dart';
import '../models/measures_model.dart';
import '../models/project_branches_model.dart';
import '../models/response_model.dart';
import '../models/types_issues_model.dart';
import '../utils/strings.dart';
part 'new_project_view_model.g.dart';

class NewProjectViewModel = _NewProjectViewModelBase with _$NewProjectViewModel;

abstract class _NewProjectViewModelBase with Store {
  @observable
  List<ProjectsNBranchesModel>? project;
  @observable
  List<ProjectsNBranchesModel>? tempProject;
  @observable
  List<MeasuresModel>? measures;
  @observable
  List<IssuesModel>? issues;
  @observable
  ResponseModel? response;
  @observable
  List<ProjectBranchesSubModel>? projectsm1Branches;
  @observable
  List<ProjectBranchesSubModel>? projectsm2Branches;
  @observable
  String? branchUuid;
  @observable
  String? branchKee;
  @observable
  String? projectKee;
  @observable
  bool? isBranchExist;
  @observable
  bool? isButtonEnabled;
  @observable
  TypesModel? issuesList;
  @observable
  bool? isFetchLoading;
  @observable
  bool? newProjectError;

  @action
  Future<void> getSingleProject(String projectUuid) async {
    project = await SonarMemoryApiService()
        .getProjectsNBranches(Strings.sonarmemory, projectUuid);
    projectsm1Branches = project?.first.projectBranches ?? [];
    tempProject = await SonarMemoryApiService()
        .getProjectsNBranches(Strings.sonarmemory2, projectUuid);
    projectsm2Branches = (tempProject != null && tempProject!.isNotEmpty)
        ? tempProject?.first.projectBranches
        : [];
    projectKee = project?.first.kee;
  }

  @action
  Future<void> getMeasures(String projectUuid) async {
    measures = await SonarMemoryApiService()
        .getMeasures(Strings.sonarmemory, projectUuid);
  }

  @action
  Future<void> getIssues(String projectUuid) async {
    issues = await SonarMemoryApiService()
        .getIssues(Strings.sonarmemory, projectUuid);
  }

  @action
  Future<void> postProject(NewProjectModel project) async {
    response = await SonarMemoryApiService().postProject(project).then((value) {
      if (value.status == 400) {
        newProjectError = true;
      }
    });
  }

  @action
  Future<void> getProjectBranches(String projectUuid) async {}

  @action
  Future<void> postProjectBranch(
      PostProjectsBranchesModel projectBranch) async {
    response = await SonarMemoryApiService()
        .postProjectsBranches(projectBranch)
        .then((value) {
      if (value.status == 400) {
        newProjectError = true;
      }
    });
  }

  @action
  void setBranchExist(String branchUuid) {
    isBranchExist = projectsm2Branches
        ?.map((e) => e.uuid.toString())
        .contains(branchUuid.toString());
  }

  @action
  Future<void> postAnalysisLogs(AnalysisLogsPostModel analysisLog) async {
    response = await SonarMemoryApiService()
        .postAnalysisLogs(analysisLog)
        .then((value) {
      if (value.status == 400) {
        newProjectError = true;
      }
    });
  }

  @action
  Future<void> postAnalysisIssues(AnalysisIssuesPostModel analysisIssue) async {
    response = await SonarMemoryApiService()
        .postAnalysisIssues(analysisIssue)
        .then((value) {
      if (value.status == 400) {
        newProjectError = true;
      }
    });
  }

  @action
  void setBranchUuid(String uuid, String kee) {
    branchUuid = uuid;
    branchKee = kee;
  }

  @action
  Future<void> updateProjectBranchDate(String branchUuid, String date) async {
    response =
        await SonarMemoryApiService().updateProjectBranchDate(branchUuid, date);
  }

  @action
  void setButtonEnabled(bool isEnabled) {
    isButtonEnabled = isEnabled;
  }

  @observable
  LoginModel? status;
  @observable
  ValidModel? valid;

  @action
  Future<void> login(String username, String password) async {
    status = await SonarMemoryApiService().login(username, password);
  }

  @action
  Future<void> getValid() async {
    valid = await SonarMemoryApiService().getValid();
  }

  @action
  Future<int> getIssuesCount(
      String severity, String type, String projectKey, String branch) async {
    setIsFetchLoading(true);
    var temp = await SonarMemoryApiService()
        .getSonarQubeIssues(severity, type, projectKey, branch);
    setIsFetchLoading(false);
    return temp;
  }

  @action
  void setIsFetchLoading(bool value) {
    isFetchLoading = value;
  }

  @action
  bool getIsFetchLoading() {
    return isFetchLoading!;
  }

  @action
  Future<void> getIssuesList(String projectKey, String branch) async {
    TypesModel _issuesList = TypesModel(
        bugs: SeveritiesModel(),
        codeSmells: SeveritiesModel(),
        vulnerabilities: SeveritiesModel());
    // MAJOR BUG
    _issuesList.bugs.major =
        await getIssuesCount('MAJOR', 'BUG', projectKey, branch);
    // MINOR BUG
    _issuesList.bugs.minor =
        await getIssuesCount('MINOR', 'BUG', projectKey, branch);
    // CRITICAL BUG
    _issuesList.bugs.critical =
        await getIssuesCount('CRITICAL', 'BUG', projectKey, branch);
    // BLOCKER BUG
    _issuesList.bugs.blocker =
        await getIssuesCount('BLOCKER', 'BUG', projectKey, branch);
    // MAJOR CODE_SMELL
    _issuesList.codeSmells.major =
        await getIssuesCount('MAJOR', 'CODE_SMELL', projectKey, branch);
    // MINOR CODE_SMELL
    _issuesList.codeSmells.minor =
        await getIssuesCount('MINOR', 'CODE_SMELL', projectKey, branch);
    // CRITICAL CODE_SMELL
    _issuesList.codeSmells.critical =
        await getIssuesCount('CRITICAL', 'CODE_SMELL', projectKey, branch);
    // BLOCKER CODE_SMELL
    _issuesList.codeSmells.blocker =
        await getIssuesCount('BLOCKER', 'CODE_SMELL', projectKey, branch);
    // MAJOR VULNERABILITY
    _issuesList.vulnerabilities.major =
        await getIssuesCount('MAJOR', 'VULNERABILITY', projectKey, branch);
    // MINOR VULNERABILITY
    _issuesList.vulnerabilities.minor =
        await getIssuesCount('MINOR', 'VULNERABILITY', projectKey, branch);
    // CRITICAL VULNERABILITY
    _issuesList.vulnerabilities.critical =
        await getIssuesCount('CRITICAL', 'VULNERABILITY', projectKey, branch);
    // BLOCKER VULNERABILITY
    _issuesList.vulnerabilities.blocker =
        await getIssuesCount('BLOCKER', 'VULNERABILITY', projectKey, branch);
    issuesList = _issuesList;
    setIsFetchLoading(false);
  }
}
