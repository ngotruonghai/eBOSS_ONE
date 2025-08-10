import 'package:eboss_one/Provider/TimeKeepingProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'eBOSS.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // thêm dòng này cho an toàn
  await initializeDateFormatting('vi_VN', null);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimekeepingProvider()),
        // có thể thêm các provider khác nếu có
      ],
      child: eBOSS_One(), // hoặc MaterialApp nếu bạn không dùng eBOSS
    ),
  );
}
