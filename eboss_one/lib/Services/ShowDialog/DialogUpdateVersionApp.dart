import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogUpdateVersionApp {
  static Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Set border radius here
            side: BorderSide(
              color: Colors.white, // Set border color here
              width: 2.0, // Set border width here
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Thông báo",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Image(
                image: AssetImage("assets/lego_eboss.png"),
                width: 30,
                height: 30,
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Đã có phiên bản mới, bạn có muốn cập nhật không?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: "Roboto")),
                //Text('Vui lòng kiểm tra lại hoặc liên hệ với nhân sự!.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cập nhật'),
              onPressed: () async {
                final url =
                    'https://play.google.com/store/apps/details?id=com.eBOSS_ONE.KuangJaanSoft&hl=vi';
                await launch(url);
              },
            ),
            TextButton(
              child: Text('Để sau'),
              onPressed: () {
                Navigator.of(context).pop(); // close the dialog
              },
            )
          ],
        );
      },
    );
  }
}
