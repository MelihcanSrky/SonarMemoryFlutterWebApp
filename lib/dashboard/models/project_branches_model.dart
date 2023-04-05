class ProjectBranchesModel {
  List<ProjectBranchesSubModel>? branches;

  ProjectBranchesModel({this.branches});

  ProjectBranchesModel.fromJson(Map<String, dynamic> json) {
    if (json['branches'] != null) {
      branches = <ProjectBranchesSubModel>[];
      json['branches'].forEach((v) {
        branches!.add(new ProjectBranchesSubModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.branches != null) {
      data['branches'] = this.branches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostProjectsBranchesModel {
  ProjectBranchesSubModel? branch;

  PostProjectsBranchesModel({this.branch});

  PostProjectsBranchesModel.fromJson(Map<String, dynamic> json) {
    branch = json['branch'] != null
        ? new ProjectBranchesSubModel.fromJson(json['branch'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    return data;
  }
}

class ProjectBranchesSubModel {
  String? uuid;
  String? projectUuid;
  String? kee;
  String? mergeBranchUuid;
  String? createdAt;
  String? updatedAt;
  bool? deleted;

  ProjectBranchesSubModel(
      {this.uuid,
      this.projectUuid,
      this.kee,
      this.mergeBranchUuid,
      this.createdAt,
      this.updatedAt,
      this.deleted});

  ProjectBranchesSubModel.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    projectUuid = json['project_uuid'];
    kee = json['kee'];
    mergeBranchUuid = json['merge_branch_uuid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deleted = json['deleted'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['project_uuid'] = this.projectUuid;
    data['kee'] = this.kee;
    data['merge_branch_uuid'] = this.mergeBranchUuid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted'] = this.deleted;
    return data;
  }
}
