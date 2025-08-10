class UserInfoModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  UserInfoModel({this.statusCode, this.description, this.data});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
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
  String? employeeID;
  String? userID;
  String? fullName;
  String? workShiftName;
  String? birthDate;
  String? joinDate;
  String? dedicateYear;
  String? adjustDate;
  String? addressResident;
  String? address;
  String? mobile;
  String? companyID;
  String? employeeCode;
  String? emailFordward;
  String? emailPersonnal;
  String? insuranceCompanyID;
  String? departmentName;
  String? workTitleName;
  String? professionalTitleName;
  String? rankLeaderName;
  String? rankLevelName;
  String? photo;

  Data(
      {this.employeeAID,
        this.employeeID,
        this.userID,
        this.fullName,
        this.workShiftName,
        this.birthDate,
        this.joinDate,
        this.dedicateYear,
        this.adjustDate,
        this.addressResident,
        this.address,
        this.mobile,
        this.companyID,
        this.employeeCode,
        this.emailFordward,
        this.emailPersonnal,
        this.insuranceCompanyID,
        this.departmentName,
        this.workTitleName,
        this.professionalTitleName,
        this.rankLeaderName,
        this.rankLevelName,
        this.photo});

  Data.fromJson(Map<String, dynamic> json) {
    employeeAID = json['employeeAID'];
    employeeID = json['employeeID'];
    userID = json['userID'];
    fullName = json['fullName'];
    workShiftName = json['workShiftName'];
    birthDate = json['birthDate'];
    joinDate = json['joinDate'];
    dedicateYear = json['dedicateYear'];
    adjustDate = json['adjustDate'];
    addressResident = json['addressResident'];
    address = json['address'];
    mobile = json['mobile'];
    companyID = json['companyID'];
    employeeCode = json['employeeCode'];
    emailFordward = json['emailFordward'];
    emailPersonnal = json['emailPersonnal'];
    insuranceCompanyID = json['insuranceCompanyID'];
    departmentName = json['departmentName'];
    workTitleName = json['workTitleName'];
    professionalTitleName = json['professionalTitleName'];
    rankLeaderName = json['rankLeaderName'];
    rankLevelName = json['rankLevelName'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeAID'] = this.employeeAID;
    data['employeeID'] = this.employeeID;
    data['userID'] = this.userID;
    data['fullName'] = this.fullName;
    data['workShiftName'] = this.workShiftName;
    data['birthDate'] = this.birthDate;
    data['joinDate'] = this.joinDate;
    data['dedicateYear'] = this.dedicateYear;
    data['adjustDate'] = this.adjustDate;
    data['addressResident'] = this.addressResident;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['companyID'] = this.companyID;
    data['employeeCode'] = this.employeeCode;
    data['emailFordward'] = this.emailFordward;
    data['emailPersonnal'] = this.emailPersonnal;
    data['insuranceCompanyID'] = this.insuranceCompanyID;
    data['departmentName'] = this.departmentName;
    data['workTitleName'] = this.workTitleName;
    data['professionalTitleName'] = this.professionalTitleName;
    data['rankLeaderName'] = this.rankLeaderName;
    data['rankLevelName'] = this.rankLevelName;
    data['photo'] = this.photo;
    return data;
  }
}
