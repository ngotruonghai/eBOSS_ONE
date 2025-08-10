//Chi tiết nội dung tăng ca theo phiếu

class Personnelovertimedetailsmodel {
  int? statusCode;
  String? description;
  List<Data>? data;

  Personnelovertimedetailsmodel({this.statusCode, this.description, this.data});

  Personnelovertimedetailsmodel.fromJson(Map<String, dynamic> json) {
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
  String? overtimeItemAID;
  String? overtimeAID;
  String? workDescription;
  String? startTime;
  String? endtime;
  String? overTimeHour;
  String? remark;

  Data({
    this.overtimeItemAID,
    this.overtimeAID,
    this.workDescription,
    this.startTime,
    this.endtime,
    this.overTimeHour,
    this.remark
  });

  Data.fromJson(Map<String, dynamic> json) {
    overtimeItemAID = json['OvertimeItemAID'];
    overtimeAID = json['OvertimeAID'];
    workDescription = json['WorkDescription'];
    startTime = json['StartTime'];
    endtime = json['Endtime'];
    overTimeHour = json['OverTimeHour'];
    remark = json['Remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OvertimeItemAID'] = this.overtimeItemAID;
    data['OvertimeAID'] = this.overtimeAID;
    data['WorkDescription'] = this.workDescription;
    data['StartTime'] = this.startTime;
    data['Endtime'] = this.endtime;
    data['OverTimeHour'] = this.overTimeHour;
    data['Remark'] = this.remark;
    return data;
  }
}
