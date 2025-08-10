import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/MissionUnFinish/DataMissionAssignModel.dart';
import '../../View/Task/TaskDetailChillView.dart';

class TodayMissionViewModel extends StatelessWidget {
  TodayMissionViewModel({super.key, required this.data});
  Data data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: 230,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TaskDetailView( workAID: data.workAID.toString())),
                          );
                        },
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              width: 230,
                              child: Text(data.workAllSummary!.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "Roboto",
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            )),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Text(
                            data.projectName!.toString(),
                            style: TextStyle(fontFamily: "Roboto", fontSize: 13),
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Container(
                            width: 230,
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1.0,
                              indent: 0,
                              endIndent: 0,
                              height: 5,
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Container(
                          width: 230,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (data.isAttachFile == false)
                                    Text("")
                                  else
                                    Icon(
                                      Icons.attach_file,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  if (data.piorityID == "0")
                                    Text("")
                                  else if (data.piorityID == "1")
                                    Icon(
                                      Icons.bookmark,
                                      color: Colors.green,
                                      size: 20,
                                    )
                                  else if (data.piorityID == "2")
                                      Icon(
                                        Icons.bookmark,
                                        color: Colors.yellow,
                                        size: 20,
                                      )
                                    else if (data.piorityID == "3")
                                        Icon(
                                          Icons.bookmark,
                                          color: Colors.red,
                                          size: 20,
                                        )
                                      else
                                        Text(""),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.deepOrangeAccent,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Padding(
                                      padding:
                                      EdgeInsets.only(left: 10, right: 10,top: 5,bottom:5),
                                      child: Text(
                                        data.assignStatusName!.toString(),
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
        elevation: 1.0,
      ),
    );
  }
}
