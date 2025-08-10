import 'package:flutter/material.dart';
import '../../Model/CompanyNoticeRecord/CompanyNoticeModel.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import '../../ViewModel/CompanyNotice/ListCompanyNoticeViewModel.dart';

class CompanyNoticeView extends StatefulWidget {
  @override
  State<CompanyNoticeView> createState() => _CompanyNoticeView();
}

class _CompanyNoticeView extends State<CompanyNoticeView> {

  List<Data>? listdata = null;

  Future<String> loaddataCompanyNotice() async {
    try {
      final responses = await NetWorkRequest.GetJWT(
          "/eBOSS/api/CompanyNoticeRecord/ListCompanyNotice_Top");
      final CompanyNotice = CompanyNoticeModel.fromJson(responses);
      listdata = CompanyNotice.data;
      return "";
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> loadData() async {
    try{
      await Future.delayed(Duration(seconds: 0));
      await loaddataCompanyNotice();// Giả lập thời gian tải
      return true;
    }catch(e){
      print("Đã bị lỗi"+ e.toString());
      NetWorkRequest.Error404(context);
      return false;
    }
  }

  // Load data refresh
  Future<void> _refreshData() async {
    // Giả định rằng bạn sẽ làm thao tác làm mới dữ liệu ở đây.
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      loaddataCompanyNotice();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return (Scaffold(
      appBar: AppBar(
        title: Text("Thông báo nội bộ"),
        backgroundColor: Color(0xFFe67e22),
        titleTextStyle: TextStyle(
          color: Colors.white, // Set the title color
          fontSize: 20,        // Optional: Set font size
        ),
      ),
      body: Center(
        child: RefreshIndicator(
            backgroundColor: Colors.white,
            child: FutureBuilder<bool>(
              future: loadData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: listdata!.map((e) => ListCompanyNoticeViewModel(screenWidth: screenWidth,data: e)).toList()
                        );
                      });
                }
              },
            ),
            onRefresh: _refreshData),
      ),
    ));
  }
}
