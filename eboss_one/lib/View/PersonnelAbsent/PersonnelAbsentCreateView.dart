import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Model/PersonnelAbsent/PersonnelAbsentAttachFileModel.dart';
import '../../Model/PersonnelAbsent/PersonnelAbsentDetailsModel.dart';
import '../../Services/BaseServices/SharedPreferencesService.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import '../../Services/ShowDialog/DialogMessage_Error.dart';
import '../../Services/ShowDialog/SnackbarError.dart';
import 'AbsentAttachFileDetail_PopupView.dart';
import 'PersonnelAbsentAttachFile_PopupView.dart';
import 'PersonnelAbsentCreate_PopupView.dart';
import 'package:intl/intl.dart';
import '../../Model/PersonnelAbsent/PersonnelAbsentTypeModel.dart'
    as DataAbsentType;
import '../../Model/PersonnelAbsent/PersonnelAbsentResultModel.dart'
    as PersonnelAbsentResul;
import 'PersonnelAbsentDateCreate_PopupView.dart';
import 'PersonnelAbsentDateDetailView.dart';
import '../../Model/EmployeeInfo/PersonnelTimekeepingInfoModel.dart'
    as TimekeepingInfo;

class PersonnelAbsentCreateView extends StatefulWidget {
  PersonnelAbsentCreateView({super.key});

  @override
  State<PersonnelAbsentCreateView> createState() =>
      _PersonnelAbsentCreateView();
}

class _PersonnelAbsentCreateView extends State<PersonnelAbsentCreateView> {
  String _NameType = "Việc riêng";
  int _FlagBtn = 0;
  String _DonPhep = "";
  String _ThoiGianBatDau = "08:00";
  String _ThoiGianKethuc = DateFormat("HH:mm").format(DateTime.now());
  String _AbsenType = "05";
  TextEditingController _txtLyDo = TextEditingController();
  TextEditingController _txtGhiChu = TextEditingController();
  String _SoNgayCong = "";
  String _SoNgayNghiPhep = "";


  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectFormDate = DateTime.now();
  DateTime _selectToDate = DateTime.now();
  late TimeOfDay _selectedTime;
  List<AbsentDetails> ListAbsentDetails = [];
  List<PersonnelAbsentAttachFile> ListAbsentAttachFile = [];
  String CountListAbsentDetails = "0";
  String CountListPersonnelAbsentAttachFile = "0";
  List<TimekeepingInfo.Data> listTimekeepingInfo = [];

  Future<void> AddPersonnelAbsenType(String NameType, String TypeID) async {
    setState(() {
      _NameType = NameType;
      _AbsenType = TypeID;
    });
  }

  Future<void> AddPersonnelAbsentDetails(String description, String remark,
      String workDescription, String workSolution) async {
    DateTime now = DateTime.now();
    String formattedDate = now.day.toString().padLeft(2, '0') +
        now.month.toString().padLeft(2, '0') +
        (now.year % 100).toString().padLeft(2, '0') +
        now.hour.toString().padLeft(2, '0') +
        now.minute.toString().padLeft(2, '0') +
        now.second.toString().padLeft(2, '0');
    ListAbsentDetails.add(AbsentDetails(
        absentID: formattedDate,
        description: description,
        remark: remark,
        fileData: "",
        fileInfo: "",
        fileType: "",
        workDescription: workDescription,
        workSolution: workSolution));
    setState(() {
      CountListAbsentDetails = ListAbsentDetails.length.toString();
    });
  }

  Future<void> RemovePersonnelAbsentDetails(int Index, String absentID) async {
    ListAbsentDetails.removeWhere((item) => item.absentID == absentID);
    setState(() {
      CountListAbsentDetails = ListAbsentDetails.length.toString();
    });
  }

  Future<void> AddPersonnelAbsentAttachFile(
      String DienGiai, String GhiChu) async {
    DateTime now = DateTime.now();
    String formattedDate = now.day.toString().padLeft(2, '0') +
        now.month.toString().padLeft(2, '0') +
        (now.year % 100).toString().padLeft(2, '0') +
        now.hour.toString().padLeft(2, '0') +
        now.minute.toString().padLeft(2, '0') +
        now.second.toString().padLeft(2, '0');
    ListAbsentAttachFile.add(PersonnelAbsentAttachFile(
        description: DienGiai, remark: GhiChu, absentID: formattedDate));
    setState(() {
      CountListPersonnelAbsentAttachFile =
          ListAbsentAttachFile.length.toString();
    });
  }

