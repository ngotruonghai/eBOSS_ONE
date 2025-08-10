import 'dart:math';

import 'package:flutter/material.dart';
import '../../Model/PersonnelOverTime/PersonnelOverReqquestModel.dart';
class PersonnelOverDetail_PopupView extends StatelessWidget {
  PersonnelOverDetail_PopupView(
      {super.key,required this.listDetail,required this.RemoveDetail});

  late List<PersonnelOvertimeDetailModels> listDetail;
  final Function RemoveDetail;
  int _Index = -1;

  void _onClickAddTask(BuildContext context,int? RandomId){
    RemoveDetail(context,RandomId);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nội dung tăng ca"),
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
              children: listDetail.map((item) {
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
                            Text("Diễn giải:",style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.grey),),
                            Text(item.workDescription.toString(),style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.black),),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Giờ bắt đầu:",style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.grey),),
                            Text(item.startTime.toString(),style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.black),),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Giờ kết thúc:",style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.grey),),
                            Text(item.endtime.toString(),style: TextStyle(
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
                            Text("_",style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.black),),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 25,
                              child: InkWell(
                                onTap: (){
                                  _onClickAddTask(context,item.Random);
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
