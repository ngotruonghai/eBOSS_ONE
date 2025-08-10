import 'package:flutter/material.dart';
import '../../Model/MissionUnFinish/DataMissionUnFinishModel.dart';
import '../../Services/BaseServices/SharedPreferencesService.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import '../../ViewModel/Task/ListTaskViewModel.dart';

class TaskManagementView extends StatefulWidget {
  TaskManagementView({super.key});

  @override
  State<TaskManagementView> createState() => _TaskManagementView();
}

class _TaskManagementView extends State<TaskManagementView> {
  List<Data>? listdata;

  Future<bool> loadData() async {
    //await Future.delayed(Duration(seconds: 1)); // Giả lập thời gian tải
    try {
      listdata = null;
      await _loadInfoMissionUnFinish();
      await Future.delayed(Duration(seconds: 1));
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<String> _loadInfoMissionUnFinish() async {
    try {
      Map<String, dynamic> request = {
        'userID': SharedPreferencesService.getString(KeyServices.KeyUserID),
        'language': '105',
      };
      final responses = await NetWorkRequest.PostJWT("/eBOSS/api/MissionUnFinish/DataMissionUnFinish", request);
      final MissionUnFinish = DataMissionUnFinishModel.fromJson(responses);
      listdata = MissionUnFinish.data;
      return "";
    }catch (e) {
      return e.toString();
    }
  }



  Future<void> _refreshData() async {
    // Giả định rằng bạn sẽ làm thao tác làm mới dữ liệu ở đây.
    await Future.delayed(Duration(seconds: 0));
    setState(() {
      _loadInfoMissionUnFinish();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  child: ListView.builder(
                      itemCount: 1, itemBuilder: (context, index) {
                    return Column(
                      children: [
                        if(listdata?.isEmpty == false)
                          Column(
                            children: listdata!
                                .map((item) => ListTask(
                              data: item,
                            )).toList(),
                          )
                        else
                          Center(
                            child: Text("Không có nhiệm vụ nào"),
                          )
                      ],

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
