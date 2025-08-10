class PersonnelTimekeepingInfoModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  PersonnelTimekeepingInfoModel({this.statusCode, this.description, this.data});

  PersonnelTimekeepingInfoModel.fromJson(Map<String, dynamic> json) {
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
  String? employeeID;
  String? absentTotal;
  String? workDayReal;
  String? overTimeTotal;

  Data(
      {this.employeeID,
        this.absentTotal,
        this.workDayReal,
        this.overTimeTotal});

  Data.fromJson(Map<String, dynamic> json) {
    employeeID = json['employeeID'];
    absentTotal = json['absentTotal'];
    workDayReal = json['workDayReal'];
    overTimeTotal = json['overTimeTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeID'] = this.employeeID;
    data['absentTotal'] = this.absentTotal;
    data['workDayReal'] = this.workDayReal;
    data['overTimeTotal'] = this.overTimeTotal;
    return data;
  }
}