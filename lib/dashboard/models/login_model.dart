class LoginModel {
  bool? status;

  LoginModel({this.status});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }
}

class ValidModel {
  bool? valid;

  ValidModel({this.valid});

  ValidModel.fromJson(Map<String, dynamic> json) {
    valid = json['valid'];
  }
}
