class KhuVucModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  KhuVucModel({this.statusCode, this.description, this.data});

  KhuVucModel.fromJson(Map<String, dynamic> json) {
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
  String? description;
  String? typeID;
  String? areaID;

  Data({this.description, this.typeID, this.areaID});

  Data.fromJson(Map<String, dynamic> json) {
    description = json['Description'];
    typeID = json['TypeID'];
    areaID = json['AreaID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Description'] = this.description;
    data['TypeID'] = this.typeID;
    data['AreaID'] = this.areaID;
    return data;
  }
}
