class MeasuresModel {
  String? uuid;
  String? projectUuid;
  String? metricUuid;
  String? value;
  String? text_value;

  MeasuresModel({
    this.uuid,
    this.projectUuid,
    this.metricUuid,
    this.value,
    this.text_value,
  });

  factory MeasuresModel.fromJson(Map<String, dynamic> json) => MeasuresModel(
        uuid: json["uuid"],
        projectUuid: json["project_uuid"],
        metricUuid: json["metric_uuid"],
        value: json["value"],
        text_value: json["text_value"],
      );
}
