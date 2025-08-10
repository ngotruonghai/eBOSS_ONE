import 'package:flutter/material.dart';
import '../../Model/MissionUnFinish/DataMissionAsignTotalModel.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import '../../ViewModel/Task/ListDataMissionAsignTotalViewModel.dart';

class Statistical extends StatefulWidget {
  Statistical({super.key});

  @override
  State<Statistical> createState() => _Statistical();
}

class _Statistical extends State<Statistical> {
  String TextValues="03";
  List<Data>? listdata;


  Map<String, String> dropdownTexts={
    '01': 'Loại Việc',
    '04': 'Loại phần mềm',
    '05': 'Dự án bảo trì',
    '03': 'Người giao',
    '02': 'Người nhận',
  };
  //function

  Future<String> loaddataMissionUnFinish(String TypeRID) async {
    try {
      final responses = await NetWorkRequest.GetJWT(
          "/eBOSS/api/MissionUnFinish?TypeRID=" + TypeRID);
      final _listdata = DataMissionAsignTotalModel.fromJson(responses);
      listdata = _listdata.data;
      return "Succes";
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> loadData() async {
    await loaddataMissionUnFinish(TextValues);
    await Future.delayed(Duration(seconds: 0)); // Giả lập thời gian tải
    return true;
  }

  Future<void> _refreshData() async {
    // Giả định rằng bạn sẽ làm thao tác làm mới dữ liệu ở đây.
    await Future.delayed(Duration(seconds: 0));
    setState(() async {
      //await loaddataMissionUnFinish(TextValues);
    });
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
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
                color: Color(0xFFF5F5F5),
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return  Column(
                        children: [
                          Container(
                            color: Colors.white,
                            height: 100,
                            width: double.infinity,
                            child: Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                                child:Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFF5E4),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(dropdownTexts[TextValues]!,style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Roboto",
                                                color: Color(0xFFED801C)
                                            ),),
                                            PopupMenuButton<String>(
                                              icon: Icon(Icons.arrow_drop_down_sharp, color: Color(0xFFED801C), size:30),
                                              onSelected: (String result) {
                                                // Xử lý khi một mục được chọn từ menu
                                                setState(() {
                                                  TextValues=result;
                                                  loaddataMissionUnFinish(TextValues);
                                                });

                                              },
                                              itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry<String>>[
                                                const PopupMenuItem<String>(
                                                  value: '01',
                                                  child: Text('Loại Việc'),
                                                ),
                                                const PopupMenuItem<String>(
                                                  value: '04',
                                                  child: Text('Loại phần mềm'),
                                                ),
                                                const PopupMenuItem<String>(
                                                  value: '05',
                                                  child: Text('Dự án bảo trì'),
                                                ),
                                                const PopupMenuItem<String>(
                                                  value: '03',
                                                  child: Text('Người giao'),
                                                ),
                                                const PopupMenuItem<String>(
                                                  value: '02',
                                                  child: Text('Người nhận'),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 20),
                                child: Text("Thống kê nhiệm vụ",style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,color: Colors.black
                                ),),)
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Container(
                            width: double.infinity,
                            color: Color(0xFFFFF5E4),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 75,
                                    child: Center(
                                      child: Text("Diễn giải",style: TextStyle(fontFamily: "Roboto",fontSize: 13,color: Colors.black),),
                                    ),
                                  ),
                                  Expanded(child:  Container(
                                    width: 65,
                                    child: Center(
                                      child: Text("Giao việc",style: TextStyle(fontFamily: "Roboto",fontSize: 13,color: Colors.black),),
                                    ),
                                  )),
                                  Expanded(child: Container(
                                    width: 65,
                                    child: Center(
                                      child: Text("Nhận việc",style: TextStyle(fontFamily: "Roboto",fontSize: 13,color: Colors.black),),
                                    ),
                                  )),
                                  Expanded(child: Container(
                                    width: 65,
                                    child: Center(
                                      child: Text("Xử lý",style: TextStyle(fontFamily: "Roboto",fontSize: 13,color: Colors.black),),
                                    ),
                                  )),
                                  Expanded(child: Container(
                                    width: 60,
                                    child: Center(
                                      child: Text("Chưa xử lý",style: TextStyle(fontFamily: "Roboto",fontSize: 13,color: Colors.black),),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          // Detail
                          Column(
                            children: [
                              if(listdata == null)
                                Text("Loading...")
                              else
                                Column(
                                  children: listdata!
                                      .map((item) => ListDataMissionAsignTotalViewModel(
                                    data: item,TypeRID: TextValues,
                                  ))
                                      .toList(),
                                )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    }),
              );
            }
          }),
      onRefresh: _refreshData,
    );
  }
}
