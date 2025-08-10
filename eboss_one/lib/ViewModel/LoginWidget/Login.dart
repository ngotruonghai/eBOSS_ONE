import 'package:eboss_one/Services/NetWork/NetWorkSystem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/Login/LoginResponseModel.dart';
import '../../Model/Login/CreateTokenDBModel.dart' as CreateTokenModel;
import '../../Model/Login/RefestTokenModel.dart';
import '../../Services/BaseServices/MobileVersion.dart';
import '../../Services/BaseServices/SharedPreferencesService.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import '../../Services/ShowDialog/DialogMessage_Error.dart';
import '../../Services/ShowDialog/SnackbarError.dart';
import '../../Services/WidgetScreenSaver/WidgetScreenSaver.dart';
import '../../View/Home/HomeView.dart';
// import 'package:device_info/device_info.dart';

class MailLogin extends StatefulWidget {
  MailLogin({super.key, required this.StatusApp});
  int StatusApp;
  @override
  State<MailLogin> createState() => _MailLoginState();
}

class _MailLoginState extends State<MailLogin> {
  TextEditingController txtUser = TextEditingController();
  TextEditingController txtPassWord = TextEditingController();
  int check = 0;
  String? logError = "";
  List<CreateTokenModel.Data>? listdata_CreateToken = null;
  String _imei = 'Unknown';
  bool _IsShowPassword = true;

  Future<void> CreateTokenBD(
    String UserID,
    String EmployeeAID,
    String Token,
    String RefestToken,
  ) async {
    NetWorkSystem.getIpAddress().then((ip) async {
      await _getImei();
      Map<String, dynamic> request = {
        'userID': UserID,
        'employeeAID': EmployeeAID,
        'token': Token,
        'refestToken': RefestToken,
        'mobileCode': _imei,
        'type': '1',
        'statusApp': '1',
        'ip': ip
      };
      final responses = await NetWorkRequest.PostJWT(
          "/eBOSS/api/Login/CreateTokenDB", request);
      final MissionAssign =
          await CreateTokenModel.CreateTokenDBModel.fromJson(responses);
      listdata_CreateToken = MissionAssign.data;
    }).catchError((error) {
      print("Lỗi CreateTokenDB:" + error);
    });
  }

  @override
  Future<void> _getImei() async {
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // if (Theme.of(context).platform == TargetPlatform.android) {
    //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //   setState(() {
    //     _imei = ""; // or androidInfo.imei;
    //   });
    // } else if (Theme.of(context).platform == TargetPlatform.iOS) {
    //   // For iOS, there is no IMEI. You may use other identifiers like IDFA.
    //   setState(() {
    //     _imei = 'N/A';
    //   });
    // }
  }

