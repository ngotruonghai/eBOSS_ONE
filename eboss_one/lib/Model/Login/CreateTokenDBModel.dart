class CreateTokenDBModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  CreateTokenDBModel({this.statusCode, this.description, this.data});

  CreateTokenDBModel.fromJson(Map<String, dynamic> json) {
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
  String? result;
  String? resultMessage;

  Data({this.result, this.resultMessage});

  Data.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    resultMessage = json['resultMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['resultMessage'] = this.resultMessage;
    return data;
  }
}
