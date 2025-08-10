class LoaiCongTacModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  LoaiCongTacModel({this.statusCode, this.description, this.data});

  LoaiCongTacModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? typeID;

  Data({this.name, this.typeID});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    typeID = json['TypeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['TypeID'] = this.typeID;
    return data;
  }
}
