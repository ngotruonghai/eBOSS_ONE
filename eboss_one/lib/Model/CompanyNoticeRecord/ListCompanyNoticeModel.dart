class ListCompanyNoticeModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  ListCompanyNoticeModel({this.statusCode, this.description, this.data});

  ListCompanyNoticeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    description = json['description'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['description'] = this.description;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? companyID;
  String? notificationAbout;
  String? description;
  String? recordDate;
  String? handlerName;
  String? singerName;

  Data(
      {this.companyID,
        this.notificationAbout,
        this.description,
        this.recordDate,
        this.handlerName,
        this.singerName});

  Data.fromJson(Map<String, dynamic> json) {
    companyID = json['companyID'];
    notificationAbout = json['notificationAbout'];
    description = json['description'];
    recordDate = json['recordDate'];
    handlerName = json['handlerName'];
    singerName = json['singerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyID'] = this.companyID;
    data['notificationAbout'] = this.notificationAbout;
    data['description'] = this.description;
    data['recordDate'] = this.recordDate;
    data['handlerName'] = this.handlerName;
    data['singerName'] = this.singerName;
    return data;
  }
}
