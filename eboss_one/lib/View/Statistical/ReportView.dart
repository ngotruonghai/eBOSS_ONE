import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ReportView extends StatefulWidget {
  ReportView({super.key});

  @override
  State<ReportView> createState() => _ReportView();
}

class _ReportView extends State<ReportView> {

  //function
  Future<bool> loadData(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2)); // Giả lập thời gian tải
    return true;
  }

  Future<void> _refreshData() async {
    // Giả định rằng bạn sẽ làm thao tác làm mới dữ liệu ở đây.
    await Future.delayed(Duration(seconds: 0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
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
                return Container(
                  color: Color(0xFFF5F5F5),
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Border radius
                                  ),
                                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("01/08/2023",style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Roboto",
                                          color: Colors.grey)),
                                      Icon(Icons.calendar_month),
                                    ],
                                  ),),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 30,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Border radius
                                  ),
                                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("01/08/2023",style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Roboto",
                                            color: Colors.grey)),
                                        Icon(Icons.calendar_month),
                                      ],
                                    ),),
                                )
                              ],
                            ),),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Border radius
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("Tất cả",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Roboto",
                                                color: Colors.grey)),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              "18",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            )),
                                        Text("Công việc",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Roboto",
                                                color: Colors.grey)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Icon(
                                          Icons.work,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Border radius
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("Đang xử lý",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Roboto",
                                                color: Colors.grey)),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              "3",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange),
                                            )),
                                        Text("Công việc",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Roboto",
                                                color: Colors.grey)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Icon(
                                          Icons.work_history,
                                          size: 20,
                                          color: Colors.orange,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Border radius
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("Tất cả",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Roboto",
                                                color: Colors.grey)),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              "18",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            )),
                                        Text("Công việc",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Roboto",
                                                color: Colors.grey)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Icon(
                                          Icons.work,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Border radius
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text("Đang xử lý",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Roboto",
                                                color: Colors.grey)),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Text(
                                              "3",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange),
                                            )),
                                        Text("Công việc",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Roboto",
                                                color: Colors.grey)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Icon(
                                          Icons.work_history,
                                          size: 20,
                                          color: Colors.orange,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Danh sách báo cáo",style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                                Text("Lập báo cáo",style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: "Roboto",
                                    color: Colors.blue)),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0, left: 10, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 2.0,
                                child: SizedBox(
                                  height: 80,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 5, right: 5),
                                        child: Row(
                                          children: [
                                            Padding(padding: EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.green,
                                                  size: 20,
                                                )),
                                            Container(
                                              width: screenWidth-100,
                                              child: Text(
                                                "Báo cáo công việc",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 15, left: 40, right: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Báo cáo cho: Ngô Trường Hải",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: "Roboto"),
                                            ),
                                            Text(
                                              "04/08/1999",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: "Roboto"),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0, left: 10, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 2.0,
                                child: SizedBox(
                                  height: 80,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 5, right: 5),
                                        child: Row(
                                          children: [
                                            Padding(padding: EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.green,
                                                  size: 20,
                                                )),
                                            Container(
                                              width: screenWidth-100,
                                              child: Text(
                                                "Báo cáo công việc",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 15, left: 40, right: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Báo cáo cho: Ngô Trường Hải",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: "Roboto"),
                                            ),
                                            Text(
                                              "04/08/1999",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: "Roboto"),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0, left: 10, right: 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 2.0,
                                child: SizedBox(
                                  height: 80,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 5, right: 5),
                                        child: Row(
                                          children: [
                                            Padding(padding: EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.green,
                                                  size: 20,
                                                )),
                                            Container(
                                              width: screenWidth-100,
                                              child: Text(
                                                "Báo cáo công việc",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 15, left: 40, right: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Báo cáo cho: Ngô Trường Hải",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: "Roboto"),
                                            ),
                                            Text(
                                              "04/08/1999",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: "Roboto"),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),);
                      }),
                );
              }
            }),
        onRefresh: _refreshData,
      ),
    );
  }
}
