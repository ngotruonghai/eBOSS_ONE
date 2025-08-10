class PersonnelAbsentResultModel {
  int? statusCode;
  String? description;
  Null? data;

  PersonnelAbsentResultModel({this.statusCode, this.description, this.data});

  PersonnelAbsentResultModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    description = json['description'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['description'] = this.description;
    data['data'] = this.data;
    return data;
  }
}
