import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../View/Task/TaskDetailChillView.dart';
import '../../Model/MissionUnFinish/DataMissionUnFinishModel.dart';

class ListTask extends StatelessWidget {
  ListTask({super.key, required this.data});

  Data data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xFFb8e994)),
                    child: Icon(Icons.bookmark_added_outlined,
                        size: 30, color: Color(0xFF009432)),
                  ),
                  Text(
                    data.workID.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TaskDetailView( workAID: data.workAID.toString())),
                      );
                    },
                    child: Icon(
                      Icons.my_library_books,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Thông tin: ",
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                  Expanded(
                    child: Text(data.workAllSummary.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 13, fontFamily: "Roboto")),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Người ghi: ",
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                  Expanded(
                    child: Text(data.handlerName.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 13, fontFamily: "Roboto")),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Người giao: ",
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                  Expanded(
                    child: Text(data.navigatorName.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 13, fontFamily: "Roboto")),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Người nhận: ",
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                  Expanded(
                    child: Text(data.receiverName.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 13, fontFamily: "Roboto")),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Chi tiết: ",
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                  Expanded(
                    child: Text(
                        data.workAllSummary.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 13, fontFamily: "Roboto")),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Ngày tạo: ",
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                  Expanded(
                    child: Text(data.recordDate.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}