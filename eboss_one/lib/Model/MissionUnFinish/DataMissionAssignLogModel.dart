class DataMissionAssignLogModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  DataMissionAssignLogModel({this.statusCode, this.description, this.data});

  DataMissionAssignLogModel.fromJson(Map<String, dynamic> json) {
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
  String? reportID;
  String? recordDate;
  String? handlerName;
  String? workStatusName;
  String? description;
  String? finishPercent;
  String? startTime;
  String? endTime;
  String? remark;

  Data(
      {this.reportID,
        this.recordDate,
        this.handlerName,
        this.workStatusName,
        this.description,
        this.finishPercent,
        this.startTime,
        this.endTime,
        this.remark});

  Data.fromJson(Map<String, dynamic> json) {
    reportID = json['reportID'];
    recordDate = json['recordDate'];
    handlerName = json['handlerName'];
    workStatusName = json['workStatusName'];
    description = json['description'];
    finishPercent = json['finishPercent'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reportID'] = this.reportID;
    data['recordDate'] = this.recordDate;
    data['handlerName'] = this.handlerName;
    data['workStatusName'] = this.workStatusName;
    data['description'] = this.description;
    data['finishPercent'] = this.finishPercent;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['remark'] = this.remark;
    return data;
  }
}
