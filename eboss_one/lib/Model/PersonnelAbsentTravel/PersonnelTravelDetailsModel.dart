//Thông tin địa điểm công tác theo phiếu

class Personneltraveldetailsmodel {
  int? statusCode;
  String? description;
  List<Data>? data;

  Personneltraveldetailsmodel({this.statusCode, this.description, this.data});

  Personneltraveldetailsmodel.fromJson(Map<String, dynamic> json) {
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
  String? aID;
  String? travelAID;
  String? areaID;
  String? areaName;
  String? typeID;
  String? travelTypeName;
  String? description;
  String? kM;
  String? outlayAmount;
  String? outlayReason;
  String? remark;

  Data({
    this.aID,
    this.travelAID,
    this.areaID,
    this.areaName,
    this.typeID,
    this.travelTypeName,
    this.description,
    this.kM,
    this.outlayAmount,
    this.outlayReason,
    this.remark,
    });

  Data.fromJson(Map<String, dynamic> json) {
    aID = json['aID'];
    travelAID = json['travelAID'];
    areaID = json['areaID'];
    areaName = json['areaName'];
    typeID = json['typeID'];
    travelTypeName = json['travelTypeName'];
    description = json['description'];
    kM = json['km'];
    outlayAmount = json['outlayAmount'];
    outlayReason = json['outlayReason'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aID'] = this.aID;
    data['travelAID'] = this.travelAID;
    data['areaID'] = this.areaID;
    data['areaName'] = this.areaName;
    data['typeID'] = this.typeID;
    data['travelTypeName'] = this.travelTypeName;
    data['description'] = this.description;
    data['km'] = this.kM;
    data['outlayAmount'] = this.outlayAmount;
    data['outlayReason'] = this.outlayReason;
    data['remark'] = this.remark;
    return data;
  }
}
