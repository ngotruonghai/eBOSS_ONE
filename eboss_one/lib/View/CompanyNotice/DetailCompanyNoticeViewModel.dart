import 'package:flutter/material.dart';

import '../../Model/CompanyNoticeRecord/ListCompanyNotice_Deatil.dart';
import '../../Services/NetWork/NetWorkRequest.dart';

class DetailCompanyNoticeViewModel extends StatefulWidget {
  DetailCompanyNoticeViewModel({super.key, required this.notificationID});
  final String notificationID;

  @override
  State<DetailCompanyNoticeViewModel> createState() =>
      _DetailCompanyNoticeViewModel();
}

class _DetailCompanyNoticeViewModel
    extends State<DetailCompanyNoticeViewModel> {
  List<Data>? listdata = null;
  // Call api
  Future<String> loaddataCompanyNotice() async {
    try {
      final responses = await NetWorkRequest.GetJWT(
          "/eBOSS/api/CompanyNoticeRecord/ListCompanyNotice_Deatil?NotificationID=" +
              widget.notificationID);
      final CompanyNotice = ListCompanyNotice_Deatil.fromJson(responses);
      listdata = CompanyNotice.data;
      return CompanyNotice.statusCode.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> loadData() async {
    await loaddataCompanyNotice();
    await Future.delayed(Duration(seconds: 2)); // Giả lập thời gian tải
    return true;
  }

  Future<void> _refreshData() async {
    // Giả định rằng bạn sẽ làm thao tác làm mới dữ liệu ở đây.
    await Future.delayed(Duration(seconds: 0));
    setState(() async {
      await loaddataCompanyNotice();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return (Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết thông báo"),
        backgroundColor: Color(0xFFe67e22),
        titleTextStyle: TextStyle(
          color: Colors.white, // Set the title color
          fontSize: 20,        // Optional: Set font size
        ),

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
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
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Center(
                              child: Text(
                                (listdata![0].notificationAbout.toString()),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: "Roboto"),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "Bộ phận thông báo",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                  fontFamily: "Roboto"),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 1),
                              child: Card(
                                  color: Colors.white60,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.white70,
                                      width: 0.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15, top: 15),
                                      child: Text(
                                        listdata![0].companyID.toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontFamily: "Roboto"),
                                      ),
                                    ),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              "Ngưởi phát hành",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                  fontFamily: "Roboto"),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 1),
                              child: Card(
                                  color: Colors.white60,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.white70,
                                      width: 0.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15, top: 15),
                                      child: Text(
                                        listdata![0].singerName.toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontFamily: "Roboto"),
                                      ),
                                    ),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              "Ngày phát hành",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                  fontFamily: "Roboto"),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 1),
                              child: Card(
                                  color: Colors.white60,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.white70,
                                      width: 0.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15, top: 15),
                                      child: Text(
                                        listdata![0].recordDate.toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontFamily: "Roboto"),
                                      ),
                                    ),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              "Nội dung thông báo:",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Roboto"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 15),
                            child: Text(listdata![0].description.toString(),
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                  fontFamily: "Roboto"),

                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
            onRefresh: _refreshData,
          ),
        ),
      ),
    ));
  }
}
