import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_sonar_app/dashboard/view/dashboard/components/analysis_history.dart';
import 'package:flutter_sonar_app/dashboard/view/dashboard/components/analysis_issues.dart';
import 'package:flutter_sonar_app/dashboard/view/dashboard/components/chip_list.dart';
import 'package:flutter_sonar_app/dashboard/view/main_page.dart';
import 'package:get/get.dart';
import '../../utils/dimens.dart';
import '../../utils/strings.dart';
import 'components/delete_chips.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String? projectUuid = Get.arguments["projectUuid"];
  String? branchUuid = Get.arguments["branchUuid"];

  @override
  void initState() {
    super.initState();
    if (projectUuid != "") {
      store.projectDetails.setBranchUuid(branchUuid!);
      store.projectDetails.getSingleProject(projectUuid!);
      store.gridVM.setDataGridController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Observer(builder: (_) {
      if (projectUuid == "") {
        return Center(child: Text(Strings.noProjects));
      }
      return Observer(builder: (_) {
        if (store.projectDetails.isProjectLoading!) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.margin_16),
              child: Column(
                children: [
                  const SizedBox(height: Dimens.margin_16),
                  if (projectUuid != null || projectUuid != "")
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: ChipList(projectUuid: projectUuid!)),
                                const DeleteProjectNBranchesChips(),
                              ],
                            )),
                        AnalysisIssues(
                          project: store.projectDetails.project ?? [],
                          projectUuid: store.projectDetails.branchUuid,
                        ),
                        AnalysisHistory(
                          projectUuid: store.projectDetails.branchUuid,
                        )
                      ],
                    )
                  else
                    Container(
                      child: const Text(Strings.noProjects),
                    )
                ],
              ),
            ),
          );
        }
      });
    })));
  }
}
