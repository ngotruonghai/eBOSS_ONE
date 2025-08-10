import 'dart:convert';

import 'package:flutter/material.dart';
import '../../Model/UserInfo/UserInfoModel.dart';
import '../../Services/BaseServices/MobileVersion.dart';
import '../../Services/BaseServices/SharedPreferencesService.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import '../Login/LoginLayout.dart';
import 'UserInfoDetailView.dart';

class UserInfoView extends StatefulWidget {
  UserInfoView({super.key});

  @override
  State<UserInfoView> createState() => _UserInfoView();
}

class _UserInfoView extends State<UserInfoView> {
  Future<bool> loadData() async {
    try{
      await loaddataMissionUnFinish();
      await Future.delayed(Duration(seconds: 1)); // Giả lập thời gian tải
      return true;
    }catch(e){
      print("Đã bị lỗi"+ e.toString());
      NetWorkRequest.Error404(context);
      return false;
    }
  }

  List<Data>? listdata;

  Future<int> loaddataMissionUnFinish() async {
    final responses = await NetWorkRequest.GetJWT(
        "/eBOSS/api/UserInfo/GetUserInfoID?UserID=" +
            await SharedPreferencesService.getString(KeyServices.KeyUserID));
    final UserInfo = UserInfoModel.fromJson(responses);
    listdata = UserInfo.data;
    return 1;
  }

