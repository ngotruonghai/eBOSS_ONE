import 'package:eboss_one/View/Login/LoginLayout.dart';
import 'package:flutter/material.dart';
import 'Services/BaseServices/SharedPreferencesService.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class eBOSS_One extends StatelessWidget {
  const eBOSS_One({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  HomeWidget({
    super.key,
  });
  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2000,
      splash: Column(
        children: [
          Image.asset(
            "assets/lego_eboss.png",
            height: 170,
            width: 170,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "eBOSS ONE",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    "VÌ DOANH NGHIỆP BẠN SÁNG TẠO",
                    style: TextStyle(
                        fontSize: 13, color: Colors.grey, fontFamily: 'Roboto'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      nextScreen: CheckLoginToken(),
      splashIconSize: 250,
      //splashTransition: SplashTransition.rotationTransition,
    );
  }
}

class CheckLoginToken extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<bool>(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            // Người dùng đã đăng nhập, chuyển đến màn hình chính
            return Login(StatusApp: 0);
          } else {
            // Người dùng chưa đăng nhập, chuyển đến màn hình đăng nhập
            return Login(StatusApp: 0,);
          }
        },
      ),
    );
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Khởi chạy SharedPreferenc đầu tiên mới lấy được bộ nhớ
    await SharedPreferencesService.init();
    return prefs.containsKey('Token');
  }
}
