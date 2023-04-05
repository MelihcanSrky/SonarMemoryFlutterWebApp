class IssuesModel {
  String? kee;
  String? severity;
  String? projectUuid;
  String? status;

  IssuesModel({
    this.kee,
    this.severity,
    this.projectUuid,
    this.status,
  });

  factory IssuesModel.fromJson(Map<String, dynamic> json) => IssuesModel(
        kee: json["kee"],
        severity: json["severity"],
        projectUuid: json["project_uuid"],
        status: json["status"],
      );
}
