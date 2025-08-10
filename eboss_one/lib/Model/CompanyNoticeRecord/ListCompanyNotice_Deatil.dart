class ListCompanyNotice_Deatil {
  int? statusCode;
  String? description;
  List<Data>? data;

  ListCompanyNotice_Deatil({this.statusCode, this.description, this.data});

  ListCompanyNotice_Deatil.fromJson(Map<String, dynamic> json) {
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
  String? notificationAID;
  String? notificationID;
  String? recordDate;
  String? typeID;
  String? companyID;
  String? notificationAbout;
  String? description;
  String? preFinishDate;
  String? finishDate;
  String? closedDate;
  String? handlerAID;
  String? handlerName;
  String? signerAID;
  String? singerName;
  Null? remark;

  Data(
      {this.notificationAID,
        this.notificationID,
        this.recordDate,
        this.typeID,
        this.companyID,
        this.notificationAbout,
        this.description,
        this.preFinishDate,
        this.finishDate,
        this.closedDate,
        this.handlerAID,
        this.handlerName,
        this.signerAID,
        this.singerName,
        this.remark});

  Data.fromJson(Map<String, dynamic> json) {
    notificationAID = json['NotificationAID'];
    notificationID = json['NotificationID'];
    recordDate = json['RecordDate'];
    typeID = json['TypeID'];
    companyID = json['CompanyID'];
    notificationAbout = json['NotificationAbout'];
    description = json['Description'];
    preFinishDate = json['PreFinishDate'];
    finishDate = json['FinishDate'];
    closedDate = json['ClosedDate'];
    handlerAID = json['HandlerAID'];
    handlerName = json['HandlerName'];
    signerAID = json['SignerAID'];
    singerName = json['SingerName'];
    remark = json['Remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NotificationAID'] = this.notificationAID;
    data['NotificationID'] = this.notificationID;
    data['RecordDate'] = this.recordDate;
    data['TypeID'] = this.typeID;
    data['CompanyID'] = this.companyID;
    data['NotificationAbout'] = this.notificationAbout;
    data['Description'] = this.description;
    data['PreFinishDate'] = this.preFinishDate;
    data['FinishDate'] = this.finishDate;
    data['ClosedDate'] = this.closedDate;
    data['HandlerAID'] = this.handlerAID;
    data['HandlerName'] = this.handlerName;
    data['SignerAID'] = this.signerAID;
    data['SingerName'] = this.singerName;
    data['Remark'] = this.remark;
    return data;
  }
}
