class YearModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  YearModel({this.statusCode, this.description, this.data});

  YearModel.fromJson(Map<String, dynamic> json) {
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
  String? year;
  String? code;

  Data({this.year, this.code});

  Data.fromJson(Map<String, dynamic> json) {
    year = json['Year'];
    code = json['Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Year'] = this.year;
    data['Code'] = this.code;
    return data;
  }
}