  Future<void> _refreshData() async {
    // Giả định rằng bạn sẽ làm thao tác làm mới dữ liệu ở đây.
    await Future.delayed(Duration(seconds: 0));
    setState(() {
      loaddataMissionUnFinish();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: RefreshIndicator(
        backgroundColor: Colors.white,
        child: FutureBuilder<bool>(
            future: loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Hiển thị trang tải
                return CircularProgressIndicator(
                  color: Colors.deepOrange,
                );
              } else {
                return Container(
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Container(
                                    child: ClipOval(
                                      child: Image.memory(
                                        base64Decode(listdata![0]
                                            .photo
                                            .toString()),
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                  ),
                                ),
                               Center(
                                 child:  Container(
                                   color: Colors.white,
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Padding(
                                         padding: EdgeInsets.only(
                                             bottom: 10, top: 10),
                                         child: Container(
                                           color: Colors.white,
                                           child: Row(
                                             mainAxisAlignment:
                                             MainAxisAlignment.center,
                                             children: [
                                               Padding(
                                                   padding:
                                                   EdgeInsets.only(left: 10),
                                                   child: Column(
                                                     crossAxisAlignment:
                                                     CrossAxisAlignment
                                                         .center,
                                                     children: [
                                                       Text(
                                                           listdata![0]
                                                               .fullName
                                                               .toString(),
                                                           style: TextStyle(
                                                               fontSize: 15,
                                                               fontWeight:
                                                               FontWeight
                                                                   .bold,
                                                               color:
                                                               Colors.black,
                                                               fontFamily:
                                                               "Roboto")),
                                                     ],
                                                   ))
                                             ],
                                           ),
                                         ),
                                       )
                                     ],
                                   ),
                                 ),
                               ),
                                Divider( // Đây là đường kẻ ngang
                                  color: Color(0xFFdfe6e9), // Màu sắc của đường kẻ
                                  thickness: 1, // Độ dày của đường kẻ
                                  indent: 10, // Khoảng cách từ lề trái
                                  endIndent: 10, // Khoảng cách từ lề phải
                                ),
                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 00),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: 10),
                                                child: Text(
                                                  "Thông tin cá nhân",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                      fontFamily: "Roboto"),
                                                ),
                                              ),
                                              Container(
                                                width: 40,
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 15, // Điều chỉnh kích thước ở đây
                                                  color: Colors.grey, // Tuỳ chọn: Điều chỉnh màu sắc
                                                ),
                                              )
                                            ],
                                          ),
                                          onTap:(){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => UserInfoDetailView(UserID: SharedPreferencesService.getString(KeyServices.KeyUserID),)),
                                            );
                                          } ,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                    20, // Set your desired width
                                                    height:
                                                    20, // Set your desired height
                                                    child: Image.asset(
                                                        'assets/Person.png'),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text("Mã nhân viên",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontFamily:
                                                                  "Roboto")),
                                                          Text(
                                                              listdata![0]
                                                                  .employeeID
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                  "Roboto")),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        20, // Set your desired width
                                                    height:
                                                        20, // Set your desired height
                                                    child: Image.asset(
                                                        'assets/WorkShift.png'),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text("Ca làm việc",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontFamily:
                                                                      "Roboto")),
                                                          Text(
                                                              listdata![0]
                                                                  .workShiftName
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      "Roboto")),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        20, // Set your desired width
                                                    height:
                                                        20, // Set your desired height
                                                    child: Image.asset('assets/Date range.png'),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(left: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Ngày vào làm",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors.grey,
                                                                  fontFamily: "Roboto")),
                                                          Text(
                                                              listdata![0].joinDate.toString(),
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors.black,
                                                                  fontFamily: "Roboto")),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        20, // Set your desired width
                                                    height:
                                                        20, // Set your desired height
                                                    child: Image.asset('assets/Dedicate Year.png'),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text("Số năm cống hiến",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors.grey,
                                                                  fontFamily: "Roboto")),
                                                          Text(
                                                              listdata![0].dedicateYear.toString(),
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors.black,
                                                                  fontFamily: "Roboto")),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider( // Đây là đường kẻ ngang
                                  color: Color(0xFFdfe6e9), // Màu sắc của đường kẻ
                                  thickness: 1, // Độ dày của đường kẻ
                                  indent: 10, // Khoảng cách từ lề trái
                                  endIndent: 10, // Khoảng cách từ lề phải
                                ),
                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 00),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "Công ty: ",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontFamily: "Roboto",
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      TextSpan(
                                                        text: listdata![0].companyID.toString(),
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontFamily: "Roboto"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "Phòng: ",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontFamily: "Roboto",
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      TextSpan(
                                                        text: listdata![0].departmentName.toString(),
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontFamily: "Roboto"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "Đơn vị: ",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontFamily: "Roboto",
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      TextSpan(
                                                        text: listdata![0].workTitleName.toString(),
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontFamily: "Roboto"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "Chức danh: ",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontFamily: "Roboto",
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      TextSpan(
                                                        text: listdata![0].professionalTitleName.toString(),
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontFamily: "Roboto"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "Ngày điều chỉnh chức vụ gần nhất: ",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontFamily: "Roboto",
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      TextSpan(
                                                        text: listdata![0].adjustDate.toString(),
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontFamily: "Roboto"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "Cấp bậc lãnh đạo: ",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontFamily: "Roboto",
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      TextSpan(
                                                        text: listdata![0].rankLeaderName.toString(),
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontFamily: "Roboto"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "Cấp bậc chuyên môn: ",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontFamily: "Roboto",
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      TextSpan(
                                                        text: listdata![0].rankLevelName.toString(),
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontFamily: "Roboto"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider( // Đây là đường kẻ ngang
                                  color: Color(0xFFdfe6e9), // Màu sắc của đường kẻ
                                  thickness: 1, // Độ dày của đường kẻ
                                  indent: 10, // Khoảng cách từ lề trái
                                  endIndent: 10, // Khoảng cách từ lề phải
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 00),
                                    child: InkWell(
                                      onTap: () async {
                                        await SharedPreferencesService.clear();
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login(StatusApp: 0)));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 20, // Set your desired width
                                            height:
                                                20, // Set your desired height
                                            child: Image.asset(
                                                'assets/Logout.png'),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text("Đăng xuất",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Roboto")),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: InkWell(
                                      onTap: () async {
                                        await SharedPreferencesService.clear();
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login(StatusApp: 0)));
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("eBOSS ONE version " + MobileVersion.VersionApp,style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey
                                          ),),
                                          Text("Được phát triển bản quyền bởi eBOSS",style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey
                                          ),)
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
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
}
