class TypesModel {
  SeveritiesModel bugs;
  SeveritiesModel vulnerabilities;
  SeveritiesModel codeSmells;

  TypesModel(
      {required this.bugs,
      required this.vulnerabilities,
      required this.codeSmells});

  factory TypesModel.fromJson(Map<String, dynamic> json) {
    return TypesModel(
      bugs: SeveritiesModel.fromJson(json['bugs']),
      vulnerabilities: SeveritiesModel.fromJson(json['vulnerabilities']),
      codeSmells: SeveritiesModel.fromJson(json['codeSmells']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bugs': bugs.toJson(),
      'vulnerabilities': vulnerabilities.toJson(),
      'codeSmells': codeSmells.toJson(),
    };
  }
}

class SeveritiesModel {
  int? major, minor, blocker, critical;

  SeveritiesModel({this.major, this.minor, this.blocker, this.critical});

  factory SeveritiesModel.fromJson(Map<String, dynamic> json) {
    return SeveritiesModel(
      major: json['major'],
      minor: json['minor'],
      blocker: json['blocker'],
      critical: json['critical'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'major': major,
      'minor': minor,
      'blocker': blocker,
      'critical': critical,
    };
  }
}
