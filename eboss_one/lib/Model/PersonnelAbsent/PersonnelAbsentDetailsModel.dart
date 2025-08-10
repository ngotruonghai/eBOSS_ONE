class AbsentDetails {
  String absentID;
  String description;
  String remark;
  String fileData;
  String fileInfo;
  String fileType;
  String workDescription;
  String workSolution;

  AbsentDetails({
    required this.absentID,
    required this.description,
    required this.remark,
    required this.fileData,
    required this.fileInfo,
    required this.fileType,
    required this.workDescription,
    required this.workSolution,
  });

  Map<String, dynamic> toJson() {
    return {
      'absentID': absentID,
      'description': description,
      'remark': remark,
      'fileData': fileData,
      'fileInfo': fileInfo,
      'fileType': fileType,
      'workDescription': workDescription,
      'workSolution': workSolution,
    };
  }
}
