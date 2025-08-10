import 'package:eboss_one/Model/EmployeeInfo/PersonnelAbsentYearFollowModel.dart' as AbsentYearFollow;
import 'package:eboss_one/Model/EmployeeInfo/PersonnelTimekeepingInfoModel.dart' as TimekeepingInfo;
import 'package:eboss_one/Services/BaseServices/SharedPreferencesService.dart';
import 'package:flutter/material.dart';
import '../../Services/NetWork/NetWorkRequest.dart';

class TimekeepingProvider extends ChangeNotifier {
  List<TimekeepingInfo.Data>? listdata_TimekeepingInfo = null;
  List<AbsentYearFollow.Data>? listdata_AbsentYearFollow = null;

  bool isCheckIn = false;

  Future<void> loadAllTimekeepingData() async {
    await Future.wait([
      _loadDataTimekeepingInfo(),
      _loadDataPersonnelAbsentYearFollow(),
    ]);
    notifyListeners();
  }

  Future<void> _loadDataTimekeepingInfo() async {
    final responses = await NetWorkRequest.GetJWT(
        "/eBOSS/api/Employee/PersonnelTimekeepingInfo?EmployeeAID=" +
            SharedPreferencesService.getString(KeyServices.KeyEmployeeAID));

    final timekeepingInfo =
        await TimekeepingInfo.PersonnelTimekeepingInfoModel.fromJson(responses);

    listdata_TimekeepingInfo = timekeepingInfo.data;
  }

  Future<void> _loadDataPersonnelAbsentYearFollow() async {
    final responses = await NetWorkRequest.GetJWT(
        "/eBOSS/api/Employee/PersonnelAbsentYearFollow?EmployeeAID=" +
            SharedPreferencesService.getString(KeyServices.KeyEmployeeAID));

    final absentYearFollow =
        await AbsentYearFollow.PersonnelAbsentYearFollowModel.fromJson(responses);

    listdata_AbsentYearFollow = absentYearFollow.data;

    isCheckIn = listdata_AbsentYearFollow != null &&
        listdata_AbsentYearFollow!.isNotEmpty &&
        listdata_AbsentYearFollow![0].originalClockIn.toString() != "null";
  }

  /// Gọi sau khi chấm công thành công để cập nhật lại dữ liệu
  Future<void> updateAfterCheckIn() async {
    await _loadDataPersonnelAbsentYearFollow();
    notifyListeners();
  }

  void setCheckIn(bool value) {
    isCheckIn = value;
    notifyListeners();
  }
}
