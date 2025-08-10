import 'package:eboss_one/Services/NetWork/NetWorkRequest.dart';
import 'package:eboss_one/View/PersonnelAbsent/PersonnelAbsentCreate_PopupView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Model/PersonnelAbsent/PersonnelAbsentTypeModel.dart' as DataAbsentType;

class PersonnelAbsentEditView extends StatefulWidget {
  final String dateItemAID;
  final String absentAID;
  final String absentTypeID;
  final String absentTypeName;
  final String absentDate;
  final String absentStartTime;
  final String absentEndTime;
  final String absentHour;

  const PersonnelAbsentEditView({
    super.key,
    required this.absentAID,
    required this.dateItemAID,
    required this.absentTypeID,
    required this.absentTypeName,
    required this.absentDate,
    required this.absentStartTime,
    required this.absentEndTime,
    required this.absentHour,
  });

  @override
  State<PersonnelAbsentEditView> createState() =>
      _PersonnelAbsentEditViewState();
}

class _PersonnelAbsentEditViewState extends State<PersonnelAbsentEditView> {
  late TextEditingController _typeNameController;
  late TextEditingController _typeIDController;
  late TextEditingController _dateController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late TextEditingController _hourController;

  @override
  void initState() {
    super.initState();
    _typeNameController = TextEditingController(text: widget.absentTypeName);
    _typeIDController = TextEditingController(text: widget.absentTypeID);
    _dateController = TextEditingController(text: widget.absentDate);
    _startTimeController = TextEditingController(text: widget.absentStartTime);
    _endTimeController = TextEditingController(text: widget.absentEndTime);
    _hourController = TextEditingController(text: widget.absentHour);
  }

  @override
  void dispose() {
    _typeNameController.dispose();
    _typeIDController.dispose();
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _hourController.dispose();
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

  late List<DataAbsentType.Data> listdata;

  Future<String> API_LoadDataPersonnelAbsentType() async {
    try {
      final responses = await NetWorkRequest.GetJWT(
          "/eBOSS/api/PersonnelAbsent/LoadDataPersonnelAbsentType");
      final PersonnelAbsentType =
          DataAbsentType.PersonnelAbsentTypeModel.fromJson(responses);
      listdata = PersonnelAbsentType.data!;
      return "";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> AddPersonnelAbsenType(String NameType, String TypeID) async {
    setState(() {
      // _typeNameController = _typeIDController;
      // _typeIDController = _typeIDController;
    });
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
        title: const Text('Sửa thông tin nghỉ phép'),
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
            buildInputField('Loại nghỉ phép', buildReadonlyTextField(widget.absentTypeName)),
            buildInputField('Ngày nghỉ phép', buildReadonlyTextField(widget.absentDate)),
            buildInputField('Giờ bắt đầu', buildReadonlyTextField(widget.absentStartTime)),
            buildInputField('Giờ kết thúc', buildReadonlyTextField(widget.absentEndTime)),
            buildInputField('Thời gian nghỉ phép', buildReadonlyTextField(widget.absentHour)),          
          ],
        ),
      ),
    );
  }
}
