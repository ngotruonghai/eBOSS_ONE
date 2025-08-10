import 'package:eboss_one/Services/BaseServices/SharedPreferencesService.dart';
import 'package:eboss_one/Services/NetWork/NetWorkRequest.dart';
import 'package:flutter/material.dart';
import '../../Provider/TimeKeepingProvider.dart';
import '../View/Home/HomeClockView.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class Timekeeping extends StatelessWidget {
  const Timekeeping({super.key});

  // Kiểm tra IP mạng hiện tại
  Future<String> _getCurrentIPAddress() async {
  try {
    List<NetworkInterface> interfaces = await NetworkInterface.list(
      type: InternetAddressType.IPv4,
      includeLoopback: false,
    );

    for (var interface in interfaces) {
      for (var addr in interface.addresses) {
        return addr.address; // Trả về IP đầu tiên tìm được
      }
    }
  } catch (e) {
    print("Lỗi lấy IP: $e");
  }
  return "";
}

  // Kiểm tra mạng nội bộ cty
  Future<bool> CheckNetwork1() async {
    try {
      List<NetworkInterface> interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
        includeLoopback: false,
      );

      for (var interface in interfaces) {
        for (var addr in interface.addresses) {
          final ip = addr.address;
          print("IP hiện tại: $ip");
          //10.0.2.15 dev emulator
          if (ip == "192.168.144.254" || ip == "192.168.144.0" || ip == "192.168.155.0" 
              || ip == "192.168.88.254" || ip == "10.0.2.15" || ip == "192.168.88.122") {
            return true;
          }
        }
      }
    } catch (e) {
      print("Lỗi khi kiểm tra mạng: $e");
    }
    return false;
  }

  Future<void> CreateTimeKeepingData() async {
    final response = await NetWorkRequest.PostJWT(
        "/eBOSS/api/TimeKeeping/CreateTimeKeepingData",
      {
        "EmployeeAID": SharedPreferencesService.getString(KeyServices.KeyEmployeeAID),
        "IPAdress": await _getCurrentIPAddress(),
      },);
  }

  Future<bool> CheckNetwork() async {
    try {
      final ip = await _getCurrentIPAddress();
      final response = await NetWorkRequest.PostJWT(
        "/eBOSS/api/TimeKeeping/CheckIP",
        {
          "IPAddress": ip,
        },
      );

      if (response['statusCode'] == 200) {
        final ipData = response['data'];
        if (ipData is List && ipData.isNotEmpty && ipData[0] is Map) {
          final ipAddress = ipData[0]['ipAddress'];
          print("IP: $ip");

          if (ipAddress is bool) {
            return ipAddress;
          } else if (ipAddress is String) {
            return ipAddress.toLowerCase() == "true";
          } else {
            return false;
          }
        }
      }
    } catch (e) {
      print("Lỗi: $e");
    }

    return false;
  }



  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimekeepingProvider>(context);

    final originalClockIn = provider.listdata_AbsentYearFollow?.isNotEmpty == true
        ? provider.listdata_AbsentYearFollow![0].originalClockIn
        : null;

    final originalClockOut = provider.listdata_AbsentYearFollow?.isNotEmpty == true
        ? provider.listdata_AbsentYearFollow![0].originalClockOut
        : null;

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildClockContainer("Giờ vào", originalClockIn),
              const SizedBox(width: 20),
              _buildClockContainer("Giờ ra", originalClockOut),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 80,
                  decoration: _boxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () async {
                        bool IPAddress = await CheckNetwork();
                        print("Check: $IPAddress");
                        if (IPAddress) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Xác nhận"),
                              content: const Text("Bạn có muốn chấm công vào thời điểm hiện tại?"),
                              actions: [
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () async {
                                    Navigator.of(context).pop();

                                    BuildContext? dialogContext;

                                    // Hiện dialog loading
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        dialogContext = context;
                                        return const AlertDialog(
                                          content: Row(
                                            children: [
                                              CircularProgressIndicator(),
                                              SizedBox(width: 20),
                                              Text("Đang tạo thông tin chấm công..."),
                                            ],
                                          ),
                                        );
                                      },
                                    );

                                    // Chờ API & delay
                                    await Future.wait([
                                      Future.delayed(const Duration(seconds: 3)),
                                      CreateTimeKeepingData(),
                                      provider.updateAfterCheckIn(),
                                    ]);

                                    if (dialogContext != null && Navigator.canPop(dialogContext!)) {
                                      Navigator.of(dialogContext!).pop();
                                    }

                                    provider.setCheckIn(true);
                                  },
                                ),
                                TextButton(
                                  child: const Text("Hủy"),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          );
                        } else {
                          print("❌ IP không hợp lệ – chặn chấm công");
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("⚠️ Cảnh báo"),
                              content: const Text("Bạn đang không ở phạm vi cho phép, không được phép chấm công."),
                              actions: [
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          provider.isCheckIn ? "Chấm ra" : "Chấm vào",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClockContainer(String label, String? value) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: _boxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: (value != null && value != "null")
                    ? Text(
                        value,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto",
                        ),
                      )
                    : const Homeclockview(), // phải import hoặc tạo widget này
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: const Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 1.0,
        ),
      ],
    );
  }
}
