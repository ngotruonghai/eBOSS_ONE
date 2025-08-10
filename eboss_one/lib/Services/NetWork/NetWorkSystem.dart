import 'dart:io';

class NetWorkSystem {
  static Future<String> getIpAddress() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        // Kiểm tra xem địa chỉ IP có phải là IPv4 không và không phải là địa chỉ loopback
        if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
          return addr.address;
        }
      }
    }
    return 'Không tìm thấy địa chỉ IP';
  }
}
