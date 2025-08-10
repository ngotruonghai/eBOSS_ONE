import 'dart:convert';
import 'dart:developer';

import 'package:eboss_one/View/PersonnelAbsent/PersonnelAbsentCreateView.dart';
import 'package:flutter/material.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import '../../Model/PersonnelAbsent/PersonnelAbsentDateModel.dart';
import 'package:intl/intl.dart';
import 'PersonnelAbsent_EditAbsentDate_View.dart';
import 'package:http/http.dart' as http;

class PersonnelabsentChitietnghiphepView extends StatefulWidget {
  final String absentAID;
  final String absentID;
  final String nameVietnamese;
  final String statusID;
  final String listOfAbsentType;
  final String absentHour;
  final String contractNameVietnamese;
  final String nguoiPheDuyet1;
  final String nguoiPheDuyet2;
  final String absentStartTime;
  final String absentEndTime;
  final String recordDate;
  final String descriptionAbsent;
  final String remark;
  

  const PersonnelabsentChitietnghiphepView({
    super.key,
    required this.absentAID,
    required this.absentID,
    required this.nameVietnamese,
    required this.statusID,
    required this.listOfAbsentType,
    required this.absentHour,
    required this.contractNameVietnamese,
    required this.nguoiPheDuyet1,
    required this.nguoiPheDuyet2,
    required this.absentStartTime,
    required this.absentEndTime,
    required this.recordDate,
    required this.descriptionAbsent,
    required this.remark,
  });

  @override
  State<PersonnelabsentChitietnghiphepView> createState() =>
      _PersonnelabsentChitietnghiphepView();
}

class _PersonnelabsentChitietnghiphepView
    extends State<PersonnelabsentChitietnghiphepView> {
  List<Data> listdata = [];
  final dateFormatter = DateFormat('dd/MM/yyyy');
  final timeFormatter = DateFormat('HH:mm');

  @override
  void initState() {
    super.initState();
    loadAbsentDateData(widget.absentAID);
  }

  Future<void> loadAbsentDateData(String absentAID) async {
    final response = await NetWorkRequest.PostJWT(
      "/eBOSS/api/PersonnelAbsent/GetPersonnelAbsentDate",
      {
        "absentAID": absentAID,
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
    print("AID: $absentAID");
    print("API Data: $response");
  }

  Future<void> deleteVoucherAbsent(String absentAID) async {
    final response = await NetWorkRequest.PostJWT(
      "/eBOSS/api/PersonnelAbsent/DeleteVoucherPersonnelAbsent",
      {
        "absentAID": absentAID,
      },
    );

    if (response != null && response["description"] == "Success") {
      print("Xóa phiếu nghỉ phép thành công: $absentAID");
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
        title: Text('Chi tiết đơn phép'),
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
                    content: Text("Bạn có chắc chắn muốn xóa phiếu nghỉ phép này không?"),
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
                await deleteVoucherAbsent(widget.absentAID);

                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Đã xóa thành công"),
                      content: Text("Phiếu nghỉ phép đã được xóa."),
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
              buildRow('Số phiếu', '${widget.absentID}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Ngày ghi nhận', '${widget.recordDate}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Tên nhân viên', '${widget.contractNameVietnamese}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Giờ bắt đầu', '${widget.absentStartTime}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Giờ kết thúc', '${widget.absentEndTime}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Thời gian nghỉ phép', '${widget.absentHour}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Danh sách loại phép', '${widget.listOfAbsentType}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Lý do nghỉ phép', '${widget.descriptionAbsent}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Trạng thái nghỉ phép', '${widget.statusID}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),
              buildRow('Ghi chú', '${widget.remark}'),
              Divider(height: 1, thickness: 0.8, color: Color(0xFFDDDDDD)),

              const SizedBox(height: 20),

              Text('Ngày nghỉ phép:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

              const SizedBox(height: 8),

              Table(
                border: TableBorder.all(color: Colors.grey),
                columnWidths: isPortrait ? const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                  3: FixedColumnWidth(70),
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
                      tableCellText('Loại phép', isHeader: true),
                      tableCellText('Ngày nghỉ phép', isHeader: true),
                      tableCellText('Thời gian', isHeader: true),
                      tableCellText('Số giờ', isHeader: true),
                      tableCellText('', isHeader: true),
                    ],
                  ),
                  for (var item in listdata)
                    TableRow(children: [
                      tableCellText(item.absentTypeName.toString()),
                      tableCellText(item.absentDate.toString()),
                      tableCellText(isPortrait
                                      ? '${item.absentStartTime}\n${item.absentEndTime}'
                                      : '${item.absentStartTime} - ${item.absentEndTime}',
                                    ),
                      tableCellText(item.absentHour.toString()),
                      Center(
                          child: GestureDetector(
                            onTap: () {                          
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PersonnelAbsentEditView(
                                    dateItemAID: item.dateItemAID.toString(),
                                    absentAID: item.absentAID.toString(),
                                    absentTypeID: item.absentTypeID.toString(),
                                    absentTypeName: item.absentTypeName.toString(),
                                    absentDate: item.absentDate.toString(),
                                    absentStartTime: item.absentStartTime.toString(),
                                    absentEndTime: item.absentEndTime.toString(),
                                    absentHour: item.absentHour.toString()
                                  ),
                                ),
                              );
                              print("Edit AbsentDate ${item.absentTypeName.toString()}");
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

