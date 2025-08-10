import 'dart:convert';
import 'package:flutter/material.dart';
import '../../Model/EmployeeInfo/GetEmployeeInfo.dart';
import '../../Services/BaseServices/SharedPreferencesService.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import 'UserInfoCapacityView.dart';

class UserInfoDetailView extends StatefulWidget {
  UserInfoDetailView({super.key, required this.UserID});
  final String UserID;
  @override
  State<UserInfoDetailView> createState() => _UserInfoDetailView();
}

List<Data>? listdata;
Future<int> loaddataMissionUnFinish() async {
  Map<String, dynamic> request = {
    'applyDate': "",
    'employeeAID':
        SharedPreferencesService.getString(KeyServices.KeyEmployeeAID)
            .toString(),
  };
  final responses = await NetWorkRequest.PostJWT(
      "/eBOSS/api/Employee/GetEmployeeInfo", request);
  final UserInfo = GetEmployeeInfo.fromJson(responses);
  listdata = UserInfo.data;
  return 1;
}

class _UserInfoDetailView extends State<UserInfoDetailView> {
  Future<bool> loadData() async {
    try {
      await Future.delayed(Duration(seconds: 0));
      await loaddataMissionUnFinish(); // Giả lập thời gian tải
      return true;
    } catch (e) {
      print("Đã bị lỗi" + e.toString());
      NetWorkRequest.Error404(context);
      return false;
    }
  }

  Future<void> _refreshData() async {
    // Giả định rằng bạn sẽ làm thao tác làm mới dữ liệu ở đây.
    await Future.delayed(Duration(seconds: 0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFED801C),
        title: Text(
          "Hồ sơ cá nhân",
          style: TextStyle(fontFamily: "Roboto"),
        ),
        titleTextStyle: TextStyle(
          color: Colors.white, // Set the title color
          fontSize: 20,        // Optional: Set font size
        ),
      ),
      body: RefreshIndicator(
          onRefresh: _refreshData,
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
                  return SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 10, top: 10, left: 5),
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: ClipOval(
                                            child: Image.memory(
                                              base64Decode(listdata![0]
                                                  .photo
                                                  .toString()),
                                              fit: BoxFit.cover,
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    listdata![0]
                                                        .nameVietnamese
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        fontFamily: "Roboto")),
                                                Container(
                                                  width: 300,
                                                  child: Text(
                                                      "Bộ phận: " +
                                                          listdata![0]
                                                              .departmentName
                                                              .toString() +
                                                          " - " +
                                                          listdata![0]
                                                              .workTitleName
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              "Roboto")),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Mã nhân viên",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: "Roboto"),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      listdata![0].employeeID.toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: "Roboto", fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Công ty",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: "Roboto"),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      listdata![0].companyID.toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: "Roboto", fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Ngày vào làm",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: "Roboto"),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      listdata![0].joinDate.toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: "Roboto", fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Số năm cống hiến",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: "Roboto"),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      "Null Data",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: "Roboto", fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Chức danh",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: "Roboto"),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      listdata![0]
                                          .professionalTitleName
                                          .toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: "Roboto", fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Cấp bậc chuyên môn",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: "Roboto"),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      listdata![0].rankLevelName.toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: "Roboto", fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sinh nhật",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: "Roboto"),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      listdata![0].birthDate.toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: "Roboto", fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Địa chỉ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: "Roboto"),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      listdata![0].address.toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: "Roboto", fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Số điện thoại",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: "Roboto"),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      listdata![0].mobile.toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: "Roboto", fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Email công ty",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: "Roboto"),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      listdata![0].emailEboss.toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: "Roboto", fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Email cá nhân",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: "Roboto"),
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      listdata![0].emailFordward.toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontFamily: "Roboto", fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Năng lực",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: "Roboto"),
                                  ),
                                  Container(
                                    width: 200,
                                    child: InkWell(
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserInfoCapacityView(
                                                      RankLevelDescription:
                                                          listdata![0]
                                                              .rankLevelDescription
                                                              .toString())),
                                        );
                                      },
                                      child: Text(
                                        "Xem chi tiết...",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontFamily: "Roboto", fontSize: 13),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  );
                }
              })),
    );
  }
}

class DialogErrorNetWork {
  static Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('You can add more content here.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // close the dialog
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
