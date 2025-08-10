import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../View/Error/Error404View.dart';
import '../BaseServices/HostService.dart';
import '../BaseServices/SharedPreferencesService.dart';
import '../ShowDialog/DialogMessage_Error.dart';
import '../ShowDialog/SnackbarError.dart';

class NetWorkRequest {
  static final timeout = Duration(seconds: 100);
  NetWorkRequest() {}

  static Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> data) async {
    String url = HostService.Host_Mobile + endpoint;
    // Post API
    final response = await http
        .post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data),
        )
        .timeout(timeout);
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> PostJWT(
      String endpoint, Map<String, dynamic> data) async {
    String url = HostService.Host_Mobile + endpoint;
    // Post API
    final response = await http
        .post(
          Uri.parse(url),
          headers: {
            'eBOSSONE':
                SharedPreferencesService.getString(KeyServices.KeyToken),
            'eBOSSONE-API-LanguageID': 'VN',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data),
        )
        .timeout(timeout);
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> PostJWT_1(
      String endpoint, Map<String, dynamic> data, BuildContext context) async {
    String url = HostService.Host_Mobile + endpoint;
    // Post API
    final response = await http
        .post(
          Uri.parse(url),
          headers: {
            'eBOSSONE':
                SharedPreferencesService.getString(KeyServices.KeyToken),
            'eBOSSONE-API-LanguageID': 'VN',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data),
        )
        .timeout(timeout);
    return _handleResponseContext(response, context);
  }

  static Future<Map<String, dynamic>> GetJWT(String endpoint) async {
    String url = HostService.Host_Mobile + endpoint;
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'eBOSSONE': SharedPreferencesService.getString(KeyServices.KeyToken),
        'eBOSSONE-API-LanguageID': 'VN',
        'Content-Type': 'application/json',
      },
    ).timeout(timeout);
    return _handleResponse(response);
  }

  // static Future<Map<String, dynamic>> _handleResponseContext(
  //     http.Response response, BuildContext context) async {
  //   if (response.statusCode >= 200 && response.statusCode < 300) {
  //     // Trả về dữ liệu đã được giải mã từ JSON
  //     return json.decode(response.body);
  //   } else {
  //     // Xử lý lỗi và thông báo cho phía gọi
  //     if (response.statusCode == 500) {
  //       await DialogMessage_Error.showMyDialog(
  //           context, json.decode(response.body));
  //     } else {
  //       SnackbarError.showSnackbar_Error(context,
  //           message: json.decode(response.body));
  //     }
  //     throw Exception('${response.statusCode.toString()}');
  //   }
  // }

  static Future<Map<String, dynamic>> _handleResponseContext(
    http.Response response, BuildContext context) async {
  final decoded = json.decode(response.body);

  if (response.statusCode >= 200 && response.statusCode < 300) {
    if (decoded is Map<String, dynamic>) {
      return decoded;
    } else {
      throw Exception("Phản hồi không phải Map");
    }
  } else {
    String message = "Đã xảy ra lỗi";
    if (decoded is Map<String, dynamic> && decoded.containsKey("message")) {
      message = decoded["message"];
      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");
    }

    if (response.statusCode == 500) {
      await DialogMessage_Error.showMyDialog(context, message);
    } else {
      SnackbarError.showSnackbar_Error(context, message: message);
      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");
    }

    throw Exception('${response.statusCode.toString()}');
  }
}


  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Trả về dữ liệu đã được giải mã từ JSON
      return json.decode(response.body);
    } else {
      // Xử lý lỗi và thông báo cho phía gọi

      throw Exception('${response.statusCode.toString()}');
    }
  }

  static Future<void> Error404(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Error404View()));
  }
}
