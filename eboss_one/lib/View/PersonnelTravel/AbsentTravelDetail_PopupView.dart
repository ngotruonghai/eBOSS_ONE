import 'package:flutter/material.dart';

import '../../Model/PersonnelAbsent/PersonnelAbsentAttachFileModel.dart';
import '../../Model/PersonnelAbsent/PersonnelAbsentDetailsModel.dart';
import '../../Model/PersonnelAbsentTravel/DiaDiemCongTacModel.dart';
class AbsentTravelDetail_PopupView extends StatelessWidget {
  AbsentTravelDetail_PopupView(
      {super.key,required this.DSDiaDiemCongTac,required this.RemovePersonnelTravel});

  late List<DiaDiemCongTacModel> DSDiaDiemCongTac;
  final Function RemovePersonnelTravel;
  int _Index = -1;

  void _onClickRemoTask(BuildContext context,int id){
    RemovePersonnelTravel(id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin địa điểm công tác"),
        backgroundColor: Color(0xFFFED801C),
        titleTextStyle: TextStyle(
          color: Colors.white, // Set the title color
          fontSize: 20,        // Optional: Set font size
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child:SizedBox(
          height:MediaQuery.of(context).size.height - 100,
          child: SingleChildScrollView(
            child: Column(
              children: DSDiaDiemCongTac.map((item) {
                _Index = _Index + 1;
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Khu vực:",style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.grey),),
                            Text(item.TenKhuVuc,style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.black),),
                            SizedBox(
                              height: 10,
                            ),

                            Text("Diễn giải:",style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.grey),),
                            Text(item.DienGiai,style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.black),),
                            SizedBox(
                              height: 10,
                            ),

                            Text("Chi phí phát sinh:",style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.grey),),
                            Text(item.ChipPhiPhatSinh,style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.black),),
                            SizedBox(
                              height: 10,
                            ),

                            Text("Lý do phát sinh:",style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.grey),),
                            Text(item.LyDoPhatSinh,style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.black),),
                            SizedBox(
                              height: 10,
                            ),

                            Text("Ghi chú:",style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.grey),),
                            Text(item.GhiChu,style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.black),),
                            SizedBox(
                              height: 25,
                              child: InkWell(
                                onTap: (){
                                  _onClickRemoTask(context,item.Id);
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                    BorderRadius.circular(5.0),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Padding(padding: EdgeInsets.only(top: 2),
                                      child: Text("Xóa",style: TextStyle(fontFamily: "Roboto",
                                          fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}