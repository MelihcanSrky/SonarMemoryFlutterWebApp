class ProjectsModel {
  String? uuid;
  String? kee;
  String? name;
  String? createdAt;
  String? updatedAt;
  bool? deleted;

  ProjectsModel({
    this.uuid,
    this.kee,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deleted,
  });

  factory ProjectsModel.fromJson(Map<String, dynamic> json) => ProjectsModel(
        uuid: json["uuid"],
        kee: json["kee"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deleted: json["deleted"] as bool,
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "kee": kee,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted": deleted,
      };
}
