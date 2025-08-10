import 'package:flutter/material.dart';

import '../../Model/PersonnelAbsent/PersonnelAbsentAttachFileModel.dart';
import '../../Model/PersonnelAbsent/PersonnelAbsentDetailsModel.dart';
class AbsentAttachFileDetail_PopupView extends StatelessWidget {
  AbsentAttachFileDetail_PopupView(
      {super.key,required this.ListAbsentAttachFile,required this.RemovePersonnelAbsentAttachFile});

  List<PersonnelAbsentAttachFile> ListAbsentAttachFile;
  final Function RemovePersonnelAbsentAttachFile;
  int _Index = -1;

  void _onClickAddTask(BuildContext context,int Index,String absentID){
    RemovePersonnelAbsentAttachFile(Index,absentID);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin đính kèm"),
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
              children: ListAbsentAttachFile.map((item) {
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
                            Text(item.description,style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.black),),
                            Text("Ghi chú:",style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                color: Colors.grey),),
                            Text(item.remark,style: TextStyle(
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
                                  _onClickAddTask(context,_Index,item.absentID.toString());
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