import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/MissionUnFinish/DataMissionAssignLogModel.dart' as datalog;

class MissionAssignLogViewModel extends StatelessWidget {
   MissionAssignLogViewModel({
    super.key, required this.data
  });
   datalog.Data data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color:
          Colors.white, // Màu nền của container
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                  0.1), // Màu và độ trong suốt của đổ bóng
              spreadRadius: 1, // Bán kính của đổ bóng
              blurRadius: 1, // Độ mờ của đổ bóng
              offset:
              Offset(0, 3), // Vị trí của đổ bóng
            ),
          ],
        ),
        child: Padding(
            padding: EdgeInsets.only(
                top: 5, bottom: 5, left: 5),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 15, right: 15, top: 10),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                        data.description.toString(),
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: "Roboto",
                            color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Text("Tiến độ: " + (data.finishPercent.toString() == "null"? "0": data.finishPercent.toString()) +"%",
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: "Roboto",
                              color: Colors.black,
                              fontWeight:
                              FontWeight.bold)),
                      Text(data.startTime.toString(),
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: "Roboto",
                              color: Colors.black)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  thickness: 1, // Độ dày của đường kẻ
                  indent:
                  20, // Khoảng cách từ mép trái đến đường kẻ
                  endIndent:
                  20, // Khoảng cách từ mép phải đến đường kẻ
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Ghi chú:",
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: "Roboto",
                            color: Colors.black,
                            fontWeight:
                            FontWeight.bold)),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                        child: Text(
                          data.remark.toString(),
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: "Roboto",
                              color: Colors.black),
                          softWrap: true,
                          maxLines: 5,
                        ))
                  ],
                )
              ],
            )),
      ),
    );
  }
}