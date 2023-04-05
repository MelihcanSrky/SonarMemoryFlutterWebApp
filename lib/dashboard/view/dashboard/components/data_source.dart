import 'package:flutter/material.dart';
import 'package:flutter_sonar_app/dashboard/utils/constants.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../models/analysis_logs.dart';

class ProjectDetailDataSource extends DataGridSource {
  ProjectDetailDataSource({required List<AnalysisLogsModel> analysisLogData}) {
    _analysisLogData = analysisLogData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: "version", value: e.versionName),
              DataGridCell<DateTime>(
                  columnName: "date",
                  value: DateTime.fromMillisecondsSinceEpoch(
                      int.parse(e.createdAt!))),
              DataGridCell<String>(
                  columnName: "bugs",
                  value: e.analysisIssues
                          ?.where((element) =>
                              element.metricUuid ==
                              Constants.metricsList[0].values.first)
                          .first
                          .total
                          .toString() ??
                      "null"),
              DataGridCell<String>(
                  columnName: "vulnerabilities",
                  value: e.analysisIssues
                          ?.where((element) =>
                              element.metricUuid ==
                              Constants.metricsList[1].values.first)
                          .first
                          .total
                          .toString() ??
                      "null"),
              DataGridCell<String>(
                  columnName: "code_smells",
                  value: e.analysisIssues
                          ?.where((element) =>
                              element.metricUuid ==
                              Constants.metricsList[2].values.first)
                          .first
                          .total
                          .toString() ??
                      "null"),
              DataGridCell<String>(
                  columnName: "security_hotspots",
                  value: e.analysisIssues
                          ?.where((element) =>
                              element.metricUuid ==
                              Constants.metricsList[11].values.first)
                          .first
                          .total
                          .toString() ??
                      "null"),
              DataGridCell<String>(
                  columnName: "reliability_rating", value: e.reliability),
              DataGridCell<String>(
                  columnName: "security_rating", value: e.security),
              DataGridCell<String>(
                  columnName: "security_review_rating",
                  value: e.securityReview),
              DataGridCell<String>(columnName: "coverage", value: e.coverage),
              DataGridCell<String>(
                  columnName: "duplication", value: e.duplication),
              DataGridCell<String>(
                  columnName: "cyclomatic", value: e.cyclomatic),
              DataGridCell<String>(columnName: "cognitive", value: e.cognitive),
              DataGridCell<String>(
                  columnName: "version_id", value: e.versionUuid),
            ]))
        .toList();
  }
  List<DataGridRow> _analysisLogData = [];
  @override
  List<DataGridRow> get rows => _analysisLogData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          e.value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList());
  }
}
