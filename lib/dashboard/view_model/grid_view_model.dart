import 'package:mobx/mobx.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'grid_view_model.g.dart';

class GridViewModel = _GridViewModelBase with _$GridViewModel;

abstract class _GridViewModelBase with Store {
  @observable
  List<DataGridRow>? analysisLogData;
  @observable
  DataGridController? dataGridController;
  @observable
  int? selectedRow;
  @observable
  List<DataGridRow>? selectedRowList;

  @action
  void setAnalysisLogData(List<DataGridRow> analysisLogData) {
    analysisLogData = analysisLogData;
  }

  @action
  void setDataGridController() {
    final DataGridController _dataGridController = DataGridController();
    dataGridController = _dataGridController;
  }

  @action
  void setSelectedRow(int selectedRoW) {
    selectedRow = selectedRoW;
  }

  @action
  void clearSelectedRow() {
    selectedRow = null;
    dataGridController!.selectedRows = [];
  }

  @action
  List<DataGridRow> setSelectedRowsList(
      List<DataGridRow> addedRow, List<DataGridRow> removedRow) {
    selectedRowList = dataGridController!.selectedRows;
    if (addedRow.isNotEmpty) {
      if (selectedRowList!.length > 2) {
        selectedRowList!.removeAt(0);
      }
    } else if (removedRow.isNotEmpty) {
      selectedRowList!.remove(removedRow[0]);
    }
    dataGridController!.selectedRows = [];
    dataGridController!.selectedRows = selectedRowList!;
    return selectedRowList!;
  }

  @action
  void clearSelectedRowsList() {
    selectedRowList = [];
  }
}
