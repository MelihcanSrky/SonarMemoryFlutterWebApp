class WebApiIssuesModel {
  int? total;
  // int? p;
  // int? ps;
  // Paging? paging;
  // int? debt;
  // List<Issues>? issues;
  // List<Components>? components;

  WebApiIssuesModel({
    this.total,
    // this.p,
    // this.ps,
    // this.paging,
    // this.debt,
    // this.issues,
    // this.components
  });

  WebApiIssuesModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    // p = json['p'];
    // ps = json['ps'];
    // paging =
    //     json['paging'] != null ? new Paging.fromJson(json['paging']) : null;
    // debt = json['debt'];
    // if (json['issues'] != null) {
    //   issues = <Issues>[];
    //   json['issues'].forEach((v) {
    //     issues!.add(new Issues.fromJson(v));
    //   });
    // }
    // if (json['components'] != null) {
    //   components = <Components>[];
    //   json['components'].forEach((v) {
    //     components!.add(new Components.fromJson(v));
    //   });
    // }
  }
}

class Paging {
  int? pageIndex;
  int? pageSize;
  int? total;

  Paging({this.pageIndex, this.pageSize, this.total});

  Paging.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    total = json['total'];
  }
}

class Issues {
  String? key;
  String? rule;
  String? severity;
  String? component;
  String? project;
  int? line;
  String? hash;
  String? status;
  String? message;
  String? debt;
  String? author;
  String? type;
  String? scope;

  Issues(
      {this.key,
      this.rule,
      this.severity,
      this.component,
      this.project,
      this.line,
      this.hash,
      this.status,
      this.message,
      this.debt,
      this.author,
      this.type,
      this.scope});

  Issues.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    rule = json['rule'];
    severity = json['severity'];
    component = json['component'];
    project = json['project'];
    line = json['line'];
    hash = json['hash'];
    status = json['status'];
    message = json['message'];
    debt = json['debt'];
    author = json['author'];
    type = json['type'];
    scope = json['scope'];
  }
}

class Components {
  String? key;
  bool? enabled;
  String? name;
  String? path;

  Components({this.key, this.enabled, this.name, this.path});

  Components.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    enabled = json['enabled'];
    name = json['name'];
    path = json['path'];
  }
}
