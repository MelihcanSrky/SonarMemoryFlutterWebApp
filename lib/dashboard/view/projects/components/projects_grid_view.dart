import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_sonar_app/dashboard/utils/dimens.dart';
import 'package:flutter_sonar_app/dashboard/view/projects/components/branches_list_view.dart';
import 'package:flutter_sonar_app/themes/project_card_theme.dart';
import 'package:get/get.dart';

import '../../../controllers/main_screen_controller.dart';
import '../../../utils/CustomColors.dart';
import '../../../utils/strings.dart';
import '../../main_page.dart';

class ProjectsGridView extends StatefulWidget {
  final int crossAxisCount;
  final double childAspectRatio;
  const ProjectsGridView(
      {this.crossAxisCount = 3, this.childAspectRatio = 1, super.key});

  @override
  State<ProjectsGridView> createState() => _ProjectsGridViewState();
}

class _ProjectsGridViewState extends State<ProjectsGridView> {
  @override
  Widget build(BuildContext context) {
    ProjectCardTheme projectCardTheme =
        Theme.of(context).extension<ProjectCardTheme>()!;
    return Observer(builder: (_) {
      return GridView.builder(
          shrinkWrap: true,
          itemCount: store.projectNBranchesVM.sm1ProjectsNBranches?.length ?? 0,
          itemBuilder: (context, index) {
            final sm1Branches = store.projectNBranchesVM
                .sm1ProjectsNBranches?[index].projectBranches;
            final isProjectExist = store
                .projectNBranchesVM.sm2ProjectsNBranches!
                .map((e) => e.uuid)
                .contains(
                    store.projectNBranchesVM.sm1ProjectsNBranches?[index].uuid);
            final sm2Branches = isProjectExist
                ? store.projectNBranchesVM.sm2ProjectsNBranches!
                    .where((element) =>
                        element.uuid ==
                        store.projectNBranchesVM.sm1ProjectsNBranches?[index]
                            .uuid)
                    .first
                    .projectBranches
                    ?.map((e) => e.uuid)
                    .toList()
                : [];
            return GestureDetector(
              onTap: () {
                bool isBranchExist = sm1Branches
                    .map((e) => e.uuid)
                    .toList()
                    .toSet()
                    .difference(sm2Branches!.toSet())
                    .isEmpty;
                if (isProjectExist && isBranchExist) {
                  store.changeRoute(Applinks.DASHBOARD);
                  Get.offNamed(Applinks.DASHBOARD, arguments: {
                    "projectUuid": store
                        .projectNBranchesVM.sm2ProjectsNBranches!
                        .where((element) =>
                            element.uuid ==
                            store.projectNBranchesVM
                                .sm1ProjectsNBranches?[index].uuid)
                        .first
                        .uuid,
                    "branchUuid": store.projectNBranchesVM.sm2ProjectsNBranches!
                        .where((element) =>
                            element.uuid ==
                            store.projectNBranchesVM
                                .sm1ProjectsNBranches?[index].uuid)
                        .first
                        .projectBranches
                        ?.first
                        .uuid,
                  })!
                      .then((value) {
                    store.projectNBranchesVM.getProjectsNBranches();
                  });
                } else if (isProjectExist && !isBranchExist) {
                  _showDialog(index, isProjectExist);
                } else if (!isProjectExist) {
                  Get.toNamed(Applinks.NEW_PROJECT, arguments: {
                    "isExistingProject": isProjectExist,
                    "isBranchExisting": false,
                    "uuid": store
                        .projectNBranchesVM.sm1ProjectsNBranches?[index].uuid,
                    "projectKee": store
                        .projectNBranchesVM.sm1ProjectsNBranches![index].kee,
                    "branchKee": store
                        .projectNBranchesVM
                        .sm1ProjectsNBranches![index]
                        .projectBranches
                        ?.first
                        .kee,
                  })!
                      .then((value) {
                    store.projectNBranchesVM.getProjectsNBranches();
                  });
                }
              },
              child: Card(
                  elevation: 5,
                  color: projectCardTheme.backgroundColor,
                  margin: const EdgeInsets.all(Dimens.margin_16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimens.margin_8),
                        child: Text(
                          store.projectNBranchesVM.sm1ProjectsNBranches?[index]
                                  .name ??
                              Strings.noName,
                          style: TextStyle(
                              fontSize:
                                  projectCardTheme.titleTextStyle!.fontSize,
                              fontWeight:
                                  projectCardTheme.titleTextStyle!.fontWeight,
                              color: isProjectExist
                                  ? CustomColors.helperGreen
                                  : Colors.red),
                        ),
                      ),
                      const Divider(
                        color: CustomColors.dividerColor,
                      ),
                      BranchesListView(
                          index: index,
                          isProjectExist: isProjectExist,
                          branch: sm1Branches!)
                    ],
                  )),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.crossAxisCount,
            childAspectRatio: widget.childAspectRatio,
          ));
    });
  }

  Future<void> _showDialog(int index, bool isProjectExist) async {
    await showDialog<void>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Get.toNamed(Applinks.NEW_PROJECT, arguments: {
                    "isExistingProject": isProjectExist,
                    "isBranchExisting": false,
                    "uuid": store
                        .projectNBranchesVM.sm1ProjectsNBranches?[index].uuid,
                    "projectKee": store.projectNBranchesVM.sm2ProjectsNBranches!
                        .where((element) =>
                            element.uuid ==
                            store.projectNBranchesVM
                                .sm1ProjectsNBranches?[index].uuid)
                        .first
                        .kee,
                    "branchKee": store.projectNBranchesVM.sm2ProjectsNBranches!
                        .where((element) =>
                            element.uuid ==
                            store.projectNBranchesVM
                                .sm1ProjectsNBranches?[index].uuid)
                        .first
                        .projectBranches
                        ?.first
                        .kee,
                  })!
                      .then((value) {
                    store.projectNBranchesVM.getProjectsNBranches();
                  });
                  Navigator.pop(context);
                },
                child: const Text("Add new Branch to Project"),
              ),
              SimpleDialogOption(
                onPressed: () {
                  store.changeRoute(Applinks.DASHBOARD);
                  Get.offNamed(Applinks.DASHBOARD, arguments: {
                    "projectUuid": store
                        .projectNBranchesVM.sm2ProjectsNBranches!
                        .where((element) =>
                            element.uuid ==
                            store.projectNBranchesVM
                                .sm1ProjectsNBranches?[index].uuid)
                        .first
                        .uuid,
                    "branchUuid": store.projectNBranchesVM.sm2ProjectsNBranches!
                        .where((element) =>
                            element.uuid ==
                            store.projectNBranchesVM
                                .sm1ProjectsNBranches?[index].uuid)
                        .first
                        .projectBranches
                        ?.first
                        .uuid,
                  })!
                      .then((value) {
                    store.projectNBranchesVM.getProjectsNBranches();
                  });
                  Navigator.pop(context);
                },
                child: const Text("Project Detail"),
              ),
            ],
          );
        });
  }
}
