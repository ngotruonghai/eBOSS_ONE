import 'dart:async';
import 'package:flutter/material.dart';

class Homeclockview extends StatefulWidget {
  const Homeclockview({super.key});

  @override
  _HomeclockviewState createState() => _HomeclockviewState();
}

class _HomeclockviewState extends State<Homeclockview> {
  late String _currentTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = _formattedTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _formattedTime();
      });
    });
  }

  // String _formattedTime() {
  //   final now = DateTime.now();
  //   return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  // }

  String _formattedTime() {
  final now = DateTime.now().toUtc().add(Duration(hours: 7)); // Giờ Việt Nam (UTC+7)
  return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
}


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentTime,
      style: TextStyle(
        fontSize: 25,
        color: Colors.orangeAccent,
        fontWeight: FontWeight.bold,
        fontFamily: "Roboto",
      ),
    );
  }
}
