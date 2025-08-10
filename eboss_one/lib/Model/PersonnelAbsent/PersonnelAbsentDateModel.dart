//Thông tin ngày nghỉ phép theo phiếu

class Personnelabsentdatemodel {
  int? statusCode;
  String? description;
  List<Data>? data;

  Personnelabsentdatemodel({this.statusCode, this.description, this.data});

  Personnelabsentdatemodel.fromJson(Map<String, dynamic> json) {
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
  String? dateItemAID;
  String? absentAID;
  String? absentTypeID;
  String? absentTypeName;
  String? absentDate;
  String? absentStartTime;
  String? absentEndTime;
  String? absentHour;

  Data({
    this.dateItemAID,
    this.absentAID,
    this.absentTypeID,
    this.absentTypeName,
    this.absentDate,
    this.absentStartTime,
    this.absentEndTime,
    this.absentHour,
    });

  Data.fromJson(Map<String, dynamic> json) {
    dateItemAID = json['dateItemAID'];
    absentAID = json['absentAID'];
    absentTypeID = json['absentTypeID'];
    absentTypeName = json['absentTypeName'];
    absentDate = json['absentDate'];
    absentStartTime = json['absentStartTime'];
    absentEndTime = json['absentEndTime'];
    absentHour = json['absentHour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateItemAID'] = this.dateItemAID;
    data['absentAID'] = this.absentAID;
    data['absentTypeID'] = this.absentTypeID;
    data['absentTypeName'] = this.absentTypeName;
    data['absentDate'] = this.absentDate;
    data['absentStartTime'] = this.absentStartTime;
    data['absentEndTime'] = this.absentEndTime;
    data['absentHour'] = this.absentHour;
    return data;
  }
}
