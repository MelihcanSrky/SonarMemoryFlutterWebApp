class AnalysisIssuesPostModel {
  List<AnalysisIssuesModel>? analysisIssues;

  AnalysisIssuesPostModel({
    this.analysisIssues,
  });

  factory AnalysisIssuesPostModel.fromJson(Map<String, dynamic> json) =>
      AnalysisIssuesPostModel(
        analysisIssues: List<AnalysisIssuesModel>.from(
            json["issuesList"].map((x) => AnalysisIssuesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "issuesList":
            List<dynamic>.from(analysisIssues!.map((x) => x.toJson())),
      };
}

class AnalysisIssuesModel {
  final String? analysisUuid;
  final String? metricUuid;
  final String? major;
  final String? minor;
  final String? blocker;
  final String? critical;
  final String? total;

  AnalysisIssuesModel({
    this.analysisUuid,
    this.metricUuid,
    this.major,
    this.minor,
    this.blocker,
    this.critical,
    this.total,
  });

  factory AnalysisIssuesModel.fromJson(Map<String, dynamic> json) =>
      AnalysisIssuesModel(
          analysisUuid: json["analysis_id"],
          metricUuid: json["metric_uuid"],
          major: json["major"],
          minor: json["minor"],
          blocker: json["blocker"],
          critical: json["critical"],
          total: json["total"]);

  Map<String, dynamic> toJson() => {
        "analysis_id": analysisUuid,
        "metric_uuid": metricUuid,
        "major": major,
        "minor": minor,
        "blocker": blocker,
        "critical": critical,
        "total": total
      };
}
