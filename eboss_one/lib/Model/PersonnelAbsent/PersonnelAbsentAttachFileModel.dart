class PersonnelAbsentAttachFile {
  String description;
  String remark;
  String absentID;

  PersonnelAbsentAttachFile({
    required this.description,
    required this.remark,
    required this.absentID,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'remark': remark,
      'absentID': absentID,
    };
  }
}
