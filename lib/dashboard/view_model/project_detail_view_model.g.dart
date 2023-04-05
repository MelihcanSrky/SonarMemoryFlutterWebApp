// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProjectDetailViewModel on _ProjectDetailViewModelBase, Store {
  late final _$projectLogsAtom =
      Atom(name: '_ProjectDetailViewModelBase.projectLogs', context: context);

  @override
  List<ProjectLogSubModel>? get projectLogs {
    _$projectLogsAtom.reportRead();
    return super.projectLogs;
  }

  @override
  set projectLogs(List<ProjectLogSubModel>? value) {
    _$projectLogsAtom.reportWrite(value, super.projectLogs, () {
      super.projectLogs = value;
    });
  }

  late final _$projectAtom =
      Atom(name: '_ProjectDetailViewModelBase.project', context: context);

  @override
  List<ProjectsNBranchesModel>? get project {
    _$projectAtom.reportRead();
    return super.project;
  }

  @override
  set project(List<ProjectsNBranchesModel>? value) {
    _$projectAtom.reportWrite(value, super.project, () {
      super.project = value;
    });
  }

  late final _$projectBranchesAtom = Atom(
      name: '_ProjectDetailViewModelBase.projectBranches', context: context);

  @override
  List<ProjectBranchesSubModel>? get projectBranches {
    _$projectBranchesAtom.reportRead();
    return super.projectBranches;
  }

  @override
  set projectBranches(List<ProjectBranchesSubModel>? value) {
    _$projectBranchesAtom.reportWrite(value, super.projectBranches, () {
      super.projectBranches = value;
    });
  }

  late final _$branchUuidAtom =
      Atom(name: '_ProjectDetailViewModelBase.branchUuid', context: context);

  @override
  String? get branchUuid {
    _$branchUuidAtom.reportRead();
    return super.branchUuid;
  }

  @override
  set branchUuid(String? value) {
    _$branchUuidAtom.reportWrite(value, super.branchUuid, () {
      super.branchUuid = value;
    });
  }

  late final _$analysisIssuesAtom = Atom(
      name: '_ProjectDetailViewModelBase.analysisIssues', context: context);

  @override
  List<AnalysisIssuesModel>? get analysisIssues {
    _$analysisIssuesAtom.reportRead();
    return super.analysisIssues;
  }

  @override
  set analysisIssues(List<AnalysisIssuesModel>? value) {
    _$analysisIssuesAtom.reportWrite(value, super.analysisIssues, () {
      super.analysisIssues = value;
    });
  }

  late final _$analysisLogsAtom =
      Atom(name: '_ProjectDetailViewModelBase.analysisLogs', context: context);

  @override
  List<AnalysisLogsModel>? get analysisLogs {
    _$analysisLogsAtom.reportRead();
    return super.analysisLogs;
  }

  @override
  set analysisLogs(List<AnalysisLogsModel>? value) {
    _$analysisLogsAtom.reportWrite(value, super.analysisLogs, () {
      super.analysisLogs = value;
    });
  }

  late final _$isProjectLoadingAtom = Atom(
      name: '_ProjectDetailViewModelBase.isProjectLoading', context: context);

  @override
  bool? get isProjectLoading {
    _$isProjectLoadingAtom.reportRead();
    return super.isProjectLoading;
  }

  @override
  set isProjectLoading(bool? value) {
    _$isProjectLoadingAtom.reportWrite(value, super.isProjectLoading, () {
      super.isProjectLoading = value;
    });
  }

  late final _$getSingleProjectAsyncAction = AsyncAction(
      '_ProjectDetailViewModelBase.getSingleProject',
      context: context);

  @override
  Future<void> getSingleProject(String projectUuid) {
    return _$getSingleProjectAsyncAction
        .run(() => super.getSingleProject(projectUuid));
  }

  late final _$getAnalysisLogsAsyncAction = AsyncAction(
      '_ProjectDetailViewModelBase.getAnalysisLogs',
      context: context);

  @override
  Future<void> getAnalysisLogs(String projectUuid) {
    return _$getAnalysisLogsAsyncAction
        .run(() => super.getAnalysisLogs(projectUuid));
  }

  late final _$deleteProjectAsyncAction = AsyncAction(
      '_ProjectDetailViewModelBase.deleteProject',
      context: context);

  @override
  Future<void> deleteProject(String projectUuid) {
    return _$deleteProjectAsyncAction
        .run(() => super.deleteProject(projectUuid));
  }

  late final _$deleteBranchAsyncAction =
      AsyncAction('_ProjectDetailViewModelBase.deleteBranch', context: context);

  @override
  Future<void> deleteBranch(String branchUuid) {
    return _$deleteBranchAsyncAction.run(() => super.deleteBranch(branchUuid));
  }

  late final _$deleteAnalysisLogsAsyncAction = AsyncAction(
      '_ProjectDetailViewModelBase.deleteAnalysisLogs',
      context: context);

  @override
  Future<void> deleteAnalysisLogs(String analysisUuid) {
    return _$deleteAnalysisLogsAsyncAction
        .run(() => super.deleteAnalysisLogs(analysisUuid));
  }

  late final _$_ProjectDetailViewModelBaseActionController =
      ActionController(name: '_ProjectDetailViewModelBase', context: context);

  @override
  void setBranchUuid(String uuid) {
    final _$actionInfo = _$_ProjectDetailViewModelBaseActionController
        .startAction(name: '_ProjectDetailViewModelBase.setBranchUuid');
    try {
      return super.setBranchUuid(uuid);
    } finally {
      _$_ProjectDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
projectLogs: ${projectLogs},
project: ${project},
projectBranches: ${projectBranches},
branchUuid: ${branchUuid},
analysisIssues: ${analysisIssues},
analysisLogs: ${analysisLogs},
isProjectLoading: ${isProjectLoading}
    ''';
  }
}
