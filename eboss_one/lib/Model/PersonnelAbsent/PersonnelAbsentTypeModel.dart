class PersonnelAbsentTypeModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  PersonnelAbsentTypeModel({this.statusCode, this.description, this.data});

  PersonnelAbsentTypeModel.fromJson(Map<String, dynamic> json) {
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
  String? typeID;
  String? nameType;

  Data({this.typeID, this.nameType});

  Data.fromJson(Map<String, dynamic> json) {
    typeID = json['typeID'];
    nameType = json['nameType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeID'] = this.typeID;
    data['nameType'] = this.nameType;
    return data;
  }
}
