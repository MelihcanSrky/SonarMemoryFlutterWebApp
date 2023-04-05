class ProjectLogModel {
  ProjectLogSubModel? project_logs;

  ProjectLogModel({
    this.project_logs,
  });

  factory ProjectLogModel.fromJson(Map<String, dynamic> json) =>
      ProjectLogModel(
        project_logs: ProjectLogSubModel.fromJson(json["project_logs"]),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.project_logs != null) {
      data['project_logs'] = this.project_logs!.toJson();
    }
    return data;
  }
}

class ProjectLogSubModel {
  String? uuid;
  String? projectUuid;
  String? versionId;
  String? versionName;
  double? blocker;
  double? critical;
  double? major;
  double? minor;
  double? bugs;
  double? vulnerabilities;
  double? codeSmells;
  String? reliabilityRating;
  String? securityRating;
  String? securityReviewRating;
  String? maintainabilityRating;
  double? securityHotspots;

  ProjectLogSubModel({
    this.uuid,
    this.projectUuid,
    this.versionId,
    this.versionName,
    this.blocker,
    this.critical,
    this.major,
    this.minor,
    this.bugs,
    this.vulnerabilities,
    this.codeSmells,
    this.reliabilityRating,
    this.securityRating,
    this.securityReviewRating,
    this.maintainabilityRating,
    this.securityHotspots,
  });

  factory ProjectLogSubModel.fromJson(Map<String, dynamic> json) =>
      ProjectLogSubModel(
        uuid: json["uuid"],
        projectUuid: json["project_uuid"],
        versionId: json["version_id"],
        versionName: json["version_name"],
        blocker: double.parse(json["blocker"].toString()),
        critical: double.parse(json["critical"].toString()),
        major: double.parse(json["major"].toString()),
        minor: double.parse(json["minor"].toString()),
        bugs: double.parse(json["bugs"].toString()),
        vulnerabilities: double.parse(json["vulnerabilites"].toString()),
        codeSmells: double.parse(json["code_smells"].toString()),
        reliabilityRating: json["reliability"],
        securityRating: json["security"],
        securityReviewRating: json["security_review"],
        maintainabilityRating: json["maintainability"],
        securityHotspots: double.parse(json["security_hotspots"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "project_uuid": projectUuid,
        "version_id": versionId,
        "version_name": versionName,
        "blocker": blocker,
        "critical": critical,
        "major": major,
        "minor": minor,
        "bugs": bugs,
        "vulnerabilites": vulnerabilities,
        "code_smells": codeSmells,
        "reliability": reliabilityRating,
        "security": securityRating,
        "security_review": securityReviewRating,
        "maintainability": maintainabilityRating,
        "security_hotspots": securityHotspots,
      };
}
