import 'package:flutter/material.dart';
import '../../Model/UserInfo/PermissionEmpModel.dart' as PermissionEmpModel;
import '../../Services/BaseServices/SharedPreferencesService.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import '../Calendar/CalendarView.dart';
import '../PersonnelAbsent/PersonnelAbsentView.dart';
import '../PersonnelOvertime/PersonnelOvertimeView.dart';
import '../PersonnelTravel/PersonnelTravelView.dart';
import '../Task/TaskDetailView.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({
    super.key,
  });

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  late List<PermissionEmpModel.Data> ListPermission;

  /*START call API danh phân quyền danh mục*/
  Future<void> API_PermissionEmpAID() async {
    Map<String, dynamic> request = {
      'userID': SharedPreferencesService.getString(KeyServices.KeyUserID),
      'employeeAID':
          SharedPreferencesService.getString(KeyServices.KeyEmployeeAID),
    };
    final responses = await NetWorkRequest.PostJWT(
        "/eBOSS/api/MobileInfo/PermissionEmp", request);
    final Response = PermissionEmpModel.PermissionEmpModel.fromJson(responses);
    ListPermission = Response.data!;
  }

  /*END call API danh phân quyền danh mục*/
  Future<bool> loadData() async {
    await API_PermissionEmpAID(); // Giả lập thời gian tải
    return true;
  }

  Future<void> _refreshData() async {
    // Giả định rằng bạn sẽ làm thao tác làm mới dữ liệu ở đây.
    Future.delayed(Duration(seconds: 0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: RefreshIndicator(
        backgroundColor: Colors.white,
        child: FutureBuilder<bool>(
            future: loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Hiển thị trang tải
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepOrange,
                  ),
                );
              } else {
                return Drawer(
                  backgroundColor: const Color(0xFFFF7034),
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Color(0xFFFED801C),
                      title: const Text("Danh mục"),
                      titleTextStyle: TextStyle(
                        color: Colors.white, // Set the title color
                        fontSize: 20,        // Optional: Set font size
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (ListPermission.length < 0)
                            Text("")
                          else
                            Column(
                              children: ListPermission.map((item) {
                                return Column(
                                  children: [
                                    // Báo cáo nhiệm vụ
                                    if (item.functionName.toString() ==
                                        "BaoCaoNhiemVu")
                                      Column(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 20),
                                              child: InkWell(
                                                child: SizedBox(
                                                  height: 30,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 10),
                                                        child: Image.asset(
                                                          "assets/productivity.png",
                                                          width: 40, // bạn có thể điều chỉnh kích thước icon
                                                          height: 30,
                                                        ),
                                                      ),
                                                      Text(
                                                        item.nameVietnamese
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily: "Roboto",
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TaskDetail()),
                                                  );
                                                },
                                              )),
                                          Divider(
                                            // Đường kẻ ngang
                                            color: Colors.grey, // Màu sắc của đường kẻ ngang
                                            thickness: 0.5,
                                            indent: 20,           // Khoảng cách từ cạnh trái
                                            endIndent: 20, // Độ dày của đường kẻ ngang
                                          ),
                                        ],
                                      ),

                                    // Lịch chuyên cần
                                    if (item.functionName.toString() ==
                                        "LichChuyenCan")
                                      Column(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 20),
                                              child: InkWell(
                                                child: SizedBox(
                                                  height: 30,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 10),
                                                        child: Image.asset(
                                                          "assets/schedule.png",
                                                          width: 40, // bạn có thể điều chỉnh kích thước icon
                                                          height: 30,
                                                        ),
                                                      ),
                                                      Text(
                                                        item.nameVietnamese
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily: "Roboto",
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Calendar()),
                                                  );
                                                },
                                              )),
                                          Divider(
                                            // Đường kẻ ngang
                                            color: Colors.grey, // Màu sắc của đường kẻ ngang
                                            thickness: 0.5,
                                            indent: 20,           // Khoảng cách từ cạnh trái
                                            endIndent: 20, // Độ dày của đường kẻ ngang
                                          ),
                                        ],
                                      ),
                                    // Đơn phép
                                    if (item.functionName.toString() ==
                                        "DonPhep")
                                      Column(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 20),
                                              child: InkWell(
                                                child: SizedBox(
                                                  height: 30,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 10),
                                                        child: Image.asset(
                                                          "assets/copywriting.png",
                                                          width: 40, // bạn có thể điều chỉnh kích thước icon
                                                          height: 30,
                                                        ),
                                                      ),
                                                      Text(
                                                        item.nameVietnamese
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily: "Roboto",
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PersonnelAbsentView()),
                                                  );
                                                },
                                              )),
                                          Divider(
                                            // Đường kẻ ngang
                                            color: Colors.grey, // Màu sắc của đường kẻ ngang
                                            thickness: 0.5,
                                            indent: 20,           // Khoảng cách từ cạnh trái
                                            endIndent: 20, // Độ dày của đường kẻ ngang
                                          ),
                                        ],
                                      ),
                                    // Đơn phép công tác
                                    if (item.functionName.toString() == "DonPhepCongTac")
                                      Column(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 20),
                                              child: InkWell(
                                                child: SizedBox(
                                                  height: 30,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 10),
                                                        child: Image.asset(
                                                          "assets/copywriting.png",
                                                          width: 40, // bạn có thể điều chỉnh kích thước icon
                                                          height: 30,
                                                        ),
                                                      ),
                                                      Text(
                                                        item.nameVietnamese
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily: "Roboto",
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PersonnelTravelView()),
                                                  );
                                                },
                                              )),
                                          Divider(
                                            // Đường kẻ ngang
                                            color: Colors.grey, // Màu sắc của đường kẻ ngang
                                            thickness: 0.5,
                                            indent: 20,           // Khoảng cách từ cạnh trái
                                            endIndent: 20, // Độ dày của đường kẻ ngang
                                          ),
                                        ],
                                      ),
                                   // Đơn phép tăng ca
                                    if (item.functionName.toString() == "DonPhepTangCa")
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          child: InkWell(
                                            child: SizedBox(
                                              height: 30,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child: Image.asset(
                                                      "assets/copywriting.png",
                                                      width: 40, // bạn có thể điều chỉnh kích thước icon
                                                      height: 30,
                                                    ),
                                                  ),
                                                  Text(
                                                    item.nameVietnamese
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        fontSize: 15),
                                                  )
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PersonnelOvertimeView()),
                                              );
                                            },
                                          ))
                                  ],
                                );
                              }).toList(),
                            )
                        ],
                      ),
                    ),
                  ),
                );
              }
            }),
        onRefresh: _refreshData,
      ),
    );
  }
}
