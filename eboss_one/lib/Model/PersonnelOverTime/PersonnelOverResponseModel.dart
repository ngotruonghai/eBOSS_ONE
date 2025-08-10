class PersonnelOverResponseModel {
  int? statusCode;
  String? description;
  String? data;

  PersonnelOverResponseModel({this.statusCode, this.description, this.data});

  PersonnelOverResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['StatusCode'];
    description = json['Description'];
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusCode'] = this.statusCode;
    data['Description'] = this.description;
    data['Data'] = this.data;
    return data;
  }
}
