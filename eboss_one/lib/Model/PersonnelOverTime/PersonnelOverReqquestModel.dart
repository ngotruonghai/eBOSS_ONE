class PersonnelOverReqquestModel {
  String? startTime;
  String? endTime;
  String? overtimeDate;
  int? loaiPhepTangCa;
  String? GhiChu;
  List<PersonnelOvertimeDetailModels>? personnelOvertimeDetailModels;

  PersonnelOverReqquestModel(
      {this.startTime,
        this.endTime,
        this.overtimeDate,
        this.loaiPhepTangCa,
        this.personnelOvertimeDetailModels,
        this.GhiChu});

  PersonnelOverReqquestModel.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
    overtimeDate = json['overtimeDate'];
    loaiPhepTangCa = json['loaiPhepTangCa'];
    GhiChu = json['GhiChu'];
    if (json['personnelOvertimeDetailModels'] != null) {
      personnelOvertimeDetailModels = <PersonnelOvertimeDetailModels>[];
      json['personnelOvertimeDetailModels'].forEach((v) {
        personnelOvertimeDetailModels!
            .add(new PersonnelOvertimeDetailModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime.toString(),
      'endTime': endTime.toString(),
      'overtimeDate': overtimeDate.toString(),
      'loaiPhepTangCa': loaiPhepTangCa,
      'ghiChu': GhiChu.toString(),
      'personnelOvertimeDetailModels':
      personnelOvertimeDetailModels?.map((e) => e.toJson()).toList(),
    };
  }
}

class PersonnelOvertimeDetailModels {
  String? overtimeAID;
  String? workDescription;
  String? startTime;
  String? endtime;
  String? overTimeHour;
  int? inOrder;
  int? Random;
  String? remark;

  PersonnelOvertimeDetailModels(
      {
        this.overtimeAID,
        this.workDescription,
        this.startTime,
        this.endtime,
        this.overTimeHour,
        this.inOrder,
        this.Random,
        this.remark
      });

  PersonnelOvertimeDetailModels.fromJson(Map<String, dynamic> json) {
    overtimeAID = json['overtimeAID'];
    workDescription = json['workDescription'];
    startTime = json['startTime'];
    endtime = json['endtime'];
    overTimeHour = json['overTimeHour'];
    inOrder = json['inOrder'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    return {
      'overtimeAID': overtimeAID,
      'workDescription': workDescription,
      'startTime': startTime,
      'endtime': endtime,
      'overTimeHour': overTimeHour,
      'remark': remark,
    };
  }
}
