import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../themes/chip_theme.dart';
import '../../../utils/CustomColors.dart';
import '../../../utils/dimens.dart';
import '../../../utils/strings.dart';
import '../../main_page.dart';

class ChipList extends StatefulWidget {
  const ChipList({super.key});

  @override
  State<ChipList> createState() => _ChipListState();
}

class _ChipListState extends State<ChipList> {
  @override
  Widget build(BuildContext context) {
    BranchChipTheme branchChipTheme =
        Theme.of(context).extension<BranchChipTheme>()!;
    return Observer(builder: (_) {
      if (store.newProjectVM.projectsm1Branches == null ||
          store.newProjectVM.projectsm2Branches == null) {
        return const Center(child: CircularProgressIndicator());
      } else if (store.newProjectVM.projectsm1Branches!.isEmpty) {
        return const Center(child: Text(Strings.noBranches));
      } else {
        final projectBranches = store.newProjectVM.projectsm1Branches;
        return Flexible(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: store.newProjectVM.projectsm1Branches?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              store.newProjectVM.setBranchExist(store
                  .newProjectVM.projectsm1Branches![index].uuid!
                  .toString());
              if (store.newProjectVM.isBranchExist!) {
                return Padding(
                  padding: const EdgeInsets.all(Dimens.margin_8),
                  child: Observer(builder: (_) {
                    return Chip(
                      backgroundColor:
                          CustomColors.helperGreen.withOpacity(0.5),
                      // backgroundColor: (projectBranches![index].uuid ==
                      //         store.newProjectVM.branchUuid)
                      //     ? branchChipTheme.primaryColor
                      //     : branchChipTheme.secondaryColor,
                      label: Text(
                          store.newProjectVM.projectsm1Branches?[index].kee
                                  .toString() ??
                              Strings.noName,
                          style: TextStyle(color: Colors.white
                              // color: (projectBranches[index].uuid ==
                              //         store.newProjectVM.branchUuid)
                              //     ? branchChipTheme.secondaryColor
                              //     : branchChipTheme.primaryColor
                              )),
                    );
                  }),
                );
              } else if (!store.newProjectVM.isBranchExist!) {
                return Padding(
                  padding: const EdgeInsets.all(Dimens.margin_8),
                  child: Observer(builder: (_) {
                    return ActionChip(
                      backgroundColor: (projectBranches![index].uuid ==
                              store.newProjectVM.branchUuid)
                          ? Colors.red
                          : Colors.red[300],
                      label: Text(
                        store.newProjectVM.projectsm1Branches?[index].kee
                                .toString() ??
                            Strings.noName,
                        style: TextStyle(color: Colors.white
                            // color: (projectBranches[index].uuid ==
                            //         store.newProjectVM.branchUuid)
                            //     ? branchChipTheme.secondaryColor
                            //     : branchChipTheme.primaryColor
                            ),
                      ),
                      onPressed: () {
                        store.newProjectVM.setBranchUuid(
                            store.newProjectVM.projectsm1Branches![index].uuid
                                .toString(),
                            store.newProjectVM.projectsm1Branches![index].kee
                                .toString());
                        store.newProjectVM.getMeasures(
                            store.newProjectVM.branchUuid.toString());
                        store.newProjectVM.getIssues(
                            store.newProjectVM.branchUuid.toString());

                        store.newProjectVM.getIssuesList(
                            store.newProjectVM.projectKee!,
                            store.newProjectVM.branchKee!);
                      },
                    );
                  }),
                );
              }
            },
          ),
        );
      }
    });
  }
}
