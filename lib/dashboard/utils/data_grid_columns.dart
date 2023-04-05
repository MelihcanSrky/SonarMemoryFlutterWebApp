import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

late Map<String, double> columnWidths = {
  "versionName": double.nan,
  "bugs": double.nan,
  "date": double.nan,
  "vulnerabilities": double.nan,
  "code_smells": double.nan,
  "security_hotspots": double.nan,
  "reliabilityRating": double.nan,
  "securityRating": double.nan,
  "securityReviewRating": double.nan,
  "coverage": double.nan,
  "duplication": double.nan,
  "cyclomatic": double.nan,
  "cognitive": double.nan,
  "versionId": double.nan,
};

final dataColumns = [
  GridColumn(
    columnName: "version",
    label: buildColumnContainer("Version"),
  ),
  GridColumn(
    columnName: "date",
    label: buildColumnContainer("Date"),
  ),
  GridColumn(
    columnName: "bugs",
    label: buildColumnContainer("Bugs"),
  ),
  GridColumn(
    columnName: "vulnerabilities",
    label: buildColumnContainer("Vulnerabilities"),
  ),
  GridColumn(
    columnName: "code_smells",
    label: buildColumnContainer("Code Smells"),
  ),
  GridColumn(
    columnName: "security_hotspots",
    label: buildColumnContainer("Sec. Hotspots"),
  ),
  GridColumn(
    columnName: "reliability_rating",
    label: buildColumnContainer("Reliability Rating"),
  ),
  GridColumn(
    columnName: "security_rating",
    label: buildColumnContainer("Security Rating"),
  ),
  GridColumn(
    columnName: "security_review_rating",
    label: buildColumnContainer("Sec. Review Rating"),
  ),
  GridColumn(
    columnName: "coverage",
    label: buildColumnContainer("Coverage"),
  ),
  GridColumn(
    columnName: "duplication",
    label: buildColumnContainer("Duplication"),
  ),
  GridColumn(
    columnName: "cyclomatic",
    label: buildColumnContainer("Cycolomatic"),
  ),
  GridColumn(
    columnName: "cognitive",
    label: buildColumnContainer("Cognitive"),
  ),
  GridColumn(
    columnName: "version_id",
    label: buildColumnContainer("Version Id"),
  ),
];

Widget buildColumnContainer(String label) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    alignment: Alignment.center,
    child: Text(
      label,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
