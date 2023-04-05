import 'package:flutter_sonar_app/dashboard/models/projects_model.dart';

class NewProjectModel {
  ProjectsModel? project;

  NewProjectModel({this.project});

  NewProjectModel.fromJson(Map<String, dynamic> json) {
    project = json['project'] != null
        ? new ProjectsModel.fromJson(json['project'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.project != null) {
      data['project'] = this.project!.toJson();
    }
    return data;
  }
}
