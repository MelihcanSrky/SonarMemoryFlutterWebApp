import 'package:flutter_sonar_app/dashboard/models/project_branches_model.dart';

class ProjectsNBranchesModel {
  String? uuid;
  String? kee;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? versionId;
  List<ProjectBranchesSubModel>? projectBranches;

  ProjectsNBranchesModel({
    this.uuid,
    this.kee,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.versionId,
    this.projectBranches,
  });

  factory ProjectsNBranchesModel.fromJson(Map<String, dynamic> json) =>
      ProjectsNBranchesModel(
        uuid: json["uuid"],
        kee: json["kee"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        versionId: json["version_id"],
        projectBranches: List<ProjectBranchesSubModel>.from(
            json["projectBranches"]
                .map((x) => ProjectBranchesSubModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "kee": kee,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "version_id": versionId,
        "projectBranches":
            List<dynamic>.from(projectBranches!.map((x) => x.toJson())),
      };
}
