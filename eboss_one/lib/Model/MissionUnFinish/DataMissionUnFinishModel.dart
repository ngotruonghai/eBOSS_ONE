class DataMissionUnFinishModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  DataMissionUnFinishModel({this.statusCode, this.description, this.data});

  DataMissionUnFinishModel.fromJson(Map<String, dynamic> json) {
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
  String? workAID;
  String? recordDate;
  Null? recordWorkAllSummaryDate;
  String? workAllSummary;
  String? planStartDate;
  String? consumptionTime;
  String? processWeight;
  String? preFinishDate;
  String? workID;
  String? handlerName;
  String? navigatorName;
  String? receiverName;

  Data(
      {this.workAID,
        this.recordDate,
        this.recordWorkAllSummaryDate,
        this.workAllSummary,
        this.planStartDate,
        this.consumptionTime,
        this.processWeight,
        this.preFinishDate,
        this.workID,
        this.handlerName,
        this.navigatorName,
        this.receiverName});

  Data.fromJson(Map<String, dynamic> json) {
    workAID = json['workAID'];
    recordDate = json['recordDate'];
    recordWorkAllSummaryDate = json['recordWorkAllSummaryDate'];
    workAllSummary = json['workAllSummary'];
    planStartDate = json['planStartDate'];
    consumptionTime = json['consumptionTime'];
    processWeight = json['processWeight'];
    preFinishDate = json['preFinishDate'];
    workID = json['workID'];
    handlerName = json['handlerName'];
    navigatorName = json['navigatorName'];
    receiverName = json['receiverName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['workAID'] = this.workAID;
    data['recordDate'] = this.recordDate;
    data['recordWorkAllSummaryDate'] = this.recordWorkAllSummaryDate;
    data['workAllSummary'] = this.workAllSummary;
    data['planStartDate'] = this.planStartDate;
    data['consumptionTime'] = this.consumptionTime;
    data['processWeight'] = this.processWeight;
    data['preFinishDate'] = this.preFinishDate;
    data['workID'] = this.workID;
    data['handlerName'] = this.handlerName;
    data['navigatorName'] = this.navigatorName;
    data['receiverName'] = this.receiverName;
    return data;
  }
}
