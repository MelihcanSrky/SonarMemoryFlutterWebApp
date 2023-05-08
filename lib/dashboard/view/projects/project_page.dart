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
      body: SingleChildScrollView(
        child: ScaffoldBody(
          middleBlock: buildMiddleContainerBlock(context),
        ),
      ),
    );
  }

  Flexible buildMiddleContainerBlock(BuildContext context) {
    return Flexible(
        flex: 4,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Observer(builder: (_) {
                    return Row(
                      children: [
                        const Text(
                          Strings.allProjects,
                          style: TextStyle(fontSize: Dimens.Title1),
                        ),
                        if (store.projectNBranchesVM.isFetchLoading!)
                          const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(),
                              ))
                        else
                          IconButton(
                              onPressed: () {
                                store.projectNBranchesVM.getProjectsNBranches();
                              },
                              icon: const Icon(Icons.refresh)),
                      ],
                    );
                  }),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  Flexible(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: Strings.search,
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        store.projectNBranchesVM.filterProjects(value);
                      },
                    ),
                  ),
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
        ));
  }
}
