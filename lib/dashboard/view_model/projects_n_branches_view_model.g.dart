// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects_n_branches_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProjectsNBranchesViewModel on _ProjectsNBranchesViewModelBase, Store {
  late final _$sm1ProjectsNBranchesAtom = Atom(
      name: '_ProjectsNBranchesViewModelBase.sm1ProjectsNBranches',
      context: context);

  @override
  List<ProjectsNBranchesModel>? get sm1ProjectsNBranches {
    _$sm1ProjectsNBranchesAtom.reportRead();
    return super.sm1ProjectsNBranches;
  }

  @override
  set sm1ProjectsNBranches(List<ProjectsNBranchesModel>? value) {
    _$sm1ProjectsNBranchesAtom.reportWrite(value, super.sm1ProjectsNBranches,
        () {
      super.sm1ProjectsNBranches = value;
    });
  }

  late final _$sm2ProjectsNBranchesAtom = Atom(
      name: '_ProjectsNBranchesViewModelBase.sm2ProjectsNBranches',
      context: context);

  @override
  List<ProjectsNBranchesModel>? get sm2ProjectsNBranches {
    _$sm2ProjectsNBranchesAtom.reportRead();
    return super.sm2ProjectsNBranches;
  }

  @override
  set sm2ProjectsNBranches(List<ProjectsNBranchesModel>? value) {
    _$sm2ProjectsNBranchesAtom.reportWrite(value, super.sm2ProjectsNBranches,
        () {
      super.sm2ProjectsNBranches = value;
    });
  }

  late final _$getProjectsNBranchesAsyncAction = AsyncAction(
      '_ProjectsNBranchesViewModelBase.getProjectsNBranches',
      context: context);

  @override
  Future<void> getProjectsNBranches() {
    return _$getProjectsNBranchesAsyncAction
        .run(() => super.getProjectsNBranches());
  }

  @override
  String toString() {
    return '''
sm1ProjectsNBranches: ${sm1ProjectsNBranches},
sm2ProjectsNBranches: ${sm2ProjectsNBranches}
    ''';
  }
}
