import 'package:flutter/material.dart';

import '../../../models/project_branches_model.dart';
import '../../../utils/CustomColors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/strings.dart';
import '../../main_page.dart';

class BranchesListView extends StatelessWidget {
  final int index;
  final bool isProjectExist;
  final List<ProjectBranchesSubModel> branch;
  const BranchesListView(
      {required this.index,
      required this.isProjectExist,
      required this.branch,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: store.projectNBranchesVM.sm1ProjectsNBranches?[index]
              .projectBranches?.length ??
          0,
      itemBuilder: (context, index1) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.margin_4),
          child: Text(
            store.projectNBranchesVM.sm1ProjectsNBranches?[index]
                    .projectBranches?[index1].kee ??
                Strings.noBranches,
            style: TextStyle(
              fontSize: Dimens.Title2,
              fontWeight: FontWeight.w400,
              color: isProjectExist
                  ? store.projectNBranchesVM.sm2ProjectsNBranches!
                          .where((element) =>
                              element.uuid ==
                              store.projectNBranchesVM
                                  .sm1ProjectsNBranches?[index].uuid)
                          .first
                          .projectBranches!
                          .map((e) => e.kee)
                          .contains(branch[index1].kee)
                      ? CustomColors.helperGreen
                      : Colors.red
                  : Colors.red,
            ),
          ),
        );
      },
    );
  }
}
