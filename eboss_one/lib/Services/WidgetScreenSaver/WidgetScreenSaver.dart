import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingOverlay {
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false, // Không cho phép người dùng bấm ra ngoài để tắt màn hình chờ
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false, // Ngăn việc bấm nút back trên thiết bị
          child: Center(
            child: Stack(
              children: [
                Container(
                  color: Colors.black.withOpacity(0.5), // Điều chỉnh độ trong suốt ở đây
                  child: SpinKitFadingCube(
                    color: Colors.white, // Màu của biểu tượng loading
                    size: 50.0, // Kích thước của biểu tượng loading
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
