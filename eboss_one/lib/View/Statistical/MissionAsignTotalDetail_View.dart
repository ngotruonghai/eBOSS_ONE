import 'package:flutter/material.dart';
import '../../Model/MissionUnFinish/DataMissionAsignTotalModel.dart';
import '../../Services/NetWork/NetWorkRequest.dart';

class MissionAsignTotalDetail_View extends StatefulWidget {
  MissionAsignTotalDetail_View(
      {super.key, required this.NameVietnamese, required this.TypeRID});
  final String NameVietnamese;
  final String TypeRID;
  @override
  State<MissionAsignTotalDetail_View> createState() =>
      _MissionAsignTotalDetail_View();
}

class _MissionAsignTotalDetail_View
    extends State<MissionAsignTotalDetail_View> {
  @override
  Widget build(BuildContext context) {
    List<Data>? listdata;
    Map<String, dynamic> request = {
      'typeRID': widget.TypeRID,
      'nameVietnamese': widget.NameVietnamese,
    };
    Future<int> loaddataMissionUnFinish() async {
      final responses = await NetWorkRequest.PostJWT(
          "/eBOSS/api/MissionUnFinish/DataMissionAsignTotal_Detail",request);
      final _listdata = DataMissionAsignTotalModel.fromJson(responses);
      listdata = _listdata.data;
      return 1;
    }

    Future<bool> loadData() async {
      try{
        await loaddataMissionUnFinish();
        return true;
      }catch(e){
        NetWorkRequest.Error404(context);
        return false;
      }
    }

    Future<void> _refreshData() async {
      // Giả định rằng bạn sẽ làm thao tác làm mới dữ liệu ở đây.
      await Future.delayed(Duration(seconds: 0));
      setState(() async {
        //await loaddataMissionUnFinish(TextValues);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Thống kê chi tiết"),
        backgroundColor: Color(0xFFe67e22),
        titleTextStyle: TextStyle(
          color: Colors.white, // Set the title color
          fontSize: 20,        // Optional: Set font size
        ),
      ),
      body: RefreshIndicator(
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
                  child: Container(
                    color: Color(0xFFF5F5F5),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: Text(widget.NameVietnamese,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: "Roboto")),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          color: Color(0xFFFFF5E4),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Diễn giải"),
                                Text("Số lượng phiếu")
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          children: [

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Chưa xử lý",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].chuaXuLy.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Color(0xFF669966),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Tổng",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyTotal.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Giả pháp",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtySolution.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Phân tích",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyAnalysis.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Phân tích",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyAnalysis.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Giao việc",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyAssign.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Nhận việc",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyReceive.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Xử lý",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyDeal.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Thảo luận",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyDiscuss.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Theo dõi",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyFollow.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("không xử lý",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyNotDeal.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.orangeAccent,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Làm lại",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyRedo.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Kiểm việc",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyChecked.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Đợi đồng bộ",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtySyncWait.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Đang đồng bộ",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtySyncing.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Đợi thông báo",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyNotification.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Đợi đóng việc",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyClosed.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("Khác thường",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyUnusual.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("> 1 ngày",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyOverOneDay.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("> 3 ngày",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyOverThreeDay.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("> 3 ngày",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyOverThreeDay.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("> 7 ngày",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyOverSevenDay.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("> 10 ngày",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyOverTenDay.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("> 15 ngày",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyOverFifteenDay.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("> 30 ngày",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyOverThirtyDay.toString()),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Text("> 60 ngày",style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Roboto',
                                          color: Colors.black),
                                      ),
                                    ),
                                    Text(listdata![0].qtyOverSixtiesDay.toString()),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
