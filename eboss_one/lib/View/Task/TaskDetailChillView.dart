import 'package:flutter/material.dart';
import '../../Model/MissionUnFinish/DataMissionDetailsModel.dart';
import '../../Model/MissionUnFinish/DataMissionAssignLogModel.dart' as datalog;
import '../../Services/NetWork/NetWorkRequest.dart';
import '../../ViewModel/Mission/MissionAssignLogViewModel.dart';

class TaskDetailView extends StatefulWidget {
  TaskDetailView({super.key, required this.workAID});

  final String workAID;
  @override
  State<TaskDetailView> createState() => _TaskDetailView();
}

class _TaskDetailView extends State<TaskDetailView> {
  @override
  Widget build(BuildContext context) {
    List<Data>? listdata;
    List<datalog.Data>? listdata_AssignLog;
    Map<String, dynamic> request = {
      'workAID': widget.workAID,
      'language': 'NameVietnamese',
    };

    Future<int> loaddataMissionUnFinish() async {
      final responses = await NetWorkRequest.PostJWT(
          "/eBOSS/api/MissionUnFinish/DataMissionDetails", request);
      final UserInfo = DataMissionDetailsModel.fromJson(responses);
      listdata = UserInfo.data;
      return 1;
    }
    Future<int> loadMissionAssignLog() async {
      final responses = await NetWorkRequest.PostJWT(
          "/eBOSS/api/MissionUnFinish/DataMissionAssignLog", request);
      final _datalog = datalog.DataMissionAssignLogModel.fromJson(responses);
      listdata_AssignLog = _datalog.data;
      print(listdata_AssignLog![0].description);
      return 1;
    }

    //function
    Future<bool> loadData() async {
      await Future.delayed(Duration(seconds: 0)); // Giả lập thời gian tải
      await loaddataMissionUnFinish();
      await loadMissionAssignLog();
      return true;
    }

    Future<void> _refreshData() async {
      // Giả định rằng bạn sẽ làm thao tác làm mới dữ liệu ở đây.
      await Future.delayed(Duration(seconds: 0));
      await loaddataMissionUnFinish();
      await loadMissionAssignLog();
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết nhiệm vụ"),
        backgroundColor: Color(0xFFe67e22),
        titleTextStyle: TextStyle(
          color: Colors.white, // Set the title color
          fontSize: 20,        // Optional: Set font size
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
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
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Center(
                                    child: Text(
                                      "THÔNG TIN CHUNG",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontFamily: "Roboto"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "TIến độ công việc",
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
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, bottom: 10, top: 10),
                                            child: Text(
                                              listdata![0]
                                                  .assignStatusName
                                                  .toString(),
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
                                    "Chủ đề",
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
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                top: 10,
                                                right: 15,
                                                bottom: 10),
                                            child: Text(
                                              listdata![0]
                                                  .workAllSummary
                                                  .toString(),
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
                                    "Chi tiết công việc",
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
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                top: 10,
                                                bottom: 10,
                                                right: 15),
                                            child: Text(
                                              listdata![0]
                                                  .workAllDetails
                                                  .toString(),
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
                                    "Dự án phần mềm",
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
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                top: 10,
                                                bottom: 10,
                                                right: 15),
                                            child: Text(
                                              listdata![0].projectName.toString(),
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
                                    "Người ghi",
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
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                top: 10,
                                                bottom: 10,
                                                right: 15),
                                            child: Text(
                                              listdata![0].handlerName.toString(),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: "Roboto"),
                                            ),
                                          ),
                                        ))),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    "Người giao",
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
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                top: 10,
                                                bottom: 10,
                                                right: 15),
                                            child: Text(
                                              listdata![0]
                                                  .navigatorName
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: "Roboto"),
                                            ),
                                          ),
                                        ))),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    "Người nhận",
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
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                top: 10,
                                                bottom: 10,
                                                right: 15),
                                            child: Text(
                                              listdata![0]
                                                  .receiverName
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  //fontWeight: FontWeight.bold,
                                                  fontFamily: "Roboto"),
                                            ),
                                          ),
                                        ))),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Dự kiến hoàn thành",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black87,
                                                fontFamily: "Roboto"),
                                          ),
                                          Card(
                                              color: Colors.white60,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: Colors.white70,
                                                  width: 0.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                              ),
                                              child: Container(
                                                width: 150,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15,
                                                      top: 10,
                                                      bottom: 10,
                                                      right: 15),
                                                  child: Text(
                                                    listdata![0]
                                                        .preFinishDate
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontFamily: "Roboto"),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Khối lượng",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black87,
                                                fontFamily: "Roboto"),
                                          ),
                                          Card(
                                              color: Colors.white60,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: Colors.white70,
                                                  width: 0.0,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                              ),
                                              child: Container(
                                                width: 150,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 15,
                                                      top: 10,
                                                      bottom: 10,
                                                      right: 15),
                                                  child: Text(
                                                    listdata![0]
                                                        .solutionDescription
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontFamily: "Roboto"),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    "Mức độ",
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
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                top: 10,
                                                bottom: 10,
                                                right: 15),
                                            child: Text(
                                              listdata![0].piorityName.toString(),
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
                                    "Ghi chú",
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
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                top: 10,
                                                bottom: 10,
                                                right: 15),
                                            child: Text(
                                              listdata![0].remark.toString(),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontFamily: "Roboto"),
                                            ),
                                          ),
                                        ))),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Lịch sử ghi nhận",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Color(0xFF787878),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto")),
                                Column(
                                  children: listdata_AssignLog!
                                      .map((item) => MissionAssignLogViewModel(data:item ,))
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          );
                        }
                      }),
                  onRefresh: _refreshData,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

