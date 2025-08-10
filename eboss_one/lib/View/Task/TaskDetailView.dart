import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/MissionUnFinish/DataMissionUnFinishModel.dart';
import '../../Services/BaseServices/SharedPreferencesService.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import '../../ViewModel/Task/ListTaskViewModel.dart';
import '../Statistical/ReportView.dart';
import '../Statistical/Statistical.dart';

class TaskDetail extends StatefulWidget {
  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  List<Data>? listdata;

  Future<void> _loadInfoMissionUnFinish() async {
    Map<String, dynamic> request = {
      'userID': SharedPreferencesService.getString(KeyServices.KeyUserID),
      'language': '105',
    };

    final responses = await NetWorkRequest.PostJWT("/eBOSS/api/MissionUnFinish/DataMissionUnFinish", request);
    final MissionUnFinish = DataMissionUnFinishModel.fromJson(responses);
    setState(() {
      listdata = MissionUnFinish.data;
    });
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      listdata = null;
    });
    await _loadInfoMissionUnFinish();
  }
  @override
  void initState() {
    super.initState();
    _loadInfoMissionUnFinish();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFED801C),
          title: Text("Quản lý nhiệm vụ"),
          titleTextStyle: TextStyle(
          color: Colors.white, // Set the title color
          fontSize: 20,        // Optional: Set font size
        ),

          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,  // Color for unselected tabs
            indicatorColor: Colors.blue,        // Color of the indicator (underline)
            tabs: [
              Tab(
                icon: Icon(Icons.account_balance_wallet),
                child: Text(
                  "Nhiệm vụ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, fontFamily: "Roboto"),
                ),
              ),
              Tab(
                icon: Icon(Icons.bar_chart),
                child: Text(
                  "Thống kê",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, fontFamily: "Roboto"),
                ),
              ),
              Tab(
                icon: Icon(Icons.ad_units_outlined),
                child: Text(
                  "Báo cáo",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, fontFamily: "Roboto"),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TaskManagement(),
            Statistical(),
            ReportView(),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: const Icon(
        //     Icons.add,
        //     size: 30,
        //   ),
        // ),
      ),
    );
  }

  Container TaskManagement() {
    return Container(
      child: RefreshIndicator(
          backgroundColor: Colors.white,
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (listdata == null) // Sử dụng if để kiểm tra điều kiện
                     Center(
                       child:  Container(
                         child: Text("Đang tải dữ liệu vui lòng đợi..."),
                       ),
                     )
                    else
                      Column(
                        children: [
                          if(listdata?.isEmpty == false)
                            Column(
                              children: listdata!
                                  .map((item) => ListTask(
                                data: item,
                              ))
                                  .toList(),
                            )
                          else
                            Center(
                              child: Text("Không có nhiệm vụ nào"),
                            )
                        ],
                      )
                  ],
                ),
              );
            },
          ),
          onRefresh: _refreshData),
    );
  }
}
