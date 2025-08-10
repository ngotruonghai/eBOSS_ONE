import 'package:eboss_one/Services/NetWork/NetWorkRequest.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonnelovertimeEditdetailsView extends StatefulWidget {
  final String overtimeItemAID;
  final String overtimeAID;
  final String workDescription;
  final String startTime;
  final String endtime;
  final String overTimeHour;
  final String remark;

  const PersonnelovertimeEditdetailsView({
    super.key,
    required this.overtimeItemAID,
    required this.overtimeAID,
    required this.workDescription,
    required this.startTime,
    required this.endtime,
    required this.overTimeHour,
    required this.remark,
  });

  @override
  State<PersonnelovertimeEditdetailsView> createState() =>
      _PersonnelovertimeEditdetailsView();
}

class _PersonnelovertimeEditdetailsView extends State<PersonnelovertimeEditdetailsView> {
  late TextEditingController _workDescriptionController;
  late TextEditingController _remarkController;

  @override
  void initState() {
    super.initState();
    _workDescriptionController = TextEditingController(text: widget.workDescription);
    _remarkController = TextEditingController(text: widget.remark);
  }

  @override
  void dispose() {
    _workDescriptionController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  Widget buildInputField(String label, Widget input) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        const SizedBox(height: 4),
        input,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildTextInput(TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 16),
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        border: UnderlineInputBorder(),
      ),
    );
  }

  Widget buildReadonlyTextField(String value) {
    return TextField(
      controller: TextEditingController(text: value),
      readOnly: true,
      enabled: false, // Làm cho TextField xám và không tương tác
      maxLines: null, // Cho phép hiển thị nhiều dòng
      minLines: 1,
      style: const TextStyle(fontSize: 16, color: Colors.black87),
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        border: UnderlineInputBorder(),
      ),
    );
  }


  Widget buildComboBoxField({
  required String label,
  required String value,
  required VoidCallback onTap,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      const SizedBox(height: 4),
      InkWell(
        onTap: onTap,
        child: InputDecorator(
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2), // underline đậm
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sửa nội dung tăng ca'),
        centerTitle: true,
        backgroundColor: Color(0xFFFED801C),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: "Roboto",
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context, 'refresh');
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.save_outlined, color: Colors.white),
        //     onPressed: () {
        //       // Xử lý lưu dữ liệu ở đây
        //       print("Loại nghỉ: ${_typeNameController.text}");
        //       print("Ngày nghỉ: ${_dateController.text}");
        //       print("Giờ bắt đầu: ${_startTimeController.text}");
        //       print("Giờ kết thúc: ${_endTimeController.text}");
        //       print("Tổng giờ nghỉ: ${_hourController.text}");

        //       Navigator.pop(context, 'saved');
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // buildInputField('Loại nghỉ phép', buildTextInput(_typeNameController)),
            buildInputField('Diễn giải', buildReadonlyTextField(widget.workDescription)),
            buildInputField('Giờ bắt đầu', buildReadonlyTextField(widget.startTime)),
            buildInputField('Giờ kết thúc', buildReadonlyTextField(widget.endtime)),
            buildInputField('Giờ', buildReadonlyTextField(widget.overTimeHour)),
            buildInputField('Ghi chú', buildReadonlyTextField(widget.remark)),          
          ],
        ),
      ),
    );
  }
}
