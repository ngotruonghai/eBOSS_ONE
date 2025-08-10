import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Login/LoginLayout.dart';

class Error404View extends StatelessWidget {
  const Error404View({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Color(0xFFFFC38C),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child:  Image(
              image: AssetImage("assets/Icon_Illustration.png"),
              width: 220,
              height: 200,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text("Page not found!", style: TextStyle(fontFamily: "Roboto",fontSize: 30,color: Color(0xFF1C2D57),fontWeight: FontWeight.bold),),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text("Có gì đó không đúng!",
                style: TextStyle(fontFamily: "Roboto",fontSize: 15,color: Color(0xFF666666))),
          ),
          Center(
            child: Text("Vui lòng thử lại hoặc quay về trang chủ",
                style: TextStyle(fontFamily: "Roboto",fontSize: 15,color: Color(0xFF666666))),
          ),
          SizedBox(
            height: 150,
          ),
          Center(
            child: InkWell(
              onTap: () async {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Login(StatusApp: 1,)));
              },
              child: Text("Back To Home", style: TextStyle(fontFamily: "Roboto",fontSize: 20,color: Color(0xFF1C2D57),fontWeight: FontWeight.bold),),
            )
          ),
        ],
      ),
    );
  }
}

class Error404_StatusAPI_View extends StatelessWidget {
  const Error404_StatusAPI_View({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Color(0xFFFFC38C),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child:  Image(
              image: AssetImage("assets/Icon_Illustration.png"),
              width: 220,
              height: 200,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text("Page not found!", style: TextStyle(fontFamily: "Roboto",fontSize: 30,color: Color(0xFF1C2D57),fontWeight: FontWeight.bold),),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text("THÔNG BÁO!",
                style: TextStyle(fontFamily: "Roboto",fontSize: 20,color: Color(0xFF666666),fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text("Máy chủ đang bảo trì, vui lòng quay lại sau!",
                style: TextStyle(fontFamily: "Roboto",fontSize: 15,color: Color(0xFF666666))),
          ),
          SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }
}