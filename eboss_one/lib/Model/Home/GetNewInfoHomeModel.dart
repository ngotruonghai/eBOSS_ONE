class GetNewInfoHomeModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  GetNewInfoHomeModel({this.statusCode, this.description, this.data});

  GetNewInfoHomeModel.fromJson(Map<String, dynamic> json) {
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
  String? recordDate;
  String? titleName;
  String? description;
  String? image;
  String? creator;

  Data(
      {this.recordDate,
        this.titleName,
        this.description,
        this.image,
        this.creator});

  Data.fromJson(Map<String, dynamic> json) {
    recordDate = json['recordDate'];
    titleName = json['titleName'];
    description = json['description'];
    image = json['image'];
    creator = json['creator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordDate'] = this.recordDate;
    data['titleName'] = this.titleName;
    data['description'] = this.description;
    data['image'] = this.image;
    data['creator'] = this.creator;
    return data;
  }
}
