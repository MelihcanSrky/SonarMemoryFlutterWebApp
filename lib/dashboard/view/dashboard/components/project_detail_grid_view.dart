import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_sonar_app/dashboard/utils/data_grid_columns.dart';
import 'package:flutter_sonar_app/dashboard/view/main_page.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../../helpers/save_file_web.dart' as helper;
import '../../../utils/strings.dart';
import 'data_source.dart';

class ProjectDetailGridView extends StatefulWidget {
  final String? projectUuid;
  final String? branchKee;
  const ProjectDetailGridView({this.projectUuid, this.branchKee, super.key});

  @override
  State<ProjectDetailGridView> createState() => _ProjectDetailGridViewState();
}

class _ProjectDetailGridViewState extends State<ProjectDetailGridView> {
  GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  late ProjectDetailDataSource _projectDetailDataSource;
  final _projectDetails = store.projectDetails;
  final _gridVM = store.gridVM;

  @override
  void initState() {
    super.initState();
    _projectDetails.setBranchUuid(widget.projectUuid!);
    _projectDetails.getAnalysisLogs(widget.projectUuid!);
    _gridVM.clearSelectedRowsList();
    _projectDetailDataSource = ProjectDetailDataSource(
      analysisLogData: _projectDetails.analysisLogs ?? [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Observer(builder: (_) {
        if (_projectDetails.analysisLogs == null) {
          _projectDetails.getAnalysisLogs(widget.projectUuid!);
          return const SafeArea(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (_projectDetails.analysisLogs!.isNotEmpty) {
          _projectDetailDataSource = ProjectDetailDataSource(
            analysisLogData: _projectDetails.analysisLogs ?? [],
          );
          return SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TextButton(
                        child: const Text(Strings.selectDate),
                        onPressed: () {
                          _showDialog(context);
                        },
                      ),
                      TextButton(
                        child: const Text(Strings.clearFilters),
                        onPressed: () {
                          _projectDetailDataSource.clearFilters();
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                          child: const Text(Strings.exportPDF),
                          onPressed: () async {
                            final PdfDocument? document = _key.currentState
                                ?.exportToPdfDocument(
                                    headerFooterExport:
                                        (DataGridPdfHeaderFooterExportDetails
                                            headerFooterExport) {
                                      final double width = headerFooterExport
                                          .pdfPage
                                          .getClientSize()
                                          .width;
                                      final PdfPageTemplateElement header =
                                          PdfPageTemplateElement(
                                              Rect.fromLTWH(0, 0, width, 65));
                                      header.graphics.drawString(
                                        'Analysis Logs',
                                        PdfStandardFont(
                                            PdfFontFamily.helvetica, 13,
                                            style: PdfFontStyle.bold),
                                        bounds:
                                            const Rect.fromLTWH(0, 25, 200, 60),
                                      );
                                      headerFooterExport
                                          .pdfDocumentTemplate.top = header;
                                    },
                                    excludeColumns: ['versionId'],
                                    fitAllColumnsInOnePage: true,
                                    rows: (store.gridVM.dataGridController!
                                                .selectedRows.length >
                                            1)
                                        ? store.gridVM.dataGridController!
                                            .selectedRows
                                        : null,
                                    exportTableSummaries: false);
                            if (document != null) {
                              final List<int> bytes = document.saveSync();
                              await helper.FileSaveHelper.saveAndLaunchFile(
                                  bytes, 'DataGrid.pdf');
                              document.dispose();
                            }
                          }),
                      TextButton(
                        child: const Text(
                          Strings.deleteRows,
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () async {
                          if (_gridVM
                              .dataGridController!.selectedRows.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please select a row to delete"),
                              ),
                            );
                          } else {
                            buildShowDialog(context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Container(child: buildDataGrid()),
            ],
          ));
        } else if (_projectDetails.analysisLogs!.isEmpty) {
          _projectDetails.getAnalysisLogs(widget.projectUuid!);
          return const SafeArea(
            child: Center(
              child: Text(Strings.noData),
            ),
          );
        } else {
          _projectDetails.getAnalysisLogs(widget.projectUuid!);
          return const SafeArea(
            child: Center(
              child: Text(Strings.serverError),
            ),
          );
        }
      }),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete"),
            content: const Text("Are you sure you want to delete?"),
            actions: [
              TextButton(
                child: const Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("Yes"),
                onPressed: () async {
                  for (var i = 0;
                      i < _gridVM.dataGridController!.selectedRows.length;
                      i++) {
                    final _analysisUuid = _projectDetails.analysisLogs!
                        .where((element) =>
                            element.versionUuid ==
                            _gridVM.dataGridController!.selectedRows[i]
                                .getCells()[13]
                                .value
                                .toString())
                        .first
                        .analysisUuid
                        .toString();
                    await _projectDetails.deleteAnalysisLogs(_analysisUuid);
                  }
                  _projectDetails.getAnalysisLogs(widget.projectUuid!);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _showDialog(BuildContext context) async {
    await showDialog<void>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: buildDatePicker(context))
            ],
          );
        });
  }

  SfDateRangePicker buildDatePicker(BuildContext context) {
    return SfDateRangePicker(
      view: DateRangePickerView.month,
      monthViewSettings:
          const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
      allowViewNavigation: true,
      navigationMode: DateRangePickerNavigationMode.scroll,
      navigationDirection: DateRangePickerNavigationDirection.vertical,
      selectionMode: DateRangePickerSelectionMode.extendableRange,
      extendableRangeSelectionDirection:
          ExtendableRangeSelectionDirection.forward,
      confirmText: "APPLY",
      showActionButtons: true,
      onCancel: () {
        Navigator.pop(context);
      },
      onSubmit: (value) {
        if (value is PickerDateRange) {
          _projectDetailDataSource.addFilter(
            'date',
            FilterCondition(
              value: DateTime(value.startDate!.year, value.startDate!.month,
                  value.startDate!.day),
              filterOperator: FilterOperator.and,
              type: FilterType.greaterThanOrEqual,
            ),
          );

          _projectDetailDataSource.addFilter(
            'date',
            FilterCondition(
              value: DateTime(value.endDate!.year, value.endDate!.month,
                  value.endDate!.day),
              filterOperator: FilterOperator.and,
              type: FilterType.lessThanOrEqual,
            ),
          );
        }
        Navigator.pop(context);
      },
    );
  }

  SfDataGrid buildDataGrid() {
    return SfDataGrid(
        key: _key,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        source: _projectDetailDataSource,
        columnWidthMode: ColumnWidthMode.lastColumnFill,
        showCheckboxColumn: true,
        selectionMode: SelectionMode.multiple,
        allowSorting: true,
        allowTriStateSorting: true,
        allowMultiColumnSorting: true,
        allowFiltering: true,
        controller: _gridVM.dataGridController,
        onSelectionChanged: (addedRows, removedRows) {
          _gridVM.dataGridController!.selectedRows =
              _gridVM.setSelectedRowsList(addedRows, removedRows);
        },
        columns: dataColumns);
  }
}
