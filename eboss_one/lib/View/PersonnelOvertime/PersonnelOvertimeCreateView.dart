import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Model/PersonnelOverTime/PersonnelOverReqquestModel.dart';
import '../../Model/PersonnelOverTime/PersonnelOverResponseModel.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import 'package:intl/intl.dart';
import '../../Model/PersonnelOverTime/PersonnelOverTypeModel.dart'
as DataOverType;
import '../../Services/ShowDialog/DialogMessage_Error.dart';
import '../../Services/ShowDialog/SnackbarError.dart';
import 'PersonnelOverCreate_PopupView.dart';
import 'PersonnelOverDetailCreate_PopupView.dart';
import 'PersonnelOverDetail_PopupView.dart';

class PersonnelOvertimeCreateView extends StatefulWidget {
  PersonnelOvertimeCreateView({super.key});

  @override
  State<PersonnelOvertimeCreateView> createState() =>
      _PersonnelOvertimeCreateView();
}


class _PersonnelOvertimeCreateView extends State<PersonnelOvertimeCreateView> {

  String _NameType = "Tăng ca thường";
  //String _ThoiGianBatDau = DateFormat("HH:mm").format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 08, 0));
  String _ThoiGianBatDau = "08:00";
  String _ThoiGianKethuc = DateFormat("HH:mm").format(DateTime.now());  
  String _AbsenType = "01";

  TextEditingController _txtGhiChu = TextEditingController();

   List<PersonnelOvertimeDetailModels> personnelOvertimeDetailModels = [];

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectFormDate = DateTime.now();
  DateTime _selectToDate = DateTime.now();
  late TimeOfDay _selectedTime;
  String CountListDetail = "0";

  Future<void> AddPersonnelAbsenType(String NameType, String TypeID) async {
    setState(() {
      _NameType = NameType;
      _AbsenType = TypeID;
    });
  }

  Future<void> AddDetail(String workDescription,String startTime,
                          String endtime, String GhiChu) async {

    int randomId= Random().nextInt(1000);
    personnelOvertimeDetailModels.add(PersonnelOvertimeDetailModels(
      workDescription: workDescription,
      startTime: DateFormat('dd/MM/yyyy').format(_selectFormDate) + " " + startTime,
      endtime: DateFormat('dd/MM/yyyy').format(_selectFormDate) + " " + endtime,
      overtimeAID: "",
      inOrder: 1,
      overTimeHour: "",
      Random: randomId,
      remark: GhiChu
    ));
    setState(() {
      CountListDetail = personnelOvertimeDetailModels.length.toString();
    });
  }

  Future<void> RemoveDetail(BuildContext context,int RandomId) async {
    personnelOvertimeDetailModels.removeWhere((item) => item.Random == RandomId);
    setState(() {
      CountListDetail = personnelOvertimeDetailModels!.length.toString();
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
      initialEntryMode: TimePickerEntryMode.input, // 👈 dùng bàn phím
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

  late List<DataOverType.Data> listdata;

  Future<String> API_LoadDataPersonnelAbsentType() async {
    try {
      final responses = await NetWorkRequest.GetJWT(
          "/eBOSS/api/PersonnelOvertime/LoaiPhieuTangCa");
      final CompanyNotice =
      DataOverType.PersonnelOverTypeModel.fromJson(responses);
      listdata = CompanyNotice.data!;
      return "";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> API_TaoDonTangCa(BuildContext context) async {

    if(CountListDetail == "0")
      {
        await DialogMessage_Error.showMyDialog(
            context, "Vui lòng tạo ít nhất 1 nội dung tăng ca");
        return;
      }

    PersonnelOverReqquestModel requestData = new PersonnelOverReqquestModel();
    requestData.startTime = DateFormat('dd/MM/yyyy').format(_selectFormDate) +" "+ _ThoiGianBatDau;
    requestData.endTime = DateFormat('dd/MM/yyyy').format(_selectFormDate) +" "+ _ThoiGianKethuc;
    requestData.overtimeDate = DateFormat('dd/MM/yyyy').format(_selectFormDate);
    requestData.loaiPhepTangCa = int.parse(_AbsenType);
    requestData.GhiChu = _txtGhiChu.text;
    requestData.personnelOvertimeDetailModels = personnelOvertimeDetailModels;

    Map<String, dynamic> requestMap = requestData.toJson();

    print(jsonEncode(requestMap));

    final responses = await NetWorkRequest.PostJWT_1(
        "/eBOSS/api/PersonnelOvertime/TaoPhieuTangCa", requestMap,context);

    final result = PersonnelOverResponseModel.fromJson(responses);

    SnackbarError.showSnackbar_Succes(context,
        message: "Tạo thành công");

    setState(() {
      _txtGhiChu.text = "";
      personnelOvertimeDetailModels = [];
      CountListDetail = "0";
      _AbsenType = "";
      _NameType = "";
    });
  }

  /*====Đoạn xử lý giao diện===*/

  Future<bool> loadData() async {
    await Future.delayed(Duration(seconds: 0)); // Giả lập thời gian tải
    await API_LoadDataPersonnelAbsentType();
    return true;
  }

  Future<void> _refreshData() async {
    // Giả định rằng bạn sẽ làm thao tác làm mới dữ liệu ở đây.
    await Future.delayed(Duration(seconds: 0));
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tạo phiếu tăng ca"),
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
            await API_TaoDonTangCa(context);
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
                                      "Loại phiếu:",
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
                                              return PersonnelOverCreate_PopupView(
                                                AddPersonnelAbsenType:
                                                AddPersonnelAbsenType,
                                                listData:listdata
                                                ,
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
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text("Ngày tăng ca:"),
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Column(
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
                                    'Ghi chú...', // Văn bản gợi ý khi không có văn bản được nhập
                                    border: OutlineInputBorder(), // Đường viền
                                    // Các thuộc tính khác của InputDecoration
                                  ),
                                  style: TextStyle(height: 1.5),
                                  onEditingComplete: () {
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
                                            "Nội dung tăng ca: ",
                                            style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 13,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            CountListDetail,
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
                                                    return PersonnelOverDetailCreate_PopupView(
                                                    AddDetail:AddDetail,
                                                    gioBatDau: _ThoiGianBatDau,
                                                    gioKetThuc: _ThoiGianKethuc,
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
                                                          PersonnelOverDetail_PopupView(
                                                            RemoveDetail: RemoveDetail,
                                                            listDetail: personnelOvertimeDetailModels,
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
