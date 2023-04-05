import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_sonar_app/dashboard/view/main_page.dart';
import 'package:flutter_sonar_app/themes/chip_theme.dart';

import '../../../utils/CustomColors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/strings.dart';

class ChipList extends StatefulWidget {
  final String? projectUuid;
  const ChipList({this.projectUuid, super.key});

  @override
  State<ChipList> createState() => _ChipListState();
}

class _ChipListState extends State<ChipList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BranchChipTheme branchChipTheme =
        Theme.of(context).extension<BranchChipTheme>()!;
    final projectBranches = store.projectDetails.projectBranches;

    return Column(
      children: [
        Observer(builder: (_) {
          if (projectBranches != null && projectBranches.isNotEmpty) {
            return Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: projectBranches.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(Dimens.margin_8),
                    child: ActionChip(
                      backgroundColor: (projectBranches[index].uuid ==
                              store.projectDetails.branchUuid)
                          ? branchChipTheme.primaryColor
                          : branchChipTheme.secondaryColor,
                      label: Text(projectBranches[index].kee.toString(),
                          style: TextStyle(
                              fontSize: Dimens.Title2,
                              color: (projectBranches[index].uuid ==
                                      store.projectDetails.branchUuid)
                                  ? branchChipTheme.secondaryColor
                                  : branchChipTheme.primaryColor)),
                      onPressed: () async {
                        store.projectDetails.setBranchUuid(
                            projectBranches[index].uuid.toString());
                        await store.projectDetails
                            .getAnalysisLogs(store.projectDetails.branchUuid!);
                        store.gridVM.clearSelectedRow();
                        store.gridVM.clearSelectedRowsList();
                      },
                    ),
                  );
                },
              ),
            );
          } else if (projectBranches == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text(Strings.noBranches),
            );
          }
        }),
      ],
    );
    ;
  }
}
