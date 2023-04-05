import 'package:mobx/mobx.dart';
import 'grid_view_model.dart';
import 'new_project_view_model.dart';
import 'project_detail_view_model.dart';
import 'projects_n_branches_view_model.dart';
part 'base_view_model.g.dart';

class BaseViewModel = _BaseViewModelBase with _$BaseViewModel;

abstract class _BaseViewModelBase with Store {
  final projectDetails = ProjectDetailViewModel();
  final newProjectVM = NewProjectViewModel();
  final gridVM = GridViewModel();
  final projectNBranchesVM = ProjectsNBranchesViewModel();

  @observable
  bool? isDarkMode;

  @action
  void init() {
    if (isDarkMode == null) {
      isDarkMode = false;
    }
  }

  @action
  void changeTheme() {
    isDarkMode = !isDarkMode!;
  }
}
