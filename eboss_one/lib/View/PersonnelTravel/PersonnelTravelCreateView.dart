import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../Model/PersonnelAbsentTravel/DiaDiemCongTacModel.dart';
import '../../Model/PersonnelAbsentTravel/PersonnelAbsentTypeModel.dart'as ModelPersonnelAbsentType;
import '../../Services/BaseServices/SharedPreferencesService.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import '../../Services/ShowDialog/DialogMessage_Error.dart';
import '../../Services/ShowDialog/SnackbarError.dart';
import 'AbsentTravelDetail_PopupView.dart';
import 'PersonnelTravelCreateDetail_PopupView.dart';
import 'PersonnelTravelCreate_PopupView.dart';
import '../../Model/PersonnelAbsent/PersonnelAbsentResultModel.dart' as PersonnelAbsentResul;

class PersonnelTravelCreateView extends StatefulWidget {
  PersonnelTravelCreateView({super.key});

  @override
  State<PersonnelTravelCreateView> createState() =>
      _PersonnelTravelCreateView();
}

class _PersonnelTravelCreateView extends State<PersonnelTravelCreateView> {
  String _ThoiGianBatDau = "08:00";
  String _ThoiGianKethuc = DateFormat("HH:mm").format(DateTime.now());
  String _NameTravel = "Xe máy (Tự trang bị)";
  String _TransportID = "01";

  TextEditingController _txtGhiChu = TextEditingController();

  late List<ModelPersonnelAbsentType.Data> _listDanhSachPhuongTien;
  List<DiaDiemCongTacModel> _lsDiaDiemCongTac = [];

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectFormDate = DateTime.now();
  DateTime _selectToDate = DateTime.now();
  late TimeOfDay _selectedTime;
  String _CountDiaDIemCongTac = "0";

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

  /*Call API*/
  Future<void> API_DanhSachPhuongTien() async {
    try {
      final responses = await NetWorkRequest.GetJWT(
          "/eBOSS/api/PersonnelTravel/LoadDataPersonnelAbsentType");
      final result =
          ModelPersonnelAbsentType.PersonnelAbsentTypeModel.fromJson(responses);
      if (result.statusCode == 200) {
        _listDanhSachPhuongTien = result.data!;
      } else {
        _listDanhSachPhuongTien = [];
      }
    } catch (e) {
      _listDanhSachPhuongTien = [];
    }
  }
  Future<void> API_TaoDonCongTac(BuildContext context) async {
    try{
      /*Kiểm tra trước add*/
      if (_CountDiaDIemCongTac == "0") {
        await DialogMessage_Error.showMyDialog(
            context, "Vui lòng tạo it nhất 1 địa điểm công tác");
        return;
      }

      List<Map<String, dynamic>> jsonData =
      _lsDiaDiemCongTac.map((data) => data.toJson()).toList();
      String jsonStrDiaDiemCOngTac = jsonEncode(jsonData);

      Map<String, dynamic> request = {
        "employeeAID":
        SharedPreferencesService.getString(KeyServices.KeyEmployeeAID),
        "transportID": _TransportID,
        "formDate": DateFormat('dd/MM/yyyy').format(_selectFormDate),
        "toDate": DateFormat('dd/MM/yyyy').format(_selectToDate),
        "startTime": _ThoiGianBatDau,
        "endTime": _ThoiGianKethuc,
        "ghiChu": _txtGhiChu.text,
        "diaDiemCongTac": jsonStrDiaDiemCOngTac
      };
      final responses = await NetWorkRequest.PostJWT(
          "/eBOSS/api/PersonnelTravel/CreatePersonnelTrave", request);
      final result =
      PersonnelAbsentResul.PersonnelAbsentResultModel.fromJson(responses);

      if (result.statusCode == 200) {
        SnackbarError.showSnackbar_Succes(context,
            message: result.description.toString());

        setState(() {
          _txtGhiChu.text = "";
          _ThoiGianBatDau = "00:00";
          _ThoiGianKethuc = "00:00";
          _listDanhSachPhuongTien = [];
          _NameTravel = "";
          _TransportID = "";
          _CountDiaDIemCongTac = "0";
          _lsDiaDiemCongTac= [];
        });
      }else if (result.statusCode == 404) {
        SnackbarError.showSnackbar_Waiting(context,
            message: result.description.toString());
      } else {
        DialogMessage_Error.showMyDialog(
            context, result.description.toString());
      }
    }
    catch(e){
      await DialogMessage_Error.showMyDialog(context, e.toString());
    }
  }

