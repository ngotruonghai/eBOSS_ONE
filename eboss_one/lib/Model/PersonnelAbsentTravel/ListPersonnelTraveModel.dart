class ListPersonnelTraveModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  ListPersonnelTraveModel({this.statusCode, this.description, this.data});

  ListPersonnelTraveModel.fromJson(Map<String, dynamic> json) {
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
  String? travelAID;
  String? travelID;
  String? nameVietnamese;
  String? travelKM;
  String? contractNameVietnamese;
  String? startTime;
  String? endTime;
  String? recordDate;
  String? nguoiPheDuyet1;
  String? nguoiPheDuyet2;
  String? absentStartTime;
  String? absentEndTime;
  String? description;
  String? remark;
  String? statusID;

  Data(
      {
        this.travelAID,
        this.travelID,
        this.nameVietnamese,
        this.travelKM,
        this.contractNameVietnamese,
        this.startTime,
        this.endTime,
        this.recordDate,
        this.nguoiPheDuyet1,
        this.nguoiPheDuyet2,
        this.absentStartTime,
        this.absentEndTime,
        this.description,
        this.remark,
        this.statusID});

  Data.fromJson(Map<String, dynamic> json) {
    travelAID = json['TravelAID'];
    travelID = json['TravelID'];
    nameVietnamese = json['NameVietnamese'];
    travelKM = json['TravelKM'];
    contractNameVietnamese = json['ContractNameVietnamese'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    recordDate = json['RecordDate'];
    nguoiPheDuyet1 = json['NguoiPheDuyet1'];
    nguoiPheDuyet2 = json['NguoiPheDuyet2'];
    absentStartTime = json['AbsentStartTime'];
    absentEndTime = json['AbsentEndTime'];
    description = json['Description'];
    remark = json['Remark'];
    statusID = json['StatusID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TravelAID'] = this.travelAID;
    data['TravelID'] = this.travelID;
    data['NameVietnamese'] = this.nameVietnamese;
    data['TravelKM'] = this.travelKM;
    data['ContractNameVietnamese'] = this.contractNameVietnamese;
    data['StartTime'] = this.startTime;
    data['EndTime'] = this.endTime;
    data['RecordDate'] = this.recordDate;
    data['NguoiPheDuyet1'] = this.nguoiPheDuyet1;
    data['NguoiPheDuyet2'] = this.nguoiPheDuyet2;
    data['AbsentStartTime'] = this.absentStartTime;
    data['AbsentEndTime'] = this.absentEndTime;
    data['Description'] = this.description;
    data['Remark'] = this.remark;
    data['StatusID'] = this.statusID;
    return data;
  }
}
