import 'package:eboss_one/Services/NetWork/NetWorkRequest.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonneltravelEdittraveldateView extends StatefulWidget {
  final String dateItemAID;
  final String travelAID;
  final String travelDate;
  final String travelStartTime;
  final String travelEndTime;
  final String travelHour;
  final String isAdditional;

  const PersonneltravelEdittraveldateView({
    super.key,
    required this.dateItemAID,
    required this.travelAID,
    required this.travelDate,
    required this.travelStartTime,
    required this.travelEndTime,
    required this.travelHour,
    required this.isAdditional,
  });

  @override
  State<PersonneltravelEdittraveldateView> createState() =>
      _PersonneltravelEdittraveldateView();
}

class _PersonneltravelEdittraveldateView extends State<PersonneltravelEdittraveldateView> {
  late TextEditingController _travelDateController;
  late TextEditingController _travelStartTimeController;
  late TextEditingController _travelEndTimeController;

  @override
  void initState() {
    super.initState();
    _travelDateController = TextEditingController(text: widget.travelDate);
    _travelStartTimeController = TextEditingController(text: widget.travelStartTime);
    _travelEndTimeController = TextEditingController(text: widget.travelEndTime);
  }

  @override
  void dispose() {
    _travelDateController.dispose();
    _travelStartTimeController.dispose();
    _travelEndTimeController.dispose();
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
        title: const Text('Sửa ngày công tác'),
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
            buildInputField('Ngày công tác', buildReadonlyTextField(widget.travelDate)),
            buildInputField('Thời gian bắt đầu', buildReadonlyTextField(widget.travelStartTime)),
            buildInputField('Thời gian kết thúc', buildReadonlyTextField(widget.travelEndTime)),
            buildInputField('Giờ', buildReadonlyTextField(widget.travelEndTime)),
            buildInputField('Bù chấm công', 
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                  child: Icon(
                    widget.isAdditional == "True"
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
