import 'package:eboss_one/View/PersonnelOvertime/PersonnelOvertime_ChiTietTangCa_View.dart';
import 'package:flutter/material.dart';
import '../../Model/PersonnelOverTime/ListPersonnelOvertimeModel.dart' 
as ModelDanhSachTangCa;
import '../../Services/BaseServices/SharedPreferencesService.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import '../../Model/PersonnelAbsent/MonthModel.dart' as MonthModel;
import '../../Model/PersonnelAbsent/YearModel.dart' as YearModel;
import '../PersonnelAbsent/ListYear_PopView.dart';
import '../PersonnelAbsent/LoadListMonth_PopupView.dart';
import 'PersonnelOvertimeCreateView.dart';

class PersonnelOvertimeView extends StatefulWidget {
  PersonnelOvertimeView({super.key});

  @override
  State<PersonnelOvertimeView> createState() => _PersonnelOvertimeView();
}

class _PersonnelOvertimeView extends State<PersonnelOvertimeView> {
  late List<ModelDanhSachTangCa.Data> DanhSachTangCa;
  late List<MonthModel.Data> DanhSachThang;
  late List<YearModel.Data> DanhSachNam;

  String _MonthCode = getCurrentMonth().toString();
  String _YearCode = getCurrentYear().toString();

  String _MonthStr = "Tháng " + getCurrentMonth().toString();
  String _YearStr = "Năm " + getCurrentYear().toString();

  Future<void> AddPersonnelMonth(String Name, String Code) async {
    setState(() {
      _MonthCode = Code;
      _MonthStr = Name;
    });
  }

  Future<void> AddPersonnelYear(String Name, String Code) async {
    setState(() {
      _YearCode = Code;
      _YearStr = Name;
    });
  }

  Future<void> PageInit() async {
    try {
      MonthModel.Data? thanghientai;
      //YearModel.Data? namhientai;
      if (DanhSachThang.length > 0) {
        thanghientai = DanhSachThang.firstWhere((item) => item.code.toString() == "03");
      }

      setState(() {
        _MonthStr = thanghientai!.name.toString();
        _MonthCode = thanghientai!.code.toString();


      });
    } catch (e) {
      print("Lỗi: "+e.toString());
    }
  }

  /*START Call API Danh sách đơn phép*/
  Future<int> API_LoadDanhSachTangCa(BuildContext context) async {
    Map<String, dynamic> request = {
      'employeeAID':
      SharedPreferencesService.getString(KeyServices.KeyEmployeeAID),
      'nam': _YearCode,
      'thang': _MonthCode,
    };
    final responses = await NetWorkRequest.PostJWT_1(
        "/eBOSS/api/PersonnelOvertime/DanhSachPhieuTangCa", request, context);
    final Response =
    ModelDanhSachTangCa.ListPersonnelOvertimeModel.fromJson(responses);
    DanhSachTangCa = Response.data!;
    return 1;
  }
  /*END Call API Danh sách đơn phép*/

  /*STAR Call API Danh sách tháng*/
  Future<bool> API_DanhSachThang() async {
    try {
      final responses =
      await NetWorkRequest.GetJWT("/eBOSS/api/PersonnelAbsent/GetMonth");
      final result = MonthModel.MonthModel.fromJson(responses);
      DanhSachThang = result.data!;
      return true;
    } catch (e) {
      return false;
    }
  }
  /*END Call API Danh sách tháng*/

