import 'package:flutter/material.dart';
import 'package:flutter_sonar_app/dashboard/controllers/main_screen_controller.dart';
import 'package:get/get.dart';

import '../../../utils/dimens.dart';
import '../../main_page.dart';

class DeleteProjectNBranchesChips extends StatefulWidget {
  const DeleteProjectNBranchesChips({super.key});

  @override
  State<DeleteProjectNBranchesChips> createState() =>
      _DeleteProjectNBranchesChipsState();
}

class _DeleteProjectNBranchesChipsState
    extends State<DeleteProjectNBranchesChips> {
  final _projectDetails = store.projectDetails;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (_projectDetails.project![0].projectBranches!.length > 1)
          ActionChip(
            avatar: const Icon(
              Icons.cancel_outlined,
              color: Colors.white,
            ),
            label: const Text("Delete Branch",
                style: TextStyle(color: Colors.white, fontSize: Dimens.Title2)),
            backgroundColor: Colors.red,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: const Text("Delete Branch"),
                      children: [
                        for (var branch
                            in _projectDetails.project![0].projectBranches!)
                          SimpleDialogOption(
                            onPressed: () {
                              _projectDetails.deleteBranch(branch.uuid!);
                              Get.offNamed(Applinks.PROJECTS);
                              Navigator.pop(context);
                            },
                            child: Text(branch.kee!),
                          ),
                      ],
                    );
                  });
            },
          ),
        const SizedBox(width: Dimens.margin_16),
        ActionChip(
          avatar: const Icon(
            Icons.cancel_outlined,
            color: Colors.white,
          ),
          label: const Text(
            "Delete Project",
            style: TextStyle(color: Colors.white, fontSize: Dimens.Title2),
          ),
          backgroundColor: Colors.red,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Delete Project"),
                    content: const Text(
                        "Are you sure you want to delete this project?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: () {
                            _projectDetails.deleteProject(
                                _projectDetails.project![0].uuid!);
                            Get.offNamed(Applinks.PROJECTS);
                            Navigator.pop(context);
                          },
                          child: const Text("Delete"))
                    ],
                  );
                });
          },
        ),
        const SizedBox(width: Dimens.margin_16),
      ],
    );
  }
}
