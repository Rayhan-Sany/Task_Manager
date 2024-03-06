import 'package:task_manager/data/models/user_data.dart';

class LoginResponse {
  String? status;
  String? token;
  UserData? userData;

  LoginResponse({this.status, this.token, this.userData});
  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    userData = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.userData != null) {
      data['data'] = this.userData!.toJson();
    }
    return data;
  }
}

