import 'package:flutter/material.dart';

class SnackbarError {
  static void showSnackbar_Error(BuildContext context,
      {required String message,
      Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.cancel_outlined, color: Colors.white), // Icon tùy chỉnh
            SizedBox(width: 10),
            Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(205, 51, 51, 0.8),// Màu nền snackbar mặc định là xanh lá cây
        duration: duration ??
            Duration(seconds: 2), // Thời gian tồn tại mặc định là 2 giây
      ),
    );
  }

  static void showSnackbar_Waiting (BuildContext context,
      {required String message,
        Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.waving_hand, color: Colors.white), // Icon tùy chỉnh
            SizedBox(width: 10),
            Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(205, 133, 0, 0.8),// Màu nền snackbar mặc định là xanh lá cây
        duration: duration ??
            Duration(seconds: 2), // Thời gian tồn tại mặc định là 2 giây
      ),
    );
  }

  static void showSnackbar_Succes (BuildContext context,
      {required String message,
        Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white), // Icon tùy chỉnh
            SizedBox(width: 10),
            Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(0, 139, 0, 0.8),// Màu nền snackbar mặc định là xanh lá cây
        duration: duration ??
            Duration(seconds: 2), // Thời gian tồn tại mặc định là 2 giây
      ),
    );
  }
}
