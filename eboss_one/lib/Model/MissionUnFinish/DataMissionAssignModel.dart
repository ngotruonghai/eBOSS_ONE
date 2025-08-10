class DataMissionAssignModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  DataMissionAssignModel({this.statusCode, this.description, this.data});

  DataMissionAssignModel.fromJson(Map<String, dynamic> json) {
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
  String? parentWorkAID;
  String? missionKeyResultAID;
  String? workInfo;
  String? workAllSummary;
  String? workAllDetails;
  String? employeeName;
  String? progressDescription;
  String? solutionDescription;
  String? planDate;
  String? processingDate;
  String? closingDate;
  String? processWeight;
  String? processRate;
  String? planStartDate;
  String? planFinishDate;
  String? consumptionTime;
  String? executeStartDate;
  String? executeFinishDate;
  String? executeFinishRate;
  String? solutionID;
  String? sourceID;
  String? assignStatusID;
  String? assignStatusName;
  String? handlerAID;
  String? navigatorAID;
  String? receiverAID;
  String? projectSoftwareAID;
  String? projectHardwareAID;
  String? projectName;
  String? piorityID;
  String? piorityName;
  String? levelID;
  String? missionLevelID;
  String? workloadID;
  String? preFinishDate;
  String? typeID;
  String? typeRefID;
  String? reportTypeRID;
  String? resultScores;
  bool? isAttachFile;
  String? remark;

  Data(
      {this.workAID,
        this.workID,
        this.recordDate,
        this.parentWorkAID,
        this.missionKeyResultAID,
        this.workInfo,
        this.workAllSummary,
        this.workAllDetails,
        this.employeeName,
        this.progressDescription,
        this.solutionDescription,
        this.planDate,
        this.processingDate,
        this.closingDate,
        this.processWeight,
        this.processRate,
        this.planStartDate,
        this.planFinishDate,
        this.consumptionTime,
        this.executeStartDate,
        this.executeFinishDate,
        this.executeFinishRate,
        this.solutionID,
        this.sourceID,
        this.assignStatusID,
        this.assignStatusName,
        this.handlerAID,
        this.navigatorAID,
        this.receiverAID,
        this.projectSoftwareAID,
        this.projectHardwareAID,
        this.projectName,
        this.piorityID,
        this.piorityName,
        this.levelID,
        this.missionLevelID,
        this.workloadID,
        this.preFinishDate,
        this.typeID,
        this.typeRefID,
        this.reportTypeRID,
        this.resultScores,
        this.isAttachFile,
        this.remark});

  Data.fromJson(Map<String, dynamic> json) {
    workAID = json['WorkAID'];
    workID = json['WorkID'];
    recordDate = json['RecordDate'];
    parentWorkAID = json['ParentWorkAID'];
    missionKeyResultAID = json['MissionKeyResultAID'];
    workInfo = json['WorkInfo'];
    workAllSummary = json['WorkAllSummary'];
    workAllDetails = json['WorkAllDetails'];
    employeeName = json['EmployeeName'];
    progressDescription = json['ProgressDescription'];
    solutionDescription = json['SolutionDescription'];
    planDate = json['PlanDate'];
    processingDate = json['ProcessingDate'];
    closingDate = json['ClosingDate'];
    processWeight = json['ProcessWeight'];
    processRate = json['ProcessRate'];
    planStartDate = json['PlanStartDate'];
    planFinishDate = json['PlanFinishDate'];
    consumptionTime = json['ConsumptionTime'];
    executeStartDate = json['ExecuteStartDate'];
    executeFinishDate = json['ExecuteFinishDate'];
    executeFinishRate = json['ExecuteFinishRate'];
    solutionID = json['SolutionID'];
    sourceID = json['SourceID'];
    assignStatusID = json['AssignStatusID'];
    assignStatusName = json['AssignStatusName'];
    handlerAID = json['HandlerAID'];
    navigatorAID = json['NavigatorAID'];
    receiverAID = json['ReceiverAID'];
    projectSoftwareAID = json['ProjectSoftwareAID'];
    projectHardwareAID = json['ProjectHardwareAID'];
    projectName = json['ProjectName'];
    piorityID = json['PiorityID'];
    piorityName = json['PiorityName'];
    levelID = json['LevelID'];
    missionLevelID = json['MissionLevelID'];
    workloadID = json['WorkloadID'];
    preFinishDate = json['PreFinishDate'];
    typeID = json['TypeID'];
    typeRefID = json['TypeRefID'];
    reportTypeRID = json['ReportTypeRID'];
    resultScores = json['ResultScores'];
    isAttachFile = json['IsAttachFile'];
    remark = json['Remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WorkAID'] = this.workAID;
    data['WorkID'] = this.workID;
    data['RecordDate'] = this.recordDate;
    data['ParentWorkAID'] = this.parentWorkAID;
    data['MissionKeyResultAID'] = this.missionKeyResultAID;
    data['WorkInfo'] = this.workInfo;
    data['WorkAllSummary'] = this.workAllSummary;
    data['WorkAllDetails'] = this.workAllDetails;
    data['EmployeeName'] = this.employeeName;
    data['ProgressDescription'] = this.progressDescription;
    data['SolutionDescription'] = this.solutionDescription;
    data['PlanDate'] = this.planDate;
    data['ProcessingDate'] = this.processingDate;
    data['ClosingDate'] = this.closingDate;
    data['ProcessWeight'] = this.processWeight;
    data['ProcessRate'] = this.processRate;
    data['PlanStartDate'] = this.planStartDate;
    data['PlanFinishDate'] = this.planFinishDate;
    data['ConsumptionTime'] = this.consumptionTime;
    data['ExecuteStartDate'] = this.executeStartDate;
    data['ExecuteFinishDate'] = this.executeFinishDate;
    data['ExecuteFinishRate'] = this.executeFinishRate;
    data['SolutionID'] = this.solutionID;
    data['SourceID'] = this.sourceID;
    data['AssignStatusID'] = this.assignStatusID;
    data['AssignStatusName'] = this.assignStatusName;
    data['HandlerAID'] = this.handlerAID;
    data['NavigatorAID'] = this.navigatorAID;
    data['ReceiverAID'] = this.receiverAID;
    data['ProjectSoftwareAID'] = this.projectSoftwareAID;
    data['ProjectHardwareAID'] = this.projectHardwareAID;
    data['ProjectName'] = this.projectName;
    data['PiorityID'] = this.piorityID;
    data['PiorityName'] = this.piorityName;
    data['LevelID'] = this.levelID;
    data['MissionLevelID'] = this.missionLevelID;
    data['WorkloadID'] = this.workloadID;
    data['PreFinishDate'] = this.preFinishDate;
    data['TypeID'] = this.typeID;
    data['TypeRefID'] = this.typeRefID;
    data['ReportTypeRID'] = this.reportTypeRID;
    data['ResultScores'] = this.resultScores;
    data['IsAttachFile'] = this.isAttachFile;
    data['Remark'] = this.remark;
    return data;
  }
}
