import 'package:flutter/material.dart';
import '../../ViewModel/LoginWidget/Login.dart';
import '../Error/Error404View.dart';

class Login extends StatelessWidget {
  Login({
    super.key,required this.StatusApp
  });
  int StatusApp;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: MailLogin(StatusApp: StatusApp),
        ));
  }
}
