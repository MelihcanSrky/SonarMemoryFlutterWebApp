import 'analysis_issues.dart';

class AnalysisLogsPostModel {
  AnalysisLogsModel? analysisLog;

  AnalysisLogsPostModel({
    this.analysisLog,
  });

  factory AnalysisLogsPostModel.fromJson(Map<String, dynamic> json) =>
      AnalysisLogsPostModel(
        analysisLog: AnalysisLogsModel.fromJson(json["analysisLogs"]),
      );

  Map<String, dynamic> toJson() => {
        "analysisLogs": analysisLog!.toJson(),
      };
}

class AnalysisLogsModel {
  final String? analysisUuid;
  final String? projectUuid;
  final String? versionUuid;
  final String? versionName;
  final String? createdAt;
  final double? lines;
  final String? reliability;
  final String? security;
  final String? securityReview;
  final String? coverage;
  final String? duplication;
  final String? cyclomatic;
  final String? cognitive;
  final String? commitNo;
  final bool? deleted;
  final List<AnalysisIssuesModel>? analysisIssues;

  AnalysisLogsModel({
    this.analysisUuid,
    this.projectUuid,
    this.versionUuid,
    this.versionName,
    this.createdAt,
    this.lines,
    this.reliability,
    this.security,
    this.securityReview,
    this.coverage,
    this.duplication,
    this.cyclomatic,
    this.cognitive,
    this.analysisIssues,
    this.commitNo,
    this.deleted,
  });

  factory AnalysisLogsModel.fromJson(Map<String, dynamic> json) =>
      AnalysisLogsModel(
        analysisUuid: json["analysis_id"],
        projectUuid: json["project_uuid"],
        versionUuid: json["version_id"],
        versionName: json["version_name"],
        createdAt: json["created_at"],
        lines: double.parse(json["lines"].toString()),
        reliability: json["reliability"],
        security: json["security"],
        securityReview: json["security_review"],
        coverage: json["coverage"],
        duplication: json["duplicated"],
        cyclomatic: json["cyclomatic"],
        cognitive: json["cognitive"],
        commitNo: json["commit_no"],
        deleted: json["deleted"],
        analysisIssues: List<AnalysisIssuesModel>.from(
            json["analysisIssues"].map((x) => AnalysisIssuesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "analysis_id": analysisUuid,
        "project_uuid": projectUuid,
        "version_id": versionUuid,
        "version_name": versionName,
        "created_at": createdAt,
        "lines": lines,
        "reliability": reliability,
        "security": security,
        "security_review": securityReview,
        "coverage": coverage,
        "duplicated": duplication,
        "cyclomatic": cyclomatic,
        "cognitive": cognitive,
        "commit_no": commitNo,
        "deleted": deleted,
      };
}
