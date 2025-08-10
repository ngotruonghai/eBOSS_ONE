import 'dart:convert';
import 'package:eboss_one/Provider/TimeKeepingProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../Model/CompanyNoticeRecord/CompanyNoticeModel.dart'
    as CompanyNoticeModel;
import '../../Model/MissionUnFinish/DataMissionAssignModel.dart' as AssignModel;
import '../../Model/EmployeeInfo/PersonnelTimekeepingInfoModel.dart'
    as TimekeepingInfo;
import '../../Model/EmployeeInfo/PersonnelAbsentYearFollowModel.dart'
    as AbsentYearFollow;
import '../../Services/BaseServices/MobileVersion.dart';
import '../../Services/BaseServices/SharedPreferencesService.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import '../../Services/ShowDialog/DialogUpdateVersionApp.dart';
import '../../ViewModel/CompanyNotice/CompanyNoticeViewModel.dart';
import '../../ViewModel/Mission/TodayMission.dart';
import '../CompanyNotice/CompanyNoticeView.dart';
import '../Task/TaskDetailView.dart';
import 'package:intl/intl.dart';
import '../../Model/Login/MobileInfoModel.dart' as MobileInfoModel;
import '../../Model/Home/GetNewInfoHomeModel.dart' as GetNewInfoHomeModel;
import 'HomeClockView.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';
import '../../Widgets/TimeKeeping.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<CompanyNoticeModel.Data>? listdata = null;
  List<AssignModel.Data>? listdata_MissionAssign = null;
  List<TimekeepingInfo.Data>? listdata_TimekeepingInfo = null;
  List<AbsentYearFollow.Data>? listdata_AbsentYearFollow = null;
  late List<GetNewInfoHomeModel.Data> list_tintuc;
  bool IsCheckIn = false;
  bool IsCheckOut = false;

  Future<void> API_CheckUpDateAppVersion(BuildContext context) async {
    try {
      final json =
          await NetWorkRequest.GetJWT("/eBOSS/api/MobileInfo/StatusApp");
      final responses = MobileInfoModel.MobileInfoModel.fromJson(json);
      if (responses.data?.version.toString() != MobileVersion.VersionApp) {
        DialogUpdateVersionApp.showMyDialog(context);
      }
    } catch (e) {
      print("Lỗi API eBOSS/api/MobileInfo/StatusApp " + e.toString());
    }
  }

  Future<String> loaddataMissionUnFinish() async {
    try {
      final responses = await NetWorkRequest.GetJWT(
          "/eBOSS/api/CompanyNoticeRecord/ListCompanyNotice_Home");
      final CompanyNotice =
          CompanyNoticeModel.CompanyNoticeModel.fromJson(responses);
      listdata = CompanyNotice.data;
      return "1";
    } catch (e) {
      return "0";
    }
  }

  Future<String> LoadDataMissionAssign() async {
    Map<String, dynamic> request = {
      'language': 'NameVietnamese',
      'receiverAID':
          SharedPreferencesService.getString(KeyServices.KeyEmployeeAID)
              .toString(),
      'assignStatusID': '',
    };
    final responses = await NetWorkRequest.PostJWT(
        "/eBOSS/api/MissionUnFinish/DataMissionAssign", request);
    final MissionAssign =
        await AssignModel.DataMissionAssignModel.fromJson(responses);
    listdata_MissionAssign = MissionAssign.data;
    return "1";
  }

  Future<String> LoadDataTimekeepingInfo() async {
    final responses = await NetWorkRequest.GetJWT(
        "/eBOSS/api/Employee/PersonnelTimekeepingInfo?EmployeeAID=" +
            SharedPreferencesService.getString(KeyServices.KeyEmployeeAID));
    final timekeepingInfo =
        await TimekeepingInfo.PersonnelTimekeepingInfoModel.fromJson(responses);
    listdata_TimekeepingInfo = timekeepingInfo.data;
    return "1";
  }

  Future<String> LoadDataPersonnelAbsentYearFollow() async {
    final responses = await NetWorkRequest.GetJWT(
        "/eBOSS/api/Employee/PersonnelAbsentYearFollow?EmployeeAID=" +
            SharedPreferencesService.getString(KeyServices.KeyEmployeeAID));
    final absentYearFollow =
        await AbsentYearFollow.PersonnelAbsentYearFollowModel.fromJson(
            responses);
    listdata_AbsentYearFollow = absentYearFollow.data;

    IsCheckIn = listdata_AbsentYearFollow != null &&
            listdata_AbsentYearFollow!.isNotEmpty &&
            listdata_AbsentYearFollow![0].originalClockIn.toString() != "null";

    return "1";
  }

  Future<void> API_LoadTinTicTrangHome() async {
    Map<String, dynamic> requestmodel = {
      'top': "5"
    };
    final request = await NetWorkRequest.PostJWT("/eBOSS/api/NewInfo/GetNewInfoHome", requestmodel);
    final response = await GetNewInfoHomeModel.GetNewInfoHomeModel.fromJson(request);
    list_tintuc = response.data!;
  }

  // Load data refresh
  Future<void> _refreshData() async {
    // Giả định rằng bạn sẽ làm thao tác làm mới dữ liệu ở đây.
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      listdata = null;
      // listdata_MissionAssign = null;
      listdata_TimekeepingInfo = null;
      listdata_AbsentYearFollow = null;
    });
    loaddataMissionUnFinish();
    // LoadDataMissionAssign();
    //LoadDataTimekeepingInfo();
    LoadDataPersonnelAbsentYearFollow();
  }

  // Load data refresh
  Future<bool> loadData(BuildContext context) async {
    //await Future.delayed(Duration(seconds: 1)); // Giả lập thời gian tải
    listdata = null;
    // listdata_MissionAssign = null;
    listdata_TimekeepingInfo = null;
    listdata_AbsentYearFollow = null;

    API_CheckUpDateAppVersion(context);
    API_LoadTinTicTrangHome();
    await loaddataMissionUnFinish();
    // await LoadDataMissionAssign();
    //await LoadDataTimekeepingInfo(); //api này chậm hơn 30 giây
    // await LoadDataPersonnelAbsentYearFollow(); // Giờ vào giờ ra    
    await Provider.of<TimekeepingProvider>(context, listen: false).loadAllTimekeepingData();

    return true;
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => Error404View()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          color: Color(0xffffff),
          child: RefreshIndicator(
              backgroundColor: Colors.white,
              child: FutureBuilder<bool>(
                future: loadData(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Hiển thị trang tải
                    return CircularProgressIndicator(
                      color: Colors.deepOrange,
                    );
                  } else {
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                                padding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 3),
                                      child: Text("Xin chào, ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Roboto",
                                              color: Colors.black)),
                                    ),
                                    Text(
                                      SharedPreferencesService.getString(
                                          KeyServices.KeyUserName)
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Roboto",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding:
                                EdgeInsets.only(top: 0, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 3),
                                      child: Text(
                                          DateFormat('dd/MM/yyyy')
                                              .format(DateTime.now())
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Roboto",
                                              color: Colors.black)),
                                    ),
                                  ],
                                )),
                            // Chấm công
                            Timekeeping(),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Expanded(
                                      //     child: Container(
                                      //   decoration: BoxDecoration(
                                      //       color: Color(0xFFF5F5F5),
                                      //       borderRadius:
                                      //           BorderRadius.circular(10),
                                      //       boxShadow: [
                                      //         BoxShadow(
                                      //           color:
                                      //               Colors.grey, // Shadow color
                                      //           blurRadius:
                                      //               1.0, // Spread of the shadow
                                      //           //offset: Offset(0, 2), // Offset of the shadow
                                      //         ),
                                      //       ]),
                                      //   child: Padding(
                                      //     padding: EdgeInsets.only(
                                      //         top: 10,
                                      //         right: 10,
                                      //         left: 10,
                                      //         bottom: 10),
                                      //     child: Column(
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       children: [
                                      //         Column(
                                      //           children: [
                                      //             if (listdata_TimekeepingInfo !=
                                      //                 null)
                                      //               Text(
                                      //                 listdata_TimekeepingInfo![0]
                                      //                             .workDayReal
                                      //                             .toString() ==
                                      //                         "null"
                                      //                     ? "-"
                                      //                     : listdata_TimekeepingInfo![
                                      //                             0]
                                      //                         .workDayReal
                                      //                         .toString(),
                                      //                 style: TextStyle(
                                      //                     fontSize: 25,
                                      //                     color:
                                      //                         Colors.orangeAccent,
                                      //                     fontWeight:
                                      //                         FontWeight.bold,
                                      //                     fontFamily: "Roboto"),
                                      //               )
                                      //             else
                                      //               Text("_",
                                      //                   style: TextStyle(
                                      //                       fontSize: 25,
                                      //                       color: Colors
                                      //                           .orangeAccent,
                                      //                       fontWeight:
                                      //                           FontWeight.bold,
                                      //                       fontFamily: "Roboto"))
                                      //           ],
                                      //         ),
                                      //         Text(
                                      //           "Số ngày công",
                                      //           style: TextStyle(
                                      //               fontSize: 15,
                                      //               color: Colors.black,
                                      //               fontWeight: FontWeight.bold,
                                      //               fontFamily: "Roboto"),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // )),
                                      SizedBox(width: 20),
                                      // Expanded(
                                      //     child: Container(
                                      //   width: 150,
                                      //   decoration: BoxDecoration(
                                      //       color: Color(0xFFF5F5F5),
                                      //       borderRadius:
                                      //           BorderRadius.circular(10),
                                      //       boxShadow: [
                                      //         BoxShadow(
                                      //           color:
                                      //               Colors.grey, // Shadow color
                                      //           blurRadius:
                                      //               1.0, // Spread of the shadow
                                      //           //offset: Offset(0, 2), // Offset of the shadow
                                      //         ),
                                      //       ]),
                                      //   child: Padding(
                                      //     padding: EdgeInsets.only(
                                      //         top: 10,
                                      //         right: 10,
                                      //         left: 10,
                                      //         bottom: 10),
                                      //     child: Column(
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       children: [
                                      //         Column(
                                      //           children: [
                                      //             if (listdata_TimekeepingInfo !=
                                      //                 null)
                                      //               Text(
                                      //                 listdata_TimekeepingInfo![0]
                                      //                             .absentTotal
                                      //                             .toString() ==
                                      //                         "null"
                                      //                     ? "-"
                                      //                     : listdata_TimekeepingInfo![
                                      //                             0]
                                      //                         .absentTotal
                                      //                         .toString(),
                                      //                 style: TextStyle(
                                      //                     fontSize: 25,
                                      //                     color:
                                      //                         Colors.orangeAccent,
                                      //                     fontWeight:
                                      //                         FontWeight.bold,
                                      //                     fontFamily: "Roboto"),
                                      //               )
                                      //             else
                                      //               Text("_",
                                      //                   style: TextStyle(
                                      //                       fontSize: 25,
                                      //                       color: Colors
                                      //                           .orangeAccent,
                                      //                       fontWeight:
                                      //                           FontWeight.bold,
                                      //                       fontFamily: "Roboto"))
                                      //           ],
                                      //         ),
                                      //         Text(
                                      //           "Số ngày nghỉ phép",
                                      //           style: TextStyle(
                                      //               fontSize: 15,
                                      //               color: Colors.black,
                                      //               fontWeight: FontWeight.bold,
                                      //               fontFamily: "Roboto"),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0, left: 10, right: 10, bottom: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Expanded(
                                      //     child: Container(
                                      //   decoration: BoxDecoration(
                                      //       color: Color(0xFFF5F5F5),
                                      //       borderRadius:
                                      //           BorderRadius.circular(10),
                                      //       boxShadow: [
                                      //         BoxShadow(
                                      //           color:
                                      //               Colors.grey, // Shadow color
                                      //           blurRadius:
                                      //               1.0, // Spread of the shadow
                                      //           //offset: Offset(0, 2), // Offset of the shadow
                                      //         ),
                                      //       ]),
                                      //   child: Padding(
                                      //     padding: EdgeInsets.only(
                                      //         top: 10,
                                      //         right: 10,
                                      //         left: 10,
                                      //         bottom: 10),
                                      //     child: Column(
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       children: [
                                      //         Column(
                                      //           children: [
                                      //             if (listdata_TimekeepingInfo !=
                                      //                 null)
                                      //               Text(
                                      //                 listdata_TimekeepingInfo![0]
                                      //                     .overTimeTotal
                                      //                     .toString(),
                                      //                 style: TextStyle(
                                      //                     fontSize: 25,
                                      //                     color:
                                      //                         Colors.orangeAccent,
                                      //                     fontWeight:
                                      //                         FontWeight.bold,
                                      //                     fontFamily: "Roboto"),
                                      //               )
                                      //             else
                                      //               Text("_",
                                      //                   style: TextStyle(
                                      //                       fontSize: 25,
                                      //                       color: Colors
                                      //                           .orangeAccent,
                                      //                       fontWeight:
                                      //                           FontWeight.bold,
                                      //                       fontFamily: "Roboto"))
                                      //           ],
                                      //         ),
                                      //         Text(
                                      //           "Số giờ tăng ca",
                                      //           style: TextStyle(
                                      //               fontSize: 15,
                                      //               color: Colors.black,
                                      //               fontWeight: FontWeight.bold,
                                      //               fontFamily: "Roboto"),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      // Expanded(
                                      //     child: Container(
                                      //   width: 150,
                                      //   decoration: BoxDecoration(
                                      //       color: Color(0xFFF5F5F5),
                                      //       borderRadius:
                                      //           BorderRadius.circular(10),
                                      //       boxShadow: [
                                      //         BoxShadow(
                                      //           color:
                                      //               Colors.grey, // Shadow color
                                      //           blurRadius:
                                      //               1.0, // Spread of the shadow
                                      //           //offset: Offset(0, 2), // Offset of the shadow
                                      //         ),
                                      //       ]),
                                      //   child: Padding(
                                      //     padding: EdgeInsets.only(
                                      //         top: 10,
                                      //         right: 10,
                                      //         left: 10,
                                      //         bottom: 10),
                                      //     child: Column(
                                      //       crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //       children: [
                                      //         Column(
                                      //           children: [
                                      //             if (listdata_AbsentYearFollow !=
                                      //                 null)
                                      //               Text(
                                      //                 listdata_AbsentYearFollow![
                                      //                                 0]
                                      //                             .totalAbsentRemain
                                      //                             .toString() ==
                                      //                         "null"
                                      //                     ? "0"
                                      //                     : listdata_AbsentYearFollow![
                                      //                             0]
                                      //                         .totalAbsentRemain
                                      //                         .toString(),
                                      //                 style: TextStyle(
                                      //                     fontSize: 25,
                                      //                     color:
                                      //                         Colors.orangeAccent,
                                      //                     fontWeight:
                                      //                         FontWeight.bold,
                                      //                     fontFamily: "Roboto"),
                                      //               )
                                      //             else
                                      //               Text("_",
                                      //                   style: TextStyle(
                                      //                       fontSize: 25,
                                      //                       color: Colors
                                      //                           .orangeAccent,
                                      //                       fontWeight:
                                      //                           FontWeight.bold,
                                      //                       fontFamily: "Roboto"))
                                      //           ],
                                      //         ),
                                      //         Text(
                                      //           "Số phép năm",
                                      //           style: TextStyle(
                                      //               fontSize: 15,
                                      //               color: Colors.black,
                                      //               fontWeight: FontWeight.bold,
                                      //               fontFamily: "Roboto"),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // task
                            // Padding(
                            //   padding:
                            //   EdgeInsets.only(top: 40, left: 10, right: 10),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text("Nhiệm vụ hôm nay",
                            //           style: TextStyle(
                            //               fontSize: 15,
                            //               color: Colors.black,
                            //               fontWeight: FontWeight.bold,
                            //               fontFamily: "Roboto")),
                            //       InkWell(
                            //         child: Text(
                            //           "Xem thêm",
                            //           style: TextStyle(
                            //               fontSize: 13,
                            //               fontFamily: "Roboto",
                            //               color: Color(0xFF4B7BE5)),
                            //         ),
                            //         onTap: () {
                            //           Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (context) => TaskDetail()),
                            //           );
                            //         },
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //       top: 0, left: 10, right: 10, bottom: 10),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: [
                            //       Text(
                            //         "Nhiệm vụ chưa hoàn thành ",
                            //         style: TextStyle(
                            //             fontSize: 13,
                            //             fontFamily: "Roboto",
                            //             color: Colors.black87),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            // Container(
                            //   width: double.infinity,
                            //   child: Padding(
                            //     padding:
                            //     EdgeInsets.only(top: 10, left: 10, right: 10),
                            //     child: SingleChildScrollView(
                            //         scrollDirection: Axis
                            //             .horizontal, // Đặt hướng cuộn là ngang
                            //         child: ConstrainedBox(
                            //           constraints: BoxConstraints(
                            //               maxWidth: double
                            //                   .infinity // Để ngăn chặn nó bị co lại
                            //           ),
                            //           child: Column(
                            //             children: [
                            //               if (listdata_MissionAssign == null)
                            //                 Center(
                            //                   child: Text("Loading..."),
                            //                 )
                            //               else
                            //                 Row(
                            //                   children: listdata_MissionAssign!
                            //                       .map((e) =>
                            //                       TodayMissionViewModel(
                            //                           data: e))
                            //                       .toList(),
                            //                 )
                            //             ],
                            //           ),
                            //         )),
                            //   ),
                            // ),
                            // code
                            Padding(
                              padding:
                              EdgeInsets.only(top: 20, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tin tức",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Roboto")),
                                  // InkWell(
                                  //   child: Text(
                                  //     "Xem thêm",
                                  //     style: TextStyle(
                                  //         color: Color(0xFF4B7BE5),
                                  //         fontSize: 13,
                                  //         fontFamily: "Roboto"),
                                  //   ),
                                  //   onTap: () {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => TaskDetail()),
                                  //     );
                                  //   },
                                  // ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                              child: SingleChildScrollView(
                                  scrollDirection:
                                  Axis.horizontal, // Đặt hướng cuộn là ngang
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: double
                                            .infinity // Để ngăn chặn nó bị co lại
                                    ),
                                    child: Row(
                                      children:list_tintuc.map((item) {
                                        return Column(
                                          children: [
                                            if(list_tintuc == null)
                                              Text("")
                                            else
                                              Card(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                      width: 180,
                                                      height: 130,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: <Widget>[
                                                              Container(
                                                                child: ClipPath(
                                                                  child: Image.memory(
                                                                    base64Decode(item.image
                                                                        .toString()),
                                                                    fit: BoxFit.cover,
                                                                    width: 180,
                                                                    height: 70,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Padding(
                                                                  padding:
                                                                  EdgeInsets.only(
                                                                      bottom: 5),
                                                                  child: SizedBox(
                                                                    width: 180.0,
                                                                    child: Text(
                                                                        item.titleName.toString(),
                                                                        overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                            13,
                                                                            fontFamily:
                                                                            "Roboto",
                                                                            color: Colors
                                                                                .black,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .bold)),
                                                                  )),
                                                              Padding(
                                                                  padding:
                                                                  EdgeInsets.only(
                                                                      top: 0),
                                                                  child: Text("Ngày tạo:" +
                                                                      item.recordDate.toString(),
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        "Roboto",
                                                                        fontSize: 13),
                                                                  )),
                                                            ],
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                                elevation: 4.0,
                                              ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(top: 50, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Thông báo nội bộ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Roboto")),
                                  InkWell(
                                    child: Text("Xem thêm",
                                        style: TextStyle(
                                            color: Color(0xFF4B7BE5),
                                            fontSize: 13,
                                            fontFamily: "Roboto")),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CompanyNoticeView()),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              //CompanyNoticeViewModel
                              children: [
                                if (listdata == null)
                                  Center(
                                    child: Text("Loading..."),
                                  )
                                else
                                  Column(
                                    children: listdata!
                                        .map((e) =>
                                        CompanyNoticeViewModel(data: e))
                                        .toList(),
                                  )
                              ],
                            )
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              onRefresh: _refreshData),
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Screen 2'),
    );
  }
}
