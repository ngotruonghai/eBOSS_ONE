class MobileInfoModel {
  int? statusCode;
  String? description;
  Data? data;

  MobileInfoModel({this.statusCode, this.description, this.data});

  MobileInfoModel.fromJson(Map<String, dynamic> json) {
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
  String? statusApp;
  String? version;
  String? environment;
  String? updateDate;

  Data({this.statusApp, this.version, this.environment, this.updateDate});

  Data.fromJson(Map<String, dynamic> json) {
    statusApp = json['statusApp'];
    version = json['version'];
    environment = json['environment'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusApp'] = this.statusApp;
    data['version'] = this.version;
    data['environment'] = this.environment;
    data['updateDate'] = this.updateDate;
    return data;
  }
}
