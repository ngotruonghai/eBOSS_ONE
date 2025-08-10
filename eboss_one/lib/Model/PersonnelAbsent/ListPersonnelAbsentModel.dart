class ListPersonnelAbsentModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  ListPersonnelAbsentModel({this.statusCode, this.description, this.data});

  ListPersonnelAbsentModel.fromJson(Map<String, dynamic> json) {
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
  String? absentAID;
  String? absentID;
  String? nameVietnamese;
  String? statusID;
  String? listOfAbsentType;
  String? absentHour;
  String? contractNameVietnamese;
  String? nguoiPheDuyet1;
  String? nguoiPheDuyet2;
  String? absentStartTime;
  String? absentEndTime;
  String? recordDate;
  String? descriptionAbsent;
  String? remark;

  Data(
      {
        this.absentAID,
        this.absentID,
        this.nameVietnamese,
        this.statusID,
        this.listOfAbsentType,
        this.absentHour,
        this.contractNameVietnamese,
        this.nguoiPheDuyet1,
        this.nguoiPheDuyet2,
        this.absentStartTime,
        this.absentEndTime,
        this.recordDate,
        this.descriptionAbsent,
        this.remark,
      });

  Data.fromJson(Map<String, dynamic> json) {
    absentAID = json['absentAID'];
    absentID = json['absentID'];
    nameVietnamese = json['nameVietnamese'];
    statusID = json['statusID'];
    listOfAbsentType = json['listOfAbsentType'];
    absentHour = json['absentHour'];
    contractNameVietnamese = json['contractNameVietnamese'];
    nguoiPheDuyet1 = json['nguoiPheDuyet1'];
    nguoiPheDuyet2 = json['nguoiPheDuyet2'];
    absentStartTime = json['absentStartTime'];
    absentEndTime = json['absentEndTime'];
    recordDate = json['recordDate'];
    descriptionAbsent = json['descriptionAbsent'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['absentAID'] = this.absentAID;
    data['absentID'] = this.absentID;
    data['nameVietnamese'] = this.nameVietnamese;
    data['statusID'] = this.statusID;
    data['listOfAbsentType'] = this.listOfAbsentType;
    data['absentHour'] = this.absentHour;
    data['contractNameVietnamese'] = this.contractNameVietnamese;
    data['nguoiPheDuyet1'] = this.nguoiPheDuyet1;
    data['nguoiPheDuyet2'] = this.nguoiPheDuyet2;
    data['absentStartTime'] = this.absentStartTime;
    data['absentEndTime'] = this.absentEndTime;
    data['recordDate'] = this.recordDate;
    data['descriptionAbsent'] = this.descriptionAbsent;
    data['remark'] = this.remark;
    return data;
  }
}