  void initState() {
    super.initState();

    // Sử dụng SchedulerBinding để thực thi hàm sau khi widget đã được hiển thị.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Hàm này sẽ được gọi sau khi widget đã được hiển thị.
      try {
        await _getImei();
        if (prefs.containsKey('Token') == false) {
          LoadingOverlay.show(context);
          LoadingOverlay.hide(context);
        } else if (widget.StatusApp == 0) {
          LoadingOverlay.show(context);
          txtUser.text = prefs.getString(KeyServices.KeyUserID).toString();
          txtPassWord.text =
              prefs.getString(KeyServices.keyPassWord).toString();

          await NetWorkSystem.getIpAddress().then((ip) async {
            // Start auto connect Token
            Map<String, dynamic> request_RefestToken = {
              "token": prefs.getString(KeyServices.KeyToken).toString(),
              "refestToken":
                  prefs.getString(KeyServices.keyRefestToken).toString(),
              "mobileCode": _imei,
              "ip": ip
            };
            final response = await NetWorkRequest.post(
                "/eBOSS/api/Login/RefestToken", request_RefestToken);
            final listData_RefestToken = RefestTokenModel.fromJson(response);
            print(listData_RefestToken.data?.token);
            if (listData_RefestToken.data?.token == null) {
              LoadingOverlay.hide(context);
              prefs.clear();
              txtPassWord.text="";
              txtUser.text="";
              return;
            } else {
              prefs.setString(KeyServices.KeyToken,
                  listData_RefestToken.data!.token.toString());
              prefs.setString(KeyServices.keyRefestToken,
                  listData_RefestToken.data!.refestToken.toString());
              prefs.setString(KeyServices.KeyEmployeeAID,
                  listData_RefestToken.data!.employeeAID.toString());
            }
            // End auto connect Token
            await Future.delayed(Duration(seconds: 0));
            LoadingOverlay.hide(context);

            await Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeView()));
          }).catchError((error) {
            LoadingOverlay.hide(context);
            return;
          });


        } else {
          txtUser.text = prefs.getString(KeyServices.KeyUserID).toString();
          txtPassWord.text =
              prefs.getString(KeyServices.keyPassWord).toString();
        }
      } catch (e) {
        LoadingOverlay.hide(context);
        await DialogMessage_Error.showMyDialog(context, "Lỗi kết nối máy chủ!");
      }
    });
  }

  void _LoginUser(BuildContext context) async {
    LoadingOverlay.show(context);
    try {
      int check = 1;
      FocusScope.of(context).unfocus();
      logError = "";
      if (txtUser.text.isEmpty || txtPassWord.text.isEmpty) {
        SnackbarError.showSnackbar_Waiting(context, message: "Vui lòng điền đầy đủ thông tin!");
      } else {
        Map<String, dynamic> request = {
          "userName": txtUser.text,
          "password": txtPassWord.text
        };
        final response =
            await NetWorkRequest.post("/eBOSS/api/Login/LoginUser", request);
        final listData = LoginResponseModel.fromJson(response);

        // Kiểm tra đăng nhập thành công không?
        if (listData.data?.token != null) {
          check = 1;
        } else {
          check = 0;
          SnackbarError.showSnackbar_Error(context, message: "Sai tài khoản hoặc mật khẩu");
        }

        if (check == 1) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          SharedPreferencesService.setString(
              KeyServices.KeyToken, listData.data!.token.toString());
          SharedPreferencesService.setString(KeyServices.keyRefestToken,
              listData.data!.refestToken.toString());
          SharedPreferencesService.setString(KeyServices.KeyEmployeeAID,
              listData.data!.employeeAID.toString());

          SharedPreferencesService.setString(
              KeyServices.KeyUserName, listData.data!.userName.toString());
          SharedPreferencesService.setString(
              KeyServices.KeyUserID, listData.data!.userID.toString());
          SharedPreferencesService.setString(
              KeyServices.keyPassWord, txtPassWord.text.toString());

          // Tạo Token trong DB
          await CreateTokenBD(
              prefs.getString(KeyServices.KeyUserID).toString(),
              prefs.getString(KeyServices.KeyEmployeeAID).toString(),
              prefs.getString(KeyServices.KeyToken).toString(),
              prefs.getString(KeyServices.keyRefestToken).toString());

          await Future.delayed(Duration(seconds: 1));
          LoadingOverlay.hide(context);
          await Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeView()));
        }
      }
    } catch (e) {
      SnackbarError.showSnackbar_Error(context, message: "Lỗi kết nối máy chủ");
    } finally {
      LoadingOverlay.hide(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Image(
                      image: AssetImage("assets/lego_eboss.png"),
                      width: 100,
                      height: 100,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: txtUser,
                    decoration: InputDecoration(
                      hintText: "Tài khoản",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      fillColor: Colors.deepOrangeAccent.withOpacity(0.1),
                      filled: true,
                      prefixIcon: Icon(Icons.person, color: Colors.deepOrangeAccent),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: txtPassWord,
                    obscureText: _IsShowPassword,
                    decoration: InputDecoration(
                      hintText: "Mật khẩu",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      fillColor: Colors.deepOrangeAccent.withOpacity(0.1),
                      filled: true,
                      prefixIcon: Icon(Icons.lock, color: Colors.deepOrangeAccent),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _IsShowPassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.deepOrangeAccent,
                        ),
                        onPressed: () {
                          setState(() {
                            _IsShowPassword = !_IsShowPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _LoginUser(context),
                        child: Text(
                          "Đăng nhập",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.withOpacity(0.7),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Được phát triển bản quyền bởi eBOSS",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Version ${MobileVersion.VersionApp}",
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
