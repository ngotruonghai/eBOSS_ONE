class CalendarViewerModel {
  int? statusCode;
  String? imageKey;
  String? recordDate;
  String? description;
  List<Data>? data;

  CalendarViewerModel({
    this.statusCode,
    this.imageKey,
    this.recordDate,
    this.description,
    this.data});

  CalendarViewerModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    imageKey = json['imageKey'];
    recordDate = json['recordDate'];
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
  String? imageKey;
  String? recordDate;
  String? description;

  Data(
      {this.imageKey,
        this.recordDate,
        this.description,});

  Data.fromJson(Map<String, dynamic> json) {
    imageKey = json['imageKey'];
    recordDate = json['recordDate'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageKey'] = this.imageKey;
    data['recordDate'] = this.recordDate;
    data['description'] = this.description;
    return data;
  }
}
