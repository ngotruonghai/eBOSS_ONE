class GetEmployeeInfo {
  int? statusCode;
  String? description;
  List<Data>? data;

  GetEmployeeInfo({this.statusCode, this.description, this.data});

  GetEmployeeInfo.fromJson(Map<String, dynamic> json) {
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
  String? employeeAID;
  String? nameChinese;
  String? nameVietnamese;
  String? nameEnglish;
  String? nameOther;
  String? contractNameVietnamese;
  String? contractName;
  String? gender;
  String? birthDate;
  String? departmentName;
  String? companyID;
  String? professionalTitleName;
  String? mobile;
  String? emailEboss;
  String? emailEdt;
  String? emailFordward;
  String? workTitleName;
  String? workTitleNameChinese;
  String? rankLevelName;
  String? rankLevelDescription;
  String? leaveDate;
  String? photo;
  String? address;
  String? joinDate;

  Data(
      {this.employeeID,
        this.employeeAID,
        this.nameChinese,
        this.nameVietnamese,
        this.nameEnglish,
        this.nameOther,
        this.contractNameVietnamese,
        this.contractName,
        this.gender,
        this.birthDate,
        this.departmentName,
        this.companyID,
        this.professionalTitleName,
        this.mobile,
        this.emailEboss,
        this.emailEdt,
        this.emailFordward,
        this.workTitleName,
        this.workTitleNameChinese,
        this.rankLevelName,
        this.rankLevelDescription,
        this.leaveDate,
        this.photo,
        this.address,
        this.joinDate});

  Data.fromJson(Map<String, dynamic> json) {
    employeeID = json['employeeID'];
    employeeAID = json['employeeAID'];
    nameChinese = json['nameChinese'];
    nameVietnamese = json['nameVietnamese'];
    nameEnglish = json['nameEnglish'];
    nameOther = json['nameOther'];
    contractNameVietnamese = json['contractNameVietnamese'];
    contractName = json['contractName'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    departmentName = json['departmentName'];
    companyID = json['companyID'];
    professionalTitleName = json['professionalTitleName'];
    mobile = json['mobile'];
    emailEboss = json['emailEboss'];
    emailEdt = json['emailEdt'];
    emailFordward = json['emailFordward'];
    workTitleName = json['workTitleName'];
    workTitleNameChinese = json['workTitleNameChinese'];
    rankLevelName = json['rankLevelName'];
    rankLevelDescription = json['rankLevelDescription'];
    leaveDate = json['leaveDate'];
    photo = json['photo'];
    address = json['address'];
    joinDate = json['joinDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeID'] = this.employeeID;
    data['employeeAID'] = this.employeeAID;
    data['nameChinese'] = this.nameChinese;
    data['nameVietnamese'] = this.nameVietnamese;
    data['nameEnglish'] = this.nameEnglish;
    data['nameOther'] = this.nameOther;
    data['contractNameVietnamese'] = this.contractNameVietnamese;
    data['contractName'] = this.contractName;
    data['gender'] = this.gender;
    data['birthDate'] = this.birthDate;
    data['departmentName'] = this.departmentName;
    data['companyID'] = this.companyID;
    data['professionalTitleName'] = this.professionalTitleName;
    data['mobile'] = this.mobile;
    data['emailEboss'] = this.emailEboss;
    data['emailEdt'] = this.emailEdt;
    data['emailFordward'] = this.emailFordward;
    data['workTitleName'] = this.workTitleName;
    data['workTitleNameChinese'] = this.workTitleNameChinese;
    data['rankLevelName'] = this.rankLevelName;
    data['rankLevelDescription'] = this.rankLevelDescription;
    data['leaveDate'] = this.leaveDate;
    data['photo'] = this.photo;
    data['address'] = this.address;
    data['joinDate'] = this.joinDate;
    return data;
  }
}
