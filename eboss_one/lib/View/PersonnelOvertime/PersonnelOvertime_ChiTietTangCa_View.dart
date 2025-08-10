import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import '../../Model/PersonnelOverTime/PersonnelOvertimeDetailsModel.dart';
import 'PersonnelOvertime_EditDetails_View.dart';


class PersonnelovertimeChitiettangcaView extends StatefulWidget {
  final String overtimeAID;
  final String overtimeID;
  final String nameVietnamese;
  final String personnelType;
  final String contractNameVietnamese;
  final String overtimeDate;
  final String startTime;
  final String endTime;
  final String overTimeHour;
  final String recordDate;
  final String nguoiPheDuyet1;
  final String nguoiPheDuyet2;
  final String absentStartTime;
  final String absentEndTime;
  final String remark;
  final String statusID;
  

  const PersonnelovertimeChitiettangcaView({
    super.key,
    required this.overtimeAID,
    required this.overtimeID,
    required this.nameVietnamese,
    required this.personnelType,
    required this.contractNameVietnamese,
    required this.overtimeDate,
    required this.startTime,
    required this.endTime,
    required this.overTimeHour,
    required this.recordDate,
    required this.nguoiPheDuyet1,
    required this.nguoiPheDuyet2,
    required this.absentStartTime,
    required this.absentEndTime,  
    required this.remark,
    required this.statusID,
  });

  @override
  State<PersonnelovertimeChitiettangcaView> createState() =>
      _PersonnelovertimeChitiettangcaView();
}

class _PersonnelovertimeChitiettangcaView
    extends State<PersonnelovertimeChitiettangcaView> {
  List<Data> listdata = [];
  final dateFormatter = DateFormat('dd/MM/yyyy');
  final timeFormatter = DateFormat('HH:mm');

  @override
  void initState() {
    super.initState();
    loadOvertimeDateData(widget.overtimeAID);
  }

  Future<void> loadOvertimeDateData(String overtimeAID) async {
    final response = await NetWorkRequest.PostJWT(
      "/eBOSS/api/PersonnelOvertime/PersonnelOvertimeDetails",
      {
        "overtimeAID": overtimeAID,
      },
    );

    if (response != null && response["data"] != null) {
      setState(() {
      listdata = (response["data"] as List)
          .map((item) => Data.fromJson(item))
          .toList();
      });
    } else {
      setState(() {
        listdata = [];
      });
    }
  }

  Future<void> deleteVoucherOvertime(String overtimeAID) async {
    final response = await NetWorkRequest.PostJWT(
      "/eBOSS/api/PersonnelOvertime/DeleteVoucherPersonnelOvertime",
      {
        "overtimeAID": overtimeAID,
      },
    );

    if (response != null && response["description"] == "Success") {
      print("Xóa phiếu tăng ca thành công: $overtimeAID");
    } else {
      print("Xóa thất bại hoặc không hợp lệ. Thông báo: ${response?['description']}");
    }
  }


  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 0));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {    
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết tăng ca'),
        backgroundColor: Color(0xFFFED801C),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },),
        actions: [
          IconButton(
            onPressed: () async {
              final bool? confirm = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Xác nhận xóa"),
                    content: Text("Bạn có chắc chắn muốn xóa phiếu tăng ca này không?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text("Hủy"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text("Xóa", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  );
                },
              );

              if (confirm == true) {
                await deleteVoucherOvertime(widget.overtimeAID);

                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Đã xóa thành công"),
                      content: Text("Phiếu tăng ca đã được xóa."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                ).then((_) {
                  Navigator.of(context).pop(true);
                });
              }
            },
            icon: Icon(Icons.delete_forever, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRow('Số phiếu', '${widget.overtimeID}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Ngày ghi nhận', '${widget.recordDate}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Loại tăng ca', '${widget.personnelType}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Tên nhân viên', '${widget.contractNameVietnamese}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Ngày tăng ca', '${widget.overtimeDate}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Giờ bắt đầu', '${widget.startTime}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Giờ kết thúc', '${widget.endTime}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Số giờ tăng ca', '${widget.overTimeHour}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Ghi chú', '${widget.remark}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),

              const SizedBox(height: 20),
              Text('Nội dung tăng ca:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              Table(
                border: TableBorder.all(color: Colors.grey),
                columnWidths: isPortrait ? const {
                  0: FlexColumnWidth(),
                  1: FixedColumnWidth(70),
                  2: FixedColumnWidth(70),
                  3: FixedColumnWidth(40),
                }
                : const{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(70),
                  3: FixedColumnWidth(40),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    children: [
                      tableCellText('Diễn giải', isHeader: true),
                      tableCellText('Thời gian', isHeader: true),
                      tableCellText('Số giờ', isHeader: true),
                      tableCellText('', isHeader: true),
                    ],
                  ),
                  for (var item in listdata)
                    TableRow(children: [
                      tableCellText(item.workDescription.toString()),
                      tableCellText(isPortrait
                                      ? '${item.startTime}\n${item.endtime}'
                                      : '${item.startTime} - ${item.endtime}',
                                    ),
                      tableCellText(item.overTimeHour.toString()),
                      Center(
                          child: GestureDetector(
                            onTap: () {                          
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PersonnelovertimeEditdetailsView(
                                    overtimeItemAID: item.overtimeItemAID.toString(),
                                    overtimeAID: item.overtimeAID.toString(),
                                    workDescription: item.workDescription.toString(),
                                    startTime: item.startTime.toString(),
                                    endtime: item.endtime.toString(),
                                    overTimeHour: item.overTimeHour.toString(),
                                    remark: item.remark.toString(),
                                  ),
                                ),
                              );
                              print("AAA: ${item.overtimeItemAID}");
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0, right: 5.0, left: 5.0),
                              child: Icon(Icons.remove_red_eye, color: Colors.blue),
                            ),
                          ),
                      ),
                    ]),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}

Widget buildRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontFamily: "Roboto"),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 5,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: "Roboto"),
          ),
        ),
      ],
    ),
  );
}

Widget tableCellText(String text, {bool isHeader = false}) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(8.0),
    height: 80,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        fontFamily: "Roboto"
      ),
    ),
  );
}

