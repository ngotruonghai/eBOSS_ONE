import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoCapacityView extends StatelessWidget {
  UserInfoCapacityView({super.key, required this.RankLevelDescription});

  String? RankLevelDescription;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFED801C),
        title: Text(
          "Năng lực bản thân",
          style: TextStyle(fontFamily: "Roboto"),
        ),
        titleTextStyle: TextStyle(
          color: Colors.white, // Set the title color
          fontSize: 20,        // Optional: Set font size
        ),
      ),
      body: SingleChildScrollView(
          child:Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: Column(
              children: [
                Center(
                  child: Text("Thông tin chi tiết",style: TextStyle(
                      fontSize: 20, fontFamily: "Roboto",color: Colors.grey,fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(RankLevelDescription.toString(),style: TextStyle(fontSize: 13, fontFamily: "Roboto"),)
              ],
            ),)
      ),
    );
  }
}