  Future LoadDataTimekeepingInfo() async {
    try {
      final responses = await NetWorkRequest.GetJWT(
          "/eBOSS/api/Employee/PersonnelTimekeepingInfo?EmployeeAID=" +
              SharedPreferencesService.getString(KeyServices.KeyEmployeeAID));
      final timekeepingInfo =
          await TimekeepingInfo.PersonnelTimekeepingInfoModel.fromJson(
              responses);
      if (timekeepingInfo.statusCode == 200) {
        setState(() {
          listTimekeepingInfo = timekeepingInfo.data!;
          _SoNgayCong = listTimekeepingInfo[0].workDayReal.toString();
          _SoNgayNghiPhep = listTimekeepingInfo[0].absentTotal.toString();
        });
      }
    } catch (e) {}
  }

  Future<void> RemovePersonnelAbsentAttachFile(
      int Index, String absentID) async {
    ListAbsentAttachFile.removeWhere((item) => item.absentID == absentID);
    setState(() {
      CountListPersonnelAbsentAttachFile =
          ListAbsentAttachFile.length.toString();
    });
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _selectTime(BuildContext context, int Type) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      cancelText: "Đóng",
      confirmText: "Chọn",
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        if (Type == 0) {
          _ThoiGianBatDau = _formatTime(_selectedTime);
        } else if (Type == 1) {
          _ThoiGianKethuc = _formatTime(_selectedTime);
        }
      });
    }
  }

  late List<DataAbsentType.Data> listdata;

  Future<String> API_LoadDataPersonnelAbsentType() async {
    try {
      final responses = await NetWorkRequest.GetJWT(
          "/eBOSS/api/PersonnelAbsent/LoadDataPersonnelAbsentType");
      final CompanyNotice =
          DataAbsentType.PersonnelAbsentTypeModel.fromJson(responses);
      listdata = CompanyNotice.data!;
      return "";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> API_TaoDonPhep(BuildContext context) async {
    try {
      /*Kiểm tra trước add*/
      if (CountListAbsentDetails == "0") {
        await DialogMessage_Error.showMyDialog(
            context, "Vui lòng tạo ít nhất 1 chi tiết bàn giao!");
        return;
      }

      /*Call API tạo đơn*/
      List<Map<String, dynamic>> jsonData =
          ListAbsentDetails.map((data) => data.toJson()).toList();
      String jsonString = jsonEncode(jsonData);

      List<Map<String, dynamic>> jsonData1 =
          ListAbsentAttachFile.map((data) => data.toJson()).toList();
      String jsonString1 = jsonEncode(jsonData1);

      Map<String, dynamic> request = {
        "employeeAID":
            SharedPreferencesService.getString(KeyServices.KeyEmployeeAID),
        "absentStartTime": DateFormat('dd/MM/yyyy').format(_selectFormDate),
        "absentEndTime": DateFormat('dd/MM/yyyy').format(_selectToDate),
        "listOfAbsentType": _AbsenType,
        "descriptionAbsent": _txtLyDo.text,
        "remark": _txtGhiChu.text,
        "optionMobile": _FlagBtn.toString(),
        "listPersonnelAbsentDetails": jsonString,
        "formDate": _ThoiGianBatDau,
        "toDate": _ThoiGianKethuc,
        "listPersonnelAbsentAttachFile": jsonString1
      };
      final responses = await NetWorkRequest.PostJWT(
          "/eBOSS/api/PersonnelAbsent/CreatePersonnelAbsent", request);
      final result =
          PersonnelAbsentResul.PersonnelAbsentResultModel.fromJson(responses);
      if (result.statusCode == 200) {
        SnackbarError.showSnackbar_Succes(context,
            message: result.description.toString());

        setState(() {
          _txtLyDo.text = "";
          _txtGhiChu.text = "";
          _ThoiGianBatDau = "00:00";
          _ThoiGianKethuc = "00:00";
          ListAbsentDetails = [];
          ListAbsentAttachFile = [];
          CountListPersonnelAbsentAttachFile = "0";
          CountListAbsentDetails = "0";
        });
      } else if (result.statusCode == 404) {
        SnackbarError.showSnackbar_Waiting(context,
            message: result.description.toString());
      } else {
        DialogMessage_Error.showMyDialog(
            context, result.description.toString());
      }
    } catch (e) {
      print(e.toString());
      await DialogMessage_Error.showMyDialog(context, e.toString());
    }
  }

  /*====Đoạn xử lý giao diện===*/

  Future<bool> loadData() async {
    await Future.delayed(Duration(seconds: 0)); // Giả lập thời gian tải
    await API_LoadDataPersonnelAbsentType();
    LoadDataTimekeepingInfo();
    return true;
  }

  Future<void> _refreshData() async {
    // Giả định rằng bạn sẽ làm thao tác làm mới dữ liệu ở đây.
    await Future.delayed(Duration(seconds: 0));
    _FlagBtn = 0;
    setState(() {
      _DonPhep = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phiếu đề nghị nghỉ phép"),
        backgroundColor: Color(0xFFFED801C),
        titleTextStyle: TextStyle(
          color: Colors.white, // Set the title color
          fontSize: 20,        // Optional: Set font size
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, 'refresh');
          },),
        actions: [
          IconButton(onPressed: () async {
            FocusScope.of(context).unfocus();
            await API_TaoDonPhep(context);
          }, icon: Icon(Icons.save_outlined, color: Colors.white,))
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        child: FutureBuilder<bool>(
            future: loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
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
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Loại đơn phép:",
                                      style: TextStyle(
                                          fontFamily: "Roboto", fontSize: 13),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            shape: const OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            20))),
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (BuildContext context) {
                                              return PersonnelAbsentCreate_PopupView(
                                                AddPersonnelAbsenType:
                                                    AddPersonnelAbsenType,
                                                ListData_PersonnelAbsenType:
                                                    listdata,
                                              );
                                            });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  _NameType,
                                                  style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Icon(
                                                    Icons.arrow_drop_down_sharp,
                                                    color: Colors.black,
                                                    size: 30)
                                              ],
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // Text("Thông tin phép:",
                              //     style: TextStyle(
                              //         fontFamily: "Roboto",
                              //         fontSize: 13,
                              //         color: Colors.black,
                              //         fontWeight: FontWeight.bold)),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // Text(
                              //     "- Số ngày công: " + _SoNgayCong+
                              //     "\n- Số ngày nghỉ phép: "+ _SoNgayNghiPhep,
                              //     style: TextStyle(
                              //         fontFamily: "Roboto", fontSize: 13)),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Lưu ý: ",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  "_Nghỉ phép dưới 3 ngày tạo đơn trước 1 ngày \n_ Nghỉ trên 3 ngày cần tạo trước 1 tuần",
                                  style: TextStyle(
                                      fontFamily: "Roboto", fontSize: 13)),
                              SizedBox(
                                height: 15,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Center(
                                      child: Container(
                                        // Chiều rộng của nút tròn
                                        height: 30, // Chiều cao của nút tròn
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Xử lý sự kiện khi nút được nhấn
                                            setState(() {
                                              _FlagBtn = 1;
                                              _DonPhep = "Nhiều ngày";
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              // Kích thước tối thiểu của nút
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10), // Bo góc của nút (0 là vuông)
                                              ),
                                              backgroundColor:
                                                  Colors.orangeAccent),
                                          // Màu nền của nút tròn
                                          child: Center(
                                            child: Text("Nhiều ngày",
                                                style: TextStyle(
                                                    fontFamily: "Roboto",
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ), // Icon bên trong nút tròn
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Center(
                                      child: Container(
                                        // Chiều rộng của nút tròn
                                        height: 30, // Chiều cao của nút tròn
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Xử lý sự kiện khi nút được nhấn
                                            setState(() {
                                              _FlagBtn = 2;
                                              _DonPhep = "Một ngày";
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              // Kích thước tối thiểu của nút
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10), // Bo góc của nút (0 là vuông)
                                              ),
                                              backgroundColor:
                                                  Colors.orangeAccent),
                                          // Màu nền của nút tròn
                                          child: Center(
                                            child: Text("Một ngày",
                                                style: TextStyle(
                                                    fontFamily: "Roboto",
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ), // Icon bên trong nút tròn
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Center(
                                      child: Container(
                                        // Chiều rộng của nút tròn
                                        height: 30, // Chiều cao của nút tròn
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Xử lý sự kiện khi nút được nhấn
                                            setState(() {
                                              _FlagBtn = 3;
                                              _DonPhep = "Buổi sáng";
                                              //_selectTime(context,0);
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              // Kích thước tối thiểu của nút
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10), // Bo góc của nút (0 là vuông)
                                              ),
                                              backgroundColor:
                                                  Colors.orangeAccent),
                                          // Màu nền của nút tròn
                                          child: Center(
                                            child: Text("Buổi sáng",
                                                style: TextStyle(
                                                    fontFamily: "Roboto",
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ), // Icon bên trong nút tròn
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Center(
                                      child: Container(
                                        // Chiều rộng của nút tròn
                                        height: 30, // Chiều cao của nút tròn
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Xử lý sự kiện khi nút được nhấn
                                            setState(() {
                                              _FlagBtn = 4;
                                              _DonPhep = "Buổi chiều";
                                              //_selectTime(context,1);
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              // Kích thước tối thiểu của nút
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10), // Bo góc của nút (0 là vuông)
                                              ),
                                              backgroundColor:
                                                  Colors.orangeAccent),
                                          // Màu nền của nút tròn
                                          child: Center(
                                            child: Text("Buổi chiều",
                                                style: TextStyle(
                                                    fontFamily: "Roboto",
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ), // Icon bên trong nút tròn
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    if (_AbsenType == "05")
                                      Container(
                                        // Chiều rộng của nút tròn
                                        height: 30, // Chiều cao của nút tròn
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Xử lý sự kiện khi nút được nhấn
                                            setState(() {
                                              _FlagBtn = 5;
                                              _DonPhep = "Theo giờ";
                                              //_selectTime(context,0);
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              // Kích thước tối thiểu của nút
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10), // Bo góc của nút (0 là vuông)
                                              ),
                                              backgroundColor:
                                                  Colors.orangeAccent),
                                          // Màu nền của nút tròn
                                          child: Center(
                                            child: Text("Theo giờ",
                                                style: TextStyle(
                                                    fontFamily: "Roboto",
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ), // Icon bên trong nút tròn
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Column(
                                children: [
                                  Text(
                                    _DonPhep,
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 12,
                                        color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (_FlagBtn == 1 ||
                                          _FlagBtn == 2 ||
                                          _FlagBtn == 3 ||
                                          _FlagBtn == 4 ||
                                          _FlagBtn == 5)
                                        Column(
                                          children: [
                                            Text("Từ ngày:"),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _showCalendarFormDatePopup(
                                                    context);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          DateFormat(
                                                                  'dd/MM/yyyy')
                                                              .format(
                                                                  _selectFormDate),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Icon(
                                                            Icons
                                                                .calendar_month,
                                                            size: 20)
                                                      ],
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                      if (_FlagBtn == 1)
                                        Column(
                                          children: [
                                            Text("Đến ngày: "),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _showCalendarToDatePopup(
                                                    context);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          DateFormat(
                                                                  'dd/MM/yyyy')
                                                              .format(
                                                                  _selectToDate),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Icon(
                                                            Icons
                                                                .calendar_month,
                                                            size: 20)
                                                      ],
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                      if (_FlagBtn == 3)
                                        Container(
                                          child: Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child: Text("8:00 đến 12:00 ",
                                                  style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green))),
                                        ),
                                      if (_FlagBtn == 4)
                                        Container(
                                          child: Padding(
                                              padding: EdgeInsets.only(top: 15),
                                              child: Text("13:00 đến 17:00 ",
                                                  style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green))),
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (_AbsenType == "05" && _FlagBtn == 5)
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                _selectTime(context, 0);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          _ThoiGianBatDau,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Icon(Icons.av_timer,
                                                            size: 20)
                                                      ],
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                      if (_AbsenType == "05" && _FlagBtn == 5)
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                _selectTime(context, 1);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          _ThoiGianKethuc,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Icon(Icons.av_timer,
                                                            size: 20)
                                                      ],
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: TextField(
                                  maxLines: null,
                                  controller: _txtLyDo,
                                  textInputAction: TextInputAction.done,
                                  //textInputAction: TextInputAction.newline,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Lý do nghỉ phép', // Văn bản gợi ý khi không có văn bản được nhập
                                    border: OutlineInputBorder(), // Đường viền
                                    // Các thuộc tính khác của InputDecoration
                                  ),
                                  style: TextStyle(height: 1.5),
                                  onEditingComplete: () {
                                    // Gọi hàm để tắt bàn phím khi người dùng nhấn Enter
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: TextField(
                                  maxLines: null,
                                  controller: _txtGhiChu,
                                  textInputAction: TextInputAction.done,
                                  //textInputAction: TextInputAction.newline,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Ghi chú', // Văn bản gợi ý khi không có văn bản được nhập
                                    border: OutlineInputBorder(), // Đường viền
                                    // Các thuộc tính khác của InputDecoration
                                  ),
                                  style: TextStyle(height: 1.5),
                                  onEditingComplete: () {
                                    // Gọi hàm để tắt bàn phím khi người dùng nhấn Enter
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Divider(
                                // Đây là đường kẻ ngang
                                color:
                                    Color(0xFFdfe6e9), // Màu sắc của đường kẻ
                                thickness: 1, // Độ dày của đường kẻ
                                indent: 10, // Khoảng cách từ lề trái
                                endIndent: 10, // Khoảng cách từ lề phải
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Chi tiết bàn giao: ",
                                            style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 13,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            CountListAbsentDetails,
                                            style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 13,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
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
                                                    return PersonnelAbsentDateCreate_PopupView(
                                                      AddPersonnelAbsentDetails:
                                                          AddPersonnelAbsentDetails,
                                                    );
                                                  });
                                            },
                                            child: Icon(Icons.add_circle_sharp,
                                                color: Colors.green, size: 30),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PersonnelAbsentDateDetailView(
                                                              ListAbsentDetails:
                                                                  ListAbsentDetails,
                                                              RemovePersonnelAbsentDetails:
                                                                  RemovePersonnelAbsentDetails)));
                                            },
                                            child: Icon(Icons.remove_circle,
                                                color: Colors.red, size: 30),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(
                                    // Đây là đường kẻ ngang
                                    color: Color(
                                        0xFFdfe6e9), // Màu sắc của đường kẻ
                                    thickness: 1, // Độ dày của đường kẻ
                                    indent: 10, // Khoảng cách từ lề trái
                                    endIndent: 10, // Khoảng cách từ lề phải
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Thông tin đính kèm (nếu có): ",
                                            style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 13,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            CountListPersonnelAbsentAttachFile,
                                            style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 13,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
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
                                                    return PersonnelAbsentAttachFile_PopupView(
                                                        AddPersonnelAbsentAttachFile:
                                                            AddPersonnelAbsentAttachFile);
                                                  });
                                            },
                                            child: Icon(Icons.add_circle_sharp,
                                                color: Colors.green, size: 30),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AbsentAttachFileDetail_PopupView(
                                                            RemovePersonnelAbsentAttachFile:
                                                                RemovePersonnelAbsentAttachFile,
                                                            ListAbsentAttachFile:
                                                                ListAbsentAttachFile,
                                                          )));
                                            },
                                            child: Icon(Icons.remove_circle,
                                                color: Colors.red, size: 30),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                );
              }
            }),
        onRefresh: _refreshData,
      ),
    );
  }

  void _showCalendarFormDatePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.6,
          child: TableCalendar(
            focusedDay: _selectFormDate,
            rowHeight: 32,
            locale: "vi_VN",
            //headerVisible: false,
            //headerVisible: false,
            headerStyle: HeaderStyle(
              formatButtonVisible: false, // Ẩn nút chuyển đổi định dạng
              titleTextStyle:
                  TextStyle(color: Colors.white), // Màu chữ của tiêu đề
              decoration: BoxDecoration(
                color: Colors.blue, // Màu nền của header
              ),
            ),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blue, // Màu sắc khi ngày được chọn
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ), // Ẩn các ngày ngoài phạm vi của tháng hiện tại
            ),
            calendarFormat: _calendarFormat,
            availableCalendarFormats: {
              CalendarFormat.week: 'Tuần', // Chỉ có định dạng "Week" (1 tuần)
              CalendarFormat.month: 'Tháng', // Định dạng "Month" (tháng)
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectFormDate = selectedDay;
              });
              Navigator.pop(context); // Đóng popup sau khi chọn ngày
              // Thêm bất kỳ xử lý nào bạn muốn sau khi chọn ngày ở đây
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectFormDate, day);
            },
          ),
        ),
      ),
    );
  }

  void _showCalendarToDatePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width * 1.5,
          height: MediaQuery.of(context).size.height * 0.6,
          child: TableCalendar(
            rowHeight: 32,
            locale: "vi_VN",
            focusedDay: _selectToDate,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            calendarFormat: _calendarFormat,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blue, // Màu sắc khi ngày được chọn
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ), // Ẩn các ngày ngoài phạm vi của tháng hiện tại
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false, // Ẩn nút chuyển đổi định dạng
              titleTextStyle:
                  TextStyle(color: Colors.white), // Màu chữ của tiêu đề
              decoration: BoxDecoration(
                color: Colors.blue, // Màu nền của header
              ),
            ),
            availableCalendarFormats: {
              CalendarFormat.week: 'Tuần', // Chỉ có định dạng "Week" (1 tuần)
              CalendarFormat.month: 'Tháng', // Định dạng "Month" (tháng)
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectToDate = selectedDay;
              });
              Navigator.pop(context); // Đóng popup sau khi chọn ngày
              // Thêm bất kỳ xử lý nào bạn muốn sau khi chọn ngày ở đây
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectToDate, day);
            },
          ),
        ),
      ),
    );
  }
}
