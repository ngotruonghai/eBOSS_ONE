class DataMissionDetailsModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  DataMissionDetailsModel({this.statusCode, this.description, this.data});

  DataMissionDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? workID;
  String? recordDate;
  String? workAllSummary;
  String? workAllDetails;
  String? employeeName;
  String? progressDescription;
  String? processingDate;
  String? closingDate;
  String? remark;
  String? preFinishDate;
  String? piorityName;
  String? handlerName;
  String? navigatorName;
  String? receiverName;
  String? workInfo;
  String? solutionDescription;
  String? processWeight;
  String? assignStatusName;
  String? projectName;

  Data(
      {this.workAID,
        this.workID,
        this.recordDate,
        this.workAllSummary,
        this.workAllDetails,
        this.employeeName,
        this.progressDescription,
        this.processingDate,
        this.closingDate,
        this.remark,
        this.preFinishDate,
        this.piorityName,
        this.handlerName,
        this.navigatorName,
        this.receiverName,
        this.workInfo,
        this.solutionDescription,
        this.processWeight,
        this.assignStatusName,
        this.projectName});

  Data.fromJson(Map<String, dynamic> json) {
    workAID = json['workAID'];
    workID = json['workID'];
    recordDate = json['recordDate'];
    workAllSummary = json['workAllSummary'];
    workAllDetails = json['workAllDetails'];
    employeeName = json['employeeName'];
    progressDescription = json['progressDescription'];
    processingDate = json['processingDate'];
    closingDate = json['closingDate'];
    remark = json['remark'];
    preFinishDate = json['preFinishDate'];
    piorityName = json['piorityName'];
    handlerName = json['handlerName'];
    navigatorName = json['navigatorName'];
    receiverName = json['receiverName'];
    workInfo = json['workInfo'];
    solutionDescription = json['solutionDescription'];
    processWeight = json['processWeight'];
    assignStatusName = json['assignStatusName'];
    projectName = json['projectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['workAID'] = this.workAID;
    data['workID'] = this.workID;
    data['recordDate'] = this.recordDate;
    data['workAllSummary'] = this.workAllSummary;
    data['workAllDetails'] = this.workAllDetails;
    data['employeeName'] = this.employeeName;
    data['progressDescription'] = this.progressDescription;
    data['processingDate'] = this.processingDate;
    data['closingDate'] = this.closingDate;
    data['remark'] = this.remark;
    data['preFinishDate'] = this.preFinishDate;
    data['piorityName'] = this.piorityName;
    data['handlerName'] = this.handlerName;
    data['navigatorName'] = this.navigatorName;
    data['receiverName'] = this.receiverName;
    data['workInfo'] = this.workInfo;
    data['solutionDescription'] = this.solutionDescription;
    data['processWeight'] = this.processWeight;
    data['assignStatusName'] = this.assignStatusName;
    data['projectName'] = this.projectName;
    return data;
  }
}
