class LoginResponseModel {
  int? statusCode;
  String? description;
  Data? data;

  LoginResponseModel({this.statusCode, this.description, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    description = json['description'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['description'] = this.description;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  String? refestToken;
  String? message;
  String? userID;
  String? userName;
  String? employeeAID;

  Data(
      {this.token,
        this.refestToken,
        this.message,
        this.userID,
        this.userName,
        this.employeeAID});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refestToken = json['refestToken'];
    message = json['message'];
    userID = json['userID'];
    userName = json['userName'];
    employeeAID = json['employeeAID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['refestToken'] = this.refestToken;
    data['message'] = this.message;
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['employeeAID'] = this.employeeAID;
    return data;
  }
}
