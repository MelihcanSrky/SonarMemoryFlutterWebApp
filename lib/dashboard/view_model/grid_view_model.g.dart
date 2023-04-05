// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grid_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GridViewModel on _GridViewModelBase, Store {
  late final _$analysisLogDataAtom =
      Atom(name: '_GridViewModelBase.analysisLogData', context: context);

  @override
  List<DataGridRow>? get analysisLogData {
    _$analysisLogDataAtom.reportRead();
    return super.analysisLogData;
  }

  @override
  set analysisLogData(List<DataGridRow>? value) {
    _$analysisLogDataAtom.reportWrite(value, super.analysisLogData, () {
      super.analysisLogData = value;
    });
  }

  late final _$dataGridControllerAtom =
      Atom(name: '_GridViewModelBase.dataGridController', context: context);

  @override
  DataGridController? get dataGridController {
    _$dataGridControllerAtom.reportRead();
    return super.dataGridController;
  }

  @override
  set dataGridController(DataGridController? value) {
    _$dataGridControllerAtom.reportWrite(value, super.dataGridController, () {
      super.dataGridController = value;
    });
  }

  late final _$selectedRowAtom =
      Atom(name: '_GridViewModelBase.selectedRow', context: context);

  @override
  int? get selectedRow {
    _$selectedRowAtom.reportRead();
    return super.selectedRow;
  }

  @override
  set selectedRow(int? value) {
    _$selectedRowAtom.reportWrite(value, super.selectedRow, () {
      super.selectedRow = value;
    });
  }

  late final _$selectedRowListAtom =
      Atom(name: '_GridViewModelBase.selectedRowList', context: context);

  @override
  List<DataGridRow>? get selectedRowList {
    _$selectedRowListAtom.reportRead();
    return super.selectedRowList;
  }

  @override
  set selectedRowList(List<DataGridRow>? value) {
    _$selectedRowListAtom.reportWrite(value, super.selectedRowList, () {
      super.selectedRowList = value;
    });
  }

  late final _$_GridViewModelBaseActionController =
      ActionController(name: '_GridViewModelBase', context: context);

  @override
  void setAnalysisLogData(List<DataGridRow> analysisLogData) {
    final _$actionInfo = _$_GridViewModelBaseActionController.startAction(
        name: '_GridViewModelBase.setAnalysisLogData');
    try {
      return super.setAnalysisLogData(analysisLogData);
    } finally {
      _$_GridViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDataGridController() {
    final _$actionInfo = _$_GridViewModelBaseActionController.startAction(
        name: '_GridViewModelBase.setDataGridController');
    try {
      return super.setDataGridController();
    } finally {
      _$_GridViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedRow(int selectedRoW) {
    final _$actionInfo = _$_GridViewModelBaseActionController.startAction(
        name: '_GridViewModelBase.setSelectedRow');
    try {
      return super.setSelectedRow(selectedRoW);
    } finally {
      _$_GridViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSelectedRow() {
    final _$actionInfo = _$_GridViewModelBaseActionController.startAction(
        name: '_GridViewModelBase.clearSelectedRow');
    try {
      return super.clearSelectedRow();
    } finally {
      _$_GridViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<DataGridRow> setSelectedRowsList(
      List<DataGridRow> addedRow, List<DataGridRow> removedRow) {
    final _$actionInfo = _$_GridViewModelBaseActionController.startAction(
        name: '_GridViewModelBase.setSelectedRowsList');
    try {
      return super.setSelectedRowsList(addedRow, removedRow);
    } finally {
      _$_GridViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSelectedRowsList() {
    final _$actionInfo = _$_GridViewModelBaseActionController.startAction(
        name: '_GridViewModelBase.clearSelectedRowsList');
    try {
      return super.clearSelectedRowsList();
    } finally {
      _$_GridViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
analysisLogData: ${analysisLogData},
dataGridController: ${dataGridController},
selectedRow: ${selectedRow},
selectedRowList: ${selectedRowList}
    ''';
  }
}
