import 'package:flutter_sonar_app/dashboard/models/projects_n_branches_model.dart';
import 'package:flutter_sonar_app/service/sonar_memory_api_service.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
part 'projects_n_branches_view_model.g.dart';

class ProjectsNBranchesViewModel = _ProjectsNBranchesViewModelBase
    with _$ProjectsNBranchesViewModel;

abstract class _ProjectsNBranchesViewModelBase with Store {
  @observable
  List<ProjectsNBranchesModel>? sm1ProjectsNBranches;
  @observable
  List<ProjectsNBranchesModel>? sm2ProjectsNBranches;

  @action
  Future<void> getProjectsNBranches() async {
    sm1ProjectsNBranches =
        await SonarMemoryApiService().getProjectsNBranches("sonarmemory", null);
    sm2ProjectsNBranches = await SonarMemoryApiService()
        .getProjectsNBranches("sonarmemory2", null);
  }
}
