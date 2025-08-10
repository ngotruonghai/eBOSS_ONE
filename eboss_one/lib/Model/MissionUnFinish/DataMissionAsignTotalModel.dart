class DataMissionAsignTotalModel {
  int? statusCode;
  String? description;
  List<Data>? data;

  DataMissionAsignTotalModel({this.statusCode, this.description, this.data});

  DataMissionAsignTotalModel.fromJson(Map<String, dynamic> json) {
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
  String? nameChinese;
  String? nameVietnamese;
  String? nameEnglish;
  String? nameOther;
  int? qtyTotal;
  int? qtySolution;
  int? qtyAnalysis;
  int? qtyAssign;
  int? qtyReceive;
  int? qtyNotification;
  int? qtyRedo;
  int? qtyDiscuss;
  int? qtyFollow;
  int? qtyChecked;
  int? qtyDeal;
  int? qtyClosed;
  int? qtyNotDeal;
  int? qtyUnusual;
  int? qtyValidDate;
  int? qtyOverOneDay;
  int? qtyOverThreeDay;
  int? qtyOverSevenDay;
  int? qtyOverTenDay;
  int? qtyOverFifteenDay;
  int? qtyOverThirtyDay;
  int? qtyOverSixtiesDay;
  int? qtySyncWait;
  int? qtySyncing;
  int? chuaXuLy;

  Data(
      {this.nameChinese,
        this.nameVietnamese,
        this.nameEnglish,
        this.nameOther,
        this.qtyTotal,
        this.qtySolution,
        this.qtyAnalysis,
        this.qtyAssign,
        this.qtyReceive,
        this.qtyNotification,
        this.qtyRedo,
        this.qtyDiscuss,
        this.qtyFollow,
        this.qtyChecked,
        this.qtyDeal,
        this.qtyClosed,
        this.qtyNotDeal,
        this.qtyUnusual,
        this.qtyValidDate,
        this.qtyOverOneDay,
        this.qtyOverThreeDay,
        this.qtyOverSevenDay,
        this.qtyOverTenDay,
        this.qtyOverFifteenDay,
        this.qtyOverThirtyDay,
        this.qtyOverSixtiesDay,
        this.qtySyncWait,
        this.qtySyncing,
        this.chuaXuLy});

  Data.fromJson(Map<String, dynamic> json) {
    nameChinese = json['nameChinese'];
    nameVietnamese = json['nameVietnamese'];
    nameEnglish = json['nameEnglish'];
    nameOther = json['nameOther'];
    qtyTotal = json['qtyTotal'];
    qtySolution = json['qtySolution'];
    qtyAnalysis = json['qtyAnalysis'];
    qtyAssign = json['qtyAssign'];
    qtyReceive = json['qtyReceive'];
    qtyNotification = json['qtyNotification'];
    qtyRedo = json['qtyRedo'];
    qtyDiscuss = json['qtyDiscuss'];
    qtyFollow = json['qtyFollow'];
    qtyChecked = json['qtyChecked'];
    qtyDeal = json['qtyDeal'];
    qtyClosed = json['qtyClosed'];
    qtyNotDeal = json['qtyNotDeal'];
    qtyUnusual = json['qtyUnusual'];
    qtyValidDate = json['qtyValidDate'];
    qtyOverOneDay = json['qtyOverOneDay'];
    qtyOverThreeDay = json['qtyOverThreeDay'];
    qtyOverSevenDay = json['qtyOverSevenDay'];
    qtyOverTenDay = json['qtyOverTenDay'];
    qtyOverFifteenDay = json['qtyOverFifteenDay'];
    qtyOverThirtyDay = json['qtyOverThirtyDay'];
    qtyOverSixtiesDay = json['qtyOverSixtiesDay'];
    qtySyncWait = json['qtySyncWait'];
    qtySyncing = json['qtySyncing'];
    chuaXuLy = json['chuaXuLy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameChinese'] = this.nameChinese;
    data['nameVietnamese'] = this.nameVietnamese;
    data['nameEnglish'] = this.nameEnglish;
    data['nameOther'] = this.nameOther;
    data['qtyTotal'] = this.qtyTotal;
    data['qtySolution'] = this.qtySolution;
    data['qtyAnalysis'] = this.qtyAnalysis;
    data['qtyAssign'] = this.qtyAssign;
    data['qtyReceive'] = this.qtyReceive;
    data['qtyNotification'] = this.qtyNotification;
    data['qtyRedo'] = this.qtyRedo;
    data['qtyDiscuss'] = this.qtyDiscuss;
    data['qtyFollow'] = this.qtyFollow;
    data['qtyChecked'] = this.qtyChecked;
    data['qtyDeal'] = this.qtyDeal;
    data['qtyClosed'] = this.qtyClosed;
    data['qtyNotDeal'] = this.qtyNotDeal;
    data['qtyUnusual'] = this.qtyUnusual;
    data['qtyValidDate'] = this.qtyValidDate;
    data['qtyOverOneDay'] = this.qtyOverOneDay;
    data['qtyOverThreeDay'] = this.qtyOverThreeDay;
    data['qtyOverSevenDay'] = this.qtyOverSevenDay;
    data['qtyOverTenDay'] = this.qtyOverTenDay;
    data['qtyOverFifteenDay'] = this.qtyOverFifteenDay;
    data['qtyOverThirtyDay'] = this.qtyOverThirtyDay;
    data['qtyOverSixtiesDay'] = this.qtyOverSixtiesDay;
    data['qtySyncWait'] = this.qtySyncWait;
    data['qtySyncing'] = this.qtySyncing;
    data['chuaXuLy'] = this.chuaXuLy;
    return data;
  }
}
