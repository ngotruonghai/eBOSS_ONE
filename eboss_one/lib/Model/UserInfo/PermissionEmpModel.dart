class PermissionEmpModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  PermissionEmpModel({this.statusCode, this.description, this.data});

  PermissionEmpModel.fromJson(Map<String, dynamic> json) {
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
  String? employAID;
  int? functionID;
  String? functionName;
  String? nameVietnamese;
  Null? nameEnglish;
  int? rank;
  bool? status;
  String? remark;

  Data(
      {this.employAID,
        this.functionID,
        this.functionName,
        this.nameVietnamese,
        this.nameEnglish,
        this.rank,
        this.status,
        this.remark});

  Data.fromJson(Map<String, dynamic> json) {
    employAID = json['EmployAID'];
    functionID = json['FunctionID'];
    functionName = json['FunctionName'];
    nameVietnamese = json['NameVietnamese'];
    nameEnglish = json['NameEnglish'];
    rank = json['Rank'];
    status = json['Status'];
    remark = json['Remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployAID'] = this.employAID;
    data['FunctionID'] = this.functionID;
    data['FunctionName'] = this.functionName;
    data['NameVietnamese'] = this.nameVietnamese;
    data['NameEnglish'] = this.nameEnglish;
    data['Rank'] = this.rank;
    data['Status'] = this.status;
    data['Remark'] = this.remark;
    return data;
  }
}
