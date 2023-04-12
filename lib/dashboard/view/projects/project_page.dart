import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_sonar_app/dashboard/utils/responsive.dart';
import 'package:flutter_sonar_app/dashboard/view/main_page.dart';
import 'package:flutter_sonar_app/dashboard/view/projects/components/projects_grid_view.dart';
import 'package:flutter_sonar_app/dashboard/widgets/scaffold_body.dart';

import '../../controllers/main_screen_controller.dart';
import '../../utils/dimens.dart';
import '../../utils/strings.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  void initState() {
    super.initState();
    store.changeRoute(Applinks.PROJECTS);
    store.projectNBranchesVM.getProjectsNBranches();
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
        flex: 4,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      Strings.allProjects,
                      style: TextStyle(fontSize: Dimens.Title1),
                    ),
                    IconButton(
                        onPressed: () {
                          store.projectNBranchesVM.getProjectsNBranches();
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                ),
                Observer(builder: (_) {
                  if (store.projectNBranchesVM.sm1ProjectsNBranches == null ||
                      store.projectNBranchesVM.sm2ProjectsNBranches == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Responsive(
                      mobile: ProjectsGridView(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      tablet: ProjectsGridView(),
                      desktop: ProjectsGridView(
                        crossAxisCount: 4,
                        childAspectRatio: 1.6,
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        ));
  }
}