  /*Call API*/

  Future<void> AddPersonnelTravelType(
      String NameTravel, String TransportID) async {
    setState(() {
      _NameTravel = NameTravel;
      _TransportID = TransportID;
    });
  }

  Future<void> AddPersonnelTravelDetail(int id,String KhuVuc,String LoaiCongtac,String DienGiai,String ChipPhiPhatSinh, String LyDoPhatSinh, String GhiChu, String TenKhuVuc, String TenLoaiCongTac) async {
    _lsDiaDiemCongTac.add(DiaDiemCongTacModel(Id: id,KhuVuc: KhuVuc, LoaiCongtac: LoaiCongtac, DienGiai: DienGiai
        , ChipPhiPhatSinh: ChipPhiPhatSinh, LyDoPhatSinh: LyDoPhatSinh
        , GhiChu: GhiChu, TenKhuVuc: TenKhuVuc,TenLoaiCongTac: TenLoaiCongTac));
    setState(() {
      _CountDiaDIemCongTac = _lsDiaDiemCongTac.length.toString();
    });
  }
  Future<void> RemovePersonnelTravel(int Id) async {
    _lsDiaDiemCongTac.removeWhere((item) => item.Id == Id);
    setState(() {
      _CountDiaDIemCongTac =
          _lsDiaDiemCongTac.length.toString();
    });
  }

  Future<bool> loadData() async {
    //await Future.delayed(Duration(seconds: 1)); // Giả lập thời gian tải
    await API_DanhSachPhuongTien();
    return true;
  }

  Future<void> _refreshData() async {
    // Giả định rằng bạn sẽ làm thao tác làm mới dữ liệu ở đây.
    await Future.delayed(Duration(seconds: 0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tạo phiếu đề nghị công tác"),
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
              await API_TaoDonCongTac(context);
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
                                vertical: 10, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Phương tiện:",
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
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(20))),
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) {
                                          return PersonnelTravelCreate_PopupView(
                                            AddPersonnelTravelType:
                                                AddPersonnelTravelType,
                                            ListData: _listDanhSachPhuongTien,
                                          );
                                        });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _NameTravel,
                                              style: TextStyle(
                                                  fontFamily: "Roboto",
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(Icons.arrow_drop_down_sharp,
                                                color: Colors.black, size: 30)
                                          ],
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text("Giờ bắt đầu:"),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _showCalendarFormDatePopup(context);
                                          },
                                          child: Container(
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
                                                      DateFormat('dd/MM/yyyy')
                                                          .format(
                                                              _selectFormDate),
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Icon(Icons.calendar_month,
                                                        size: 20)
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("Giờ kết thúc:"),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _showCalendarToDatePopup(context);
                                          },
                                          child: Container(
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
                                                      DateFormat('dd/MM/yyyy')
                                                          .format(
                                                              _selectToDate),
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Icon(Icons.calendar_month,
                                                        size: 20)
                                                  ],
                                                )),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _selectTime(context, 0);
                                          },
                                          child: Container(
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
                                                      _ThoiGianBatDau,
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontSize: 15,
                                                          color: Colors.black),
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
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _selectTime(context, 1);
                                          },
                                          child: Container(
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
                                                      _ThoiGianKethuc,
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontSize: 15,
                                                          color: Colors.black),
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
                                Container(
                                  child: TextField(
                                    maxLines: null,
                                    controller: _txtGhiChu,
                                    textInputAction: TextInputAction.done,
                                    //textInputAction: TextInputAction.newline,
                                    decoration: InputDecoration(
                                      hintText:
                                          'ghi chú...', // Văn bản gợi ý khi không có văn bản được nhập
                                      border:
                                          OutlineInputBorder(), // Đường viền
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
                                              "Địa điểm công tác: ",
                                              style: TextStyle(
                                                  fontFamily: "Roboto",
                                                  fontSize: 13,
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              _CountDiaDIemCongTac,
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
                                                      return PersonnelTravelCreateDetail_PopupView(
                                                        AddPersonnelTravelDetail: AddPersonnelTravelDetail,
                                                      );
                                                    });
                                              },
                                              child: Icon(
                                                  Icons.add_circle_sharp,
                                                  color: Colors.green,
                                                  size: 30),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                // code01
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AbsentTravelDetail_PopupView(DSDiaDiemCongTac: _lsDiaDiemCongTac, RemovePersonnelTravel: RemovePersonnelTravel,
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
