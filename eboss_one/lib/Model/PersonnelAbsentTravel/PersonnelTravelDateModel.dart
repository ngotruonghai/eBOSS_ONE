//Thông tin ngày công tác theo phiếu

class Personneltraveldatemodel {
  int? statusCode;
  String? description;
  List<Data>? data;

  Personneltraveldatemodel({this.statusCode, this.description, this.data});

  Personneltraveldatemodel.fromJson(Map<String, dynamic> json) {
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
  String? dateItemAID;
  String? travelAID;
  String? travelDate;
  String? travelStartTime;
  String? travelEndTime;
  String? travelHour;
  String? travelFee;
  String? nightStayCount;
  String? isAdditional;
  String? remark;

  Data({
    this.dateItemAID,
    this.travelAID,
    this.travelDate,
    this.travelStartTime,
    this.travelEndTime,
    this.travelHour,
    this.travelFee,
    this.nightStayCount,
    this.isAdditional,
    this.remark,
    });

  Data.fromJson(Map<String, dynamic> json) {
    dateItemAID = json['dateItemAID'];
    travelAID = json['travelAID'];
    travelDate = json['travelDate'];
    travelStartTime = json['travelStartTime'];
    travelEndTime = json['travelEndTime'];
    travelHour = json['travelHour'];
    travelFee = json['travelFee'];
    nightStayCount = json['nightStayCount'];
    isAdditional = json['isAdditional'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateItemAID'] = this.dateItemAID;
    data['travelAID'] = this.travelAID;
    data['travelDate'] = this.travelDate;
    data['travelStartTime'] = this.travelStartTime;
    data['travelEndTime'] = this.travelEndTime;
    data['travelHour'] = this.travelHour;
    data['travelFee'] = this.travelFee;
    data['nightStayCount'] = this.nightStayCount;
    data['isAdditional'] = this.isAdditional;
    data['remark'] = this.remark;
    return data;
  }
}
