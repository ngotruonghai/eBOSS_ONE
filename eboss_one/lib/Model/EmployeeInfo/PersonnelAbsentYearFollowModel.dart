class PersonnelAbsentYearFollowModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  PersonnelAbsentYearFollowModel(
      {this.statusCode, this.description, this.data});

  PersonnelAbsentYearFollowModel.fromJson(Map<String, dynamic> json) {
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
  String? employeeAID;
  String? originalClockIn;
  String? originalClockOut;
  String? totalAbsentRemain;

  Data(
      {this.employeeAID,
        this.originalClockIn,
        this.originalClockOut,
        this.totalAbsentRemain});

  Data.fromJson(Map<String, dynamic> json) {
    employeeAID = json['employeeAID'];
    originalClockIn = json['originalClockIn'];
    originalClockOut = json['originalClockOut'];
    totalAbsentRemain = json['totalAbsentRemain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeAID'] = this.employeeAID;
    data['originalClockIn'] = this.originalClockIn;
    data['originalClockOut'] = this.originalClockOut;
    data['totalAbsentRemain'] = this.totalAbsentRemain;
    return data;
  }
}
