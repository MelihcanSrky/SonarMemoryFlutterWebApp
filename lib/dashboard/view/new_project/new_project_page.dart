import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_sonar_app/dashboard/models/analysis_issues.dart';
import 'package:flutter_sonar_app/dashboard/models/analysis_logs.dart';
import 'package:flutter_sonar_app/dashboard/models/new_projectModel.dart';
import 'package:flutter_sonar_app/dashboard/models/project_branches_model.dart';
import 'package:flutter_sonar_app/dashboard/models/projects_model.dart';
import 'package:flutter_sonar_app/dashboard/view/new_project/components/chip_list.dart';
import 'package:flutter_sonar_app/dashboard/view/new_project/components/issues_measures_card.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../utils/constants.dart';
import '../../utils/dimens.dart';
import '../../widgets/scaffold_body.dart';
import '../../utils/strings.dart';
import '../main_page.dart';

class NewProjectPage extends StatefulWidget {
  const NewProjectPage({super.key});

  @override
  State<NewProjectPage> createState() => _NewProjectPageState();
}

class _NewProjectPageState extends State<NewProjectPage> {
  final bool? isExistingProject = Get.arguments["isExistingProject"];
  final bool? isBranchExisting = Get.arguments["isBranchExisting"];
  final String? projectKee = Get.arguments["projectKee"];
  final String? branchKee = Get.arguments["branchKee"];
  final String? uuid = Get.arguments["uuid"];
  final TextEditingController _versionNameController = TextEditingController();
  final TextEditingController _commitNoController = TextEditingController();
  final _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    store.newProjectVM.login("SonarMemory", "l6k5j4h3g2f1");
    store.newProjectVM.getValid();
    store.newProjectVM.getSingleProject(uuid!);
    store.newProjectVM.getMeasures(uuid!);
    store.newProjectVM.getIssues(uuid!);
    store.newProjectVM.setButtonEnabled(false);
    store.newProjectVM.setBranchUuid(uuid!, "main");
    store.newProjectVM.getIssuesList(projectKee!, branchKee!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBody(
        middleBlock: buildMiddleContainerBlock(context),
      ),
    );
  }

  Flexible buildMiddleContainerBlock(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            left: Dimens.margin_24,
            right: Dimens.margin_24,
            top: Dimens.margin_24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Observer(builder: (_) {
                return Text(
                  store.newProjectVM.project?[0].name.toString() ??
                      Strings.noName,
                  style: const TextStyle(fontSize: Dimens.Title1),
                  textAlign: TextAlign.start,
                );
              }),
              SizedBox(height: 50, child: ChipList()),
              const SizedBox(height: Dimens.margin_16),
              Observer(builder: (_) {
                return Text(
                  store.newProjectVM.branchKee!.toUpperCase().toString(),
                  style: const TextStyle(fontSize: Dimens.Title2),
                  textAlign: TextAlign.start,
                );
              }),
              const SizedBox(height: Dimens.margin_16),
              IssuesMeasuresCard(),
              const SizedBox(height: Dimens.margin_16),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimens.margin_16),
                child: Container(
                  child: Column(
                    children: [
                      buildTextFieldRow("Version Name: ", "Version Name",
                          _versionNameController),
                      buildTextFieldRow(
                          "Commit No: ", "Commit No", _commitNoController),
                      const SizedBox(height: Dimens.margin_48),
                      Container(
                        width: double.infinity,
                        child: Observer(builder: (_) {
                          if (_versionNameController.text == "" ||
                              _commitNoController.text == "") {
                            store.newProjectVM.setButtonEnabled(false);
                          } else {
                            store.newProjectVM.setButtonEnabled(true);
                          }
                          return buildSubmitElevatedButton(context);
                        }),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton buildSubmitElevatedButton(BuildContext context) {
    return ElevatedButton(
      child: const Padding(
        padding: EdgeInsets.all(Dimens.margin_16),
        child: Text(
          "SUBMIT",
          style: TextStyle(color: Colors.white),
        ),
      ),
      onPressed: !store.newProjectVM.isButtonEnabled!
          ? null
          : () async {
              final versionId = _uuid.v4();
              final analysisId = _uuid.v4();
              print("isExistingProject: $isExistingProject");
              if (isExistingProject! == false) {
                await store.newProjectVM.postProject(NewProjectModel(
                    project: ProjectsModel(
                  uuid: store.newProjectVM.project?[0].uuid.toString(),
                  name: store.newProjectVM.project?[0].name.toString(),
                  kee: store.newProjectVM.project?[0].kee.toString(),
                  createdAt: store.newProjectVM.project?[0].createdAt,
                  updatedAt: store.newProjectVM.project?[0].updatedAt,
                  deleted: false,
                )));
              }
              if (!isBranchExisting!) {
                await store.newProjectVM
                    .postProjectBranch(PostProjectsBranchesModel(
                        branch: ProjectBranchesSubModel(
                  uuid: store.newProjectVM.branchUuid.toString(),
                  projectUuid: uuid.toString(),
                  kee: store.newProjectVM.projectsm1Branches!
                      .where((element) =>
                          element.uuid == store.newProjectVM.branchUuid)
                      .first
                      .kee
                      .toString(),
                  mergeBranchUuid: uuid!.toString(),
                  createdAt: store.newProjectVM.projectsm1Branches!
                      .where((element) =>
                          element.uuid == store.newProjectVM.branchUuid)
                      .first
                      .createdAt,
                  updatedAt: store.newProjectVM.projectsm1Branches!
                      .where((element) =>
                          element.uuid == store.newProjectVM.branchUuid)
                      .first
                      .updatedAt,
                  deleted: false,
                )));
              }
              await store.newProjectVM.postAnalysisLogs(AnalysisLogsPostModel(
                  analysisLog: AnalysisLogsModel(
                analysisUuid: analysisId,
                projectUuid: store.newProjectVM.branchUuid.toString(),
                versionUuid: versionId,
                versionName: _versionNameController.text,
                createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                lines: double.parse(store.newProjectVM.measures
                        ?.where((element) =>
                            element.metricUuid ==
                            Constants.metricsList[3].values.first)
                        .first
                        .value
                        .toString() ??
                    "0"),
                reliability: store.newProjectVM.measures
                    ?.where((element) =>
                        element.metricUuid ==
                        Constants.metricsList[4].values.first)
                    .first
                    .text_value,
                security: store.newProjectVM.measures
                    ?.where((element) =>
                        element.metricUuid ==
                        Constants.metricsList[5].values.first)
                    .first
                    .text_value,
                securityReview: store.newProjectVM.measures
                    ?.where((element) =>
                        element.metricUuid ==
                        Constants.metricsList[6].values.first)
                    .first
                    .text_value,
                coverage: store.newProjectVM.measures
                    ?.where((element) =>
                        element.metricUuid ==
                        Constants.metricsList[7].values.first)
                    .first
                    .value,
                duplication: store.newProjectVM.measures
                    ?.where((element) =>
                        element.metricUuid ==
                        Constants.metricsList[8].values.first)
                    .first
                    .value,
                cyclomatic: store.newProjectVM.measures
                    ?.where((element) =>
                        element.metricUuid ==
                        Constants.metricsList[9].values.first)
                    .first
                    .value,
                cognitive: store.newProjectVM.measures
                    ?.where((element) =>
                        element.metricUuid ==
                        Constants.metricsList[10].values.first)
                    .first
                    .value,
                commitNo: _commitNoController.text,
              )));
              await store.newProjectVM.postAnalysisIssues(
                  AnalysisIssuesPostModel(analysisIssues: <AnalysisIssuesModel>[
                for (var issues in Constants.analysisIssuesList)
                  AnalysisIssuesModel(
                    analysisUuid: analysisId,
                    metricUuid: issues.values.first,
                    major: (issues.keys.first == "Bugs")
                        ? store.newProjectVM.issuesList?.bugs.major
                                .toString() ??
                            "0"
                        : (issues.keys.first == "Vulnerabilities")
                            ? store.newProjectVM.issuesList?.vulnerabilities
                                    .major
                                    .toString() ??
                                "0"
                            : (issues.keys.first == "Code Smells")
                                ? store.newProjectVM.issuesList?.codeSmells
                                        .major
                                        .toString() ??
                                    "0"
                                : (issues.keys.first == "Security Hotspots")
                                    ? store.newProjectVM.measures
                                            ?.where((element) =>
                                                element.metricUuid ==
                                                Constants.analysisIssuesList[3]
                                                    .values.first)
                                            .toList()[0]
                                            .value
                                            .toString() ??
                                        "0"
                                    : "0",
                    minor: (issues.keys.first == "Bugs")
                        ? store.newProjectVM.issuesList?.bugs.minor
                                .toString() ??
                            "0"
                        : (issues.keys.first == "Vulnerabilities")
                            ? store.newProjectVM.issuesList?.vulnerabilities
                                    .minor
                                    .toString() ??
                                "0"
                            : (issues.keys.first == "Code Smells")
                                ? store.newProjectVM.issuesList?.codeSmells
                                        .minor
                                        .toString() ??
                                    "0"
                                : "0",
                    blocker: (issues.keys.first == "Bugs")
                        ? store.newProjectVM.issuesList?.bugs.blocker
                                .toString() ??
                            "0"
                        : (issues.keys.first == "Vulnerabilities")
                            ? store.newProjectVM.issuesList?.vulnerabilities
                                    .blocker
                                    .toString() ??
                                "0"
                            : (issues.keys.first == "Code Smells")
                                ? store.newProjectVM.issuesList?.codeSmells
                                        .blocker
                                        .toString() ??
                                    "0"
                                : "0",
                    critical: (issues.keys.first == "Bugs")
                        ? store.newProjectVM.issuesList?.bugs.critical
                                .toString() ??
                            "0"
                        : (issues.keys.first == "Vulnerabilities")
                            ? store.newProjectVM.issuesList?.vulnerabilities
                                    .critical
                                    .toString() ??
                                "0"
                            : (issues.keys.first == "Code Smells")
                                ? store.newProjectVM.issuesList?.codeSmells
                                        .critical
                                        .toString() ??
                                    "0"
                                : "0",
                  )
              ]));
              if (isBranchExisting!) {
                await store.newProjectVM.updateProjectBranchDate(
                    store.newProjectVM.branchUuid.toString(),
                    store.newProjectVM.projectsm1Branches!
                        .where((element) =>
                            element.uuid == store.newProjectVM.branchUuid)
                        .first
                        .updatedAt
                        .toString());
              }
              store.projectNBranchesVM.getProjectsNBranches();
              Navigator.pop(context);
            },
    );
  }

  Row buildTextFieldRow(
      String label, String hintLabel, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
                fontSize: Dimens.Title2, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter ${hintLabel}"),
            onChanged: (value) {
              if (_versionNameController.text == "" ||
                  _commitNoController.text == "") {
                store.newProjectVM.setButtonEnabled(false);
              } else {
                store.newProjectVM.setButtonEnabled(true);
              }
            },
          ),
        ),
      ],
    );
  }
}
