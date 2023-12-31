import 'package:eboss_one/View/Login/LoginLayout.dart';
import 'package:flutter/material.dart';
import 'ViewModel/HomeWidget/Home.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

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
class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
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
                    "Vì doanh nghiệp mà sáng tạo",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontFamily: 'Roboto'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      nextScreen: Login(),
      duration: 1000,
      splashIconSize: 250,
      //splashTransition: SplashTransition.rotationTransition,
    );
  }
}
