class PersonnelOverTypeModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  PersonnelOverTypeModel({this.statusCode, this.description, this.data});

  PersonnelOverTypeModel.fromJson(Map<String, dynamic> json) {
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
    typeID = json['TypeID'];
    nameType = json['NameType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TypeID'] = this.typeID;
    data['NameType'] = this.nameType;
    return data;
  }
}
