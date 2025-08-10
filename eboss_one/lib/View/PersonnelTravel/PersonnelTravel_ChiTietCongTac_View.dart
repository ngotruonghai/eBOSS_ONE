import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import '../../Model/PersonnelAbsentTravel/PersonnelTravelDateModel.dart' as DateModel;
import '../../Model/PersonnelAbsentTravel/PersonnelTravelDetailsModel.dart' as DetailsModel;
import 'package:eboss_one/View/PersonnelAbsent/PersonnelAbsentCreateView.dart';
import 'PersonnelTravel_EditTravelDate_View.dart';
import 'PersonnelTravel_EditTravelDetails_View.dart';

class PersonneltravelChitietcongtacView extends StatefulWidget {
  final String travelAID;
  final String travelID;
  final String remark;
  final String travelKM;
  final String contractNameVietnamese;
  final String startTime;
  final String endTime;
  final String recordDate;
  final String nguoiPheDuyet1;
  final String nguoiPheDuyet2;
  final String absentStartTime;
  final String absentEndTime;
  final String description;
  final String statusID;
  

  const PersonneltravelChitietcongtacView({
    super.key,
    required this.travelAID,
    required this.travelID,
    required this.remark,
    required this.travelKM,
    required this.contractNameVietnamese,
    required this.startTime,
    required this.endTime,
    required this.recordDate,
    required this.nguoiPheDuyet1,
    required this.nguoiPheDuyet2,
    required this.absentStartTime,
    required this.absentEndTime,
    required this.description,
    required this.statusID,
  });

  @override
  State<PersonneltravelChitietcongtacView> createState() =>
      _PersonneltravelChitietcongtacView();
}

