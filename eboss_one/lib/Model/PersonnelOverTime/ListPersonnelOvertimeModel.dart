class ListPersonnelOvertimeModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  ListPersonnelOvertimeModel({this.statusCode, this.description, this.data});

  ListPersonnelOvertimeModel.fromJson(Map<String, dynamic> json) {
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
  String? overtimeAID;
  String? overtimeID;
  String? nameVietnamese;
  String? personnelType;
  String? contractNameVietnamese;
  String? overtimeDate;
  String? startTime;
  String? endTime;
  String? overTimeHour;
  String? recordDate;
  String? nguoiPheDuyet1;
  String? nguoiPheDuyet2;
  String? absentStartTime;
  String? absentEndTime;
  String? remark;
  String? statusID;

  Data(
      {
        this.overtimeAID,
        this.overtimeID,
        this.nameVietnamese,
        this.personnelType,
        this.contractNameVietnamese,
        this.overtimeDate,
        this.startTime,
        this.endTime,
        this.overTimeHour,
        this.recordDate,
        this.nguoiPheDuyet1,
        this.nguoiPheDuyet2,
        this.absentStartTime,
        this.absentEndTime,
        this.remark,
        this.statusID
      });

  Data.fromJson(Map<String, dynamic> json) {
    overtimeAID = json['OvertimeAID'];
    overtimeID = json['OvertimeID'];
    nameVietnamese = json['NameVietnamese'];
    personnelType = json['PersonnelType'];
    contractNameVietnamese = json['ContractNameVietnamese'];
    overtimeDate = json['OvertimeDate'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    overTimeHour = json['OverTimeHour'];
    recordDate = json['RecordDate'];
    nguoiPheDuyet1 = json['NguoiPheDuyet1'];
    nguoiPheDuyet2 = json['NguoiPheDuyet2'];
    absentStartTime = json['AbsentStartTime'];
    absentEndTime = json['AbsentEndTime'];
    remark = json['Remark'];
    statusID = json['StatusID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OvertimeAID'] = this.overtimeAID;
    data['OvertimeID'] = this.overtimeID;
    data['NameVietnamese'] = this.nameVietnamese;
    data['PersonnelType'] = this.personnelType;
    data['ContractNameVietnamese'] = this.contractNameVietnamese;
    data['OvertimeDate'] = this.overtimeDate;
    data['StartTime'] = this.startTime;
    data['EndTime'] = this.endTime;
    data['OverTimeHour'] = this.overTimeHour;
    data['RecordDate'] = this.recordDate;
    data['NguoiPheDuyet1'] = this.nguoiPheDuyet1;
    data['NguoiPheDuyet2'] = this.nguoiPheDuyet2;
    data['AbsentStartTime'] = this.absentStartTime;
    data['AbsentEndTime'] = this.absentEndTime;
    data['Remark'] = this.remark;
    data['StatusID'] = this.statusID;
    return data;
  }
}