  /*STAR Call API Danh sách Năm*/
  Future<bool> API_DanhSachNam() async {
    try {
      final responses =
      await NetWorkRequest.GetJWT("/eBOSS/api/PersonnelAbsent/GetYear");
      final result = YearModel.YearModel.fromJson(responses);
      DanhSachNam = result.data!;
      return true;
    } catch (e) {
      return false;
    }
  }
  /*END Call API Danh sách Năm*/

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 0));
    setState(() {}); 
  }

  Future<bool> loadData(BuildContext context) async {
    try {
      await API_DanhSachThang();
      await API_DanhSachNam();
      //await PageInit();
      await API_LoadDanhSachTangCa(context);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phiếu đề nghị tăng ca"),
        backgroundColor: Color(0xFFFED801C),
        titleTextStyle: TextStyle(
          color: Colors.white, // Set the title color
          fontSize: 20,        // Optional: Set font size
        ),
        actions: [
          IconButton(onPressed: () async {
            final result = await Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => PersonnelOvertimeCreateView()),
            );
            if (result == 'refresh') {
              _refreshData();
            }
          }, icon: Icon(Icons.add_circle_outline_outlined, color: Colors.white,)),
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        child: FutureBuilder<bool>(
            future: loadData(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Hiển thị trang tải
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepOrange,
                  ),
                );
              } else {
                return Container(
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 100,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            child: InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    shape: const OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.vertical(
                                                            top: Radius
                                                                .circular(
                                                                20))),
                                                    context: context,
                                                    isScrollControlled: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return LoadListMonth_PopupView(
                                                        AddPersonnelMonth:
                                                        AddPersonnelMonth,
                                                        ListData: DanhSachThang,
                                                      );
                                                    });
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    _MonthStr,
                                                    style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Icon(
                                                      Icons
                                                          .calendar_month_rounded,
                                                      color: Colors.blue,
                                                      size: 20)
                                                ],
                                              ),
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                                shape: const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.vertical(
                                                        top:
                                                        Radius.circular(
                                                            20))),
                                                context: context,
                                                isScrollControlled: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return ListYear_PopView(
                                                    AddPersonnelYear:
                                                    AddPersonnelYear,
                                                    ListData: DanhSachNam,
                                                  );
                                                });
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    _YearStr,
                                                    style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Icon(
                                                      Icons
                                                          .calendar_month_rounded,
                                                      color: Colors.blue,
                                                      size: 20)
                                                ],
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: DanhSachTangCa.map((item) {
                                        return Padding(
                                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                            child: InkWell(
                                              onTap: () async {                                                
                                                print("OvertimeAID: ${item.overtimeAID}");
                                                final result = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => PersonnelovertimeChitiettangcaView(                                                      
                                                        overtimeAID: item.overtimeAID.toString(),
                                                        overtimeID: item.overtimeID.toString(),                                                        
                                                        nameVietnamese: item.nameVietnamese.toString(),
                                                        personnelType: item.personnelType.toString(),
                                                        contractNameVietnamese: item.contractNameVietnamese.toString(),
                                                        overtimeDate: item.overtimeDate.toString(),
                                                        startTime: item.startTime.toString(),
                                                        endTime: item.endTime.toString(),
                                                        overTimeHour: item.overTimeHour.toString(),
                                                        recordDate: item.recordDate.toString(),
                                                        nguoiPheDuyet1: item.nguoiPheDuyet1.toString(),
                                                        nguoiPheDuyet2: item.nguoiPheDuyet2.toString(),
                                                        absentStartTime: item.absentStartTime.toString(),
                                                        absentEndTime: item.absentEndTime.toString(),
                                                        remark: item.remark.toString(),
                                                        statusID: item.statusID.toString(),
                                                    )
                                                  ),
                                                );
                                                if (result == true){
                                                   _refreshData();
                                                }
                                              },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                              ),
                                              elevation: 2.0,
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Padding(
                                                  padding:
                                                  EdgeInsets.only(left: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                            item.overtimeID
                                                                .toString(),
                                                            style: TextStyle(
                                                                color:
                                                                Colors.orange,
                                                                fontSize: 17,
                                                                fontFamily:
                                                                "Roboto",
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                      ),
                                                      Text(
                                                          item.personnelType
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 14,
                                                              fontFamily: "Roboto",
                                                              fontWeight:
                                                              FontWeight.bold)),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          item.recordDate
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 13,
                                                              fontFamily:
                                                              "Roboto")),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.person,
                                                            size: 20,
                                                            color:
                                                            Colors.blueAccent,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                              item.contractNameVietnamese
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color:
                                                                  Colors.black,
                                                                  fontSize: 13,
                                                                  fontFamily:
                                                                  "Roboto")),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .calendar_month_rounded,
                                                                size: 20,
                                                                color: Colors.blue,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                  'Giờ tăng ca: ${item.absentStartTime} - ${item.absentEndTime}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 13,
                                                                      fontFamily:
                                                                      "Roboto"))
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 1,
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          "Ghi chú: " +
                                                              item.remark
                                                                  .toString(),
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 13,
                                                              fontFamily:
                                                              "Roboto")),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          if (item.nguoiPheDuyet1
                                                              .toString() ==
                                                              "")
                                                            Icon(
                                                              Icons
                                                                  .radio_button_off,
                                                              size: 15,
                                                              color: Colors.orange,
                                                            ),
                                                          if (item.nguoiPheDuyet1
                                                              .toString() !=
                                                              "")
                                                            Icon(
                                                              Icons.check_circle,
                                                              size: 15,
                                                              color: Colors.green,
                                                            ),
                                                          SizedBox(
                                                            width: 6,
                                                          ),
                                                          Text(
                                                              "Phê duyệt: " +
                                                                  item.nguoiPheDuyet1
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color:
                                                                  Colors.black,
                                                                  fontSize: 13,
                                                                  fontFamily:
                                                                  "Roboto")),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          if (item.nguoiPheDuyet2
                                                              .toString() ==
                                                              "")
                                                            Icon(
                                                              Icons
                                                                  .radio_button_off,
                                                              size: 15,
                                                              color: Colors.orange,
                                                            ),
                                                          if (item.nguoiPheDuyet2
                                                              .toString() !=
                                                              "")
                                                            Icon(
                                                              Icons.check_circle,
                                                              size: 15,
                                                              color: Colors.green,
                                                            ),
                                                          SizedBox(
                                                            width: 6,
                                                          ),
                                                          Text(
                                                              "Kiểm tra: " +
                                                                  item.nguoiPheDuyet2
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color:
                                                                  Colors.black,
                                                                  fontSize: 13,
                                                                  fontFamily:
                                                                  "Roboto")),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Divider(
                                                        // Đây là đường kẻ ngang
                                                        color: Color(
                                                            0xFFdfe6e9), // Màu sắc của đường kẻ
                                                        thickness:
                                                        1, // Độ dày của đường kẻ
                                                        indent:
                                                        10, // Khoảng cách từ lề trái
                                                        endIndent:
                                                        10, // Khoảng cách từ lề phải
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Column(
                                                        children: [
                                                          if (item.statusID == "01")
                                                            Center(
                                                              child: Text(
                                                                  item.nameVietnamese
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .orange,
                                                                      fontSize: 15,
                                                                      fontFamily:
                                                                      "Roboto",
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                            )
                                                          else if (item.statusID ==
                                                              "03")
                                                            Center(
                                                              child: Text(
                                                                  item.nameVietnamese
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green,
                                                                      fontSize: 15,
                                                                      fontFamily:
                                                                      "Roboto",
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                            )
                                                          else if (item.statusID ==
                                                                "02")
                                                              Center(
                                                                child: Text(
                                                                    item.nameVietnamese
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .deepOrange,
                                                                        fontSize: 15,
                                                                        fontFamily:
                                                                        "Roboto",
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                              )
                                                            else if (item.statusID ==
                                                                  "99")
                                                                Center(
                                                                  child: Text(
                                                                      item.nameVietnamese
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize: 15,
                                                                          fontFamily:
                                                                          "Roboto",
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                                )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                          );
                                      }).toList(),
                                    ),
                                  ))
                            ],
                          ),
                        );
                      }),
                );
              }
            }),
        onRefresh: _refreshData,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async{
      //     final result = await Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => PersonnelOvertimeCreateView()),
      //     );
      //     if (result == 'refresh') {
      //       _refreshData();
      //     }
      //   },
      //   backgroundColor: Color(0xFFFED801C),
      //   child: const Icon(
      //     color: Colors.white,
      //     Icons.add,
      //     size: 30,
      //   ),
      // ),
    );
  }
}

// Lấy tháng hiện tại
int getCurrentMonth() {
  DateTime now = DateTime.now();
  return now.month;
}

// Lấy năm hiện tại
int getCurrentYear() {
  DateTime now = DateTime.now();
  return now.year;
}