class _PersonneltravelChitietcongtacView
    extends State<PersonneltravelChitietcongtacView> {
  List<DateModel.Data> listDateData = [];
  List<DetailsModel.Data> listDetailsData = [];
  final dateFormatter = DateFormat('dd/MM/yyyy');
  final timeFormatter = DateFormat('HH:mm');

  @override
  void initState() {
    super.initState();
    loadTravelDateData(widget.travelAID);
    loadTravelDetailsData(widget.travelAID);
  }

  Future<void> loadTravelDateData(String travelAID) async {
    final response = await NetWorkRequest.PostJWT(
      "/eBOSS/api/PersonnelTravel/GetPersonnelTravelDate",
      {
        "travelAID": travelAID,
      },
    );

    if (response != null && response["data"] != null) {
      setState(() {
      listDateData = (response["data"] as List)
          .map((item) => DateModel.Data.fromJson(item))
          .toList();
      });
    } else {
      setState(() {
        listDateData = [];
      });
    }
  }

  Future<void> loadTravelDetailsData(String travelAID) async {
    final response = await NetWorkRequest.PostJWT(
      "/eBOSS/api/PersonnelTravel/GetPersonnelTravelDetails",
      {
        "travelAID": travelAID,
      },
    );

    if (response != null && response["data"] != null) {
      setState(() {
      listDetailsData = (response["data"] as List)
          .map((item) => DetailsModel.Data.fromJson(item))
          .toList();
      });
    } else {
      setState(() {
        listDetailsData = [];
      });
    }
  }

  Future<void> deleteVoucherTravel(String travelAID) async {
    final response = await NetWorkRequest.PostJWT(
      "/eBOSS/api/PersonnelTravel/DeleteVoucherPersonnelTravel",
      {
        "travelAID": travelAID,
      },
    );

    if (response != null && response["description"] == "Success") {
      print("Xóa phiếu công tác thành công: $travelAID");
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
        title: Text('Chi tiết đơn công tác'),
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
                    content: Text("Bạn có chắc chắn muốn xóa phiếu công tác này không?"),
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
                await deleteVoucherTravel(widget.travelAID);

                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Đã xóa thành công"),
                      content: Text("Phiếu công tác đã được xóa."),
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
              buildRow('Số phiếu', '${widget.travelID}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Ngày ghi nhận', '${widget.recordDate}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Tên nhân viên', '${widget.contractNameVietnamese}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),              
              buildRow('Phương tiện', '${widget.remark}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Giờ bắt đầu', '${widget.absentStartTime}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Giờ kết thúc', '${widget.absentEndTime}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('KM công tác', '${widget.travelKM}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Ghi chú', '${widget.remark}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),

              const SizedBox(height: 20),
              Text('Ngày công tác:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              Table(
                border: TableBorder.all(color: Colors.grey),
                columnWidths: isPortrait ? const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(70),
                  3: FixedColumnWidth(60),
                  4: FixedColumnWidth(40),
                }
                : const{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                  3: FlexColumnWidth(),
                  4: FixedColumnWidth(40),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    children: [
                      tableCellText('Ngày công tác', isHeader: true),
                      tableCellText('Thời gian', isHeader: true),
                      tableCellText('Giờ', isHeader: true),
                      tableCellText('Bù chấm công', isHeader: true),
                      tableCellText('', isHeader: true),
                    ],
                  ),
                  for (var item in listDateData)
                    TableRow(children: [
                      tableCellText(item.travelDate.toString()),
                      tableCellText(isPortrait
                                  ? '${item.travelStartTime}\n${item.travelEndTime}'
                                  : '${item.travelStartTime} - ${item.travelEndTime}',
                                ),
                      tableCellText(item.travelHour.toString()),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0, right: 5.0, left: 5.0),
                          child: Icon(
                            item.isAdditional == "True"
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {                          
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PersonneltravelEdittraveldateView(
                                  dateItemAID: item.dateItemAID.toString(),
                                  travelAID: item.travelAID.toString(),
                                  travelDate: item.travelDate.toString(),
                                  travelStartTime: item.travelStartTime.toString(),
                                  travelEndTime: item.travelEndTime.toString(),
                                  travelHour: item.travelHour.toString(),
                                  isAdditional: item.isAdditional.toString(),
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0, right: 5.0, left: 5.0),
                            child: Icon(Icons.remove_red_eye, color: Colors.blue),
                          ),
                        ),
                      ),
                    ]),
                ],
              ),

              const SizedBox(height: 20),
              Text('Địa điểm công tác:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              Table(
                border: TableBorder.all(color: Colors.grey),
                columnWidths: isPortrait ? const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(40),
                  3: FlexColumnWidth(),
                  // 4: FixedColumnWidth(70),
                  // 5: FixedColumnWidth(60),
                  4: FixedColumnWidth(40),
                }
                : const{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                  3: FlexColumnWidth(),
                  // 4: FlexColumnWidth(),
                  // 5: FlexColumnWidth(),
                  4: FixedColumnWidth(40),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    children: [
                      tableCellText('Khu vực', isHeader: true),
                      tableCellText('Loại việc', isHeader: true),
                      tableCellText('KM', isHeader: true),
                      tableCellText('Diễn giải', isHeader: true),
                      // tableCellText('Chi phí phát sinh', isHeader: true),
                      // tableCellText('Lý do phát sinh', isHeader: true),
                      tableCellText('', isHeader: true),
                    ],
                  ),
                  for (var item in listDetailsData)
                    TableRow(children: [
                      tableCellText(item.areaName.toString()),
                      tableCellText(item.travelTypeName.toString()),
                      tableCellText(item.kM.toString()),
                      tableCellText(item.description.toString()),
                      // tableCellText(item.outlayAmount.toString()),
                      // tableCellText(item.outlayReason.toString()),                      
                      Center(
                            child: GestureDetector(
                              onTap: () {                          
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PersonneltravelEdittraveldetailsView(
                                      aID: item.aID.toString(),
                                      travelAID: item.travelAID.toString(),
                                      areaID: item.areaID.toString(),
                                      areaName: item.areaName.toString(),
                                      kM: item.kM.toString(),
                                      typeID: item.typeID.toString(),
                                      travelTypeName: item.travelTypeName.toString(),
                                      description: item.description.toString(),
                                      outlayAmount: item.outlayAmount.toString(),
                                      outlayReason: item.outlayReason.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30.0, right: 5.0, left: 5.0),
                                child: Icon(Icons.remove_red_eye, color: Colors.blue),
                              ),
                            ),
                        ),
                    ]),
                ],
              ),
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

