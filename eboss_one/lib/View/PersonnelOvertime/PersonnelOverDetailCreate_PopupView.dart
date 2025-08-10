import 'package:flutter/material.dart';

class PersonnelOverDetailCreate_PopupView extends StatefulWidget {
  final Function AddDetail;
  final String gioBatDau;
  final String gioKetThuc;

  const PersonnelOverDetailCreate_PopupView({
    super.key,
    required this.AddDetail,
    required this.gioBatDau,
    required this.gioKetThuc,
  });

  @override
  _PersonnelOverDetailCreate_PopupViewState createState() =>
      _PersonnelOverDetailCreate_PopupViewState();
}

class _PersonnelOverDetailCreate_PopupViewState
    extends State<PersonnelOverDetailCreate_PopupView> {
  late TextEditingController _txtDienGiai;
  late TextEditingController _txtGioBatDau;
  late TextEditingController _txtGioKetThuc;
  late TextEditingController _txtGhiChu;

  @override
  void initState() {
    super.initState();
    _txtDienGiai = TextEditingController();
    _txtGioBatDau = TextEditingController(text: widget.gioBatDau);
    _txtGioKetThuc = TextEditingController(text: widget.gioKetThuc);
    _txtGhiChu = TextEditingController();
  }

  @override
  void dispose() {
    _txtDienGiai.dispose();
    _txtGioBatDau.dispose();
    _txtGioKetThuc.dispose();
    _txtGhiChu.dispose();
    super.dispose();
  }

  void _onClick(BuildContext context) {
    Navigator.pop(context);
  }

  void _onClickAddTask(BuildContext context) {
    widget.AddDetail(
      _txtDienGiai.text,
      _txtGioBatDau.text,
      _txtGioKetThuc.text,
      _txtGhiChu.text,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SizedBox(
        height: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Diễn giải",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Roboto",
                              fontSize: 13),
                        ),
                      ),
                      TextField(
                        maxLines: null,
                        controller: _txtDienGiai,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          hintText: 'Diễn giải',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(height: 1.0),
                        onEditingComplete: () =>
                            FocusScope.of(context).unfocus(),
                      ),
                      const SizedBox(height: 15),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Giờ bắt đầu",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Roboto",
                              fontSize: 13),
                        ),
                      ),
                      TextField(
                        controller: _txtGioBatDau,
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            initialEntryMode: TimePickerEntryMode.input,
                            cancelText: "Đóng",
                            confirmText: "Chọn",
                          );
                          if (picked != null) {
                            final formattedTime = picked.hour
                                .toString()
                                .padLeft(2, '0') +
                                ':' +
                                picked.minute.toString().padLeft(2, '0');
                            setState(() {
                              _txtGioBatDau.text = formattedTime;
                            });
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Giờ bắt đầu',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.access_time),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Giờ kết thúc",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Roboto",
                              fontSize: 13),
                        ),
                      ),
                      TextField(
                        controller: _txtGioKetThuc,
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            initialEntryMode: TimePickerEntryMode.input,
                            cancelText: "Đóng",
                            confirmText: "Chọn",
                          );
                          if (picked != null) {
                            final formattedTime = picked.hour
                                .toString()
                                .padLeft(2, '0') +
                                ':' +
                                picked.minute.toString().padLeft(2, '0');
                            setState(() {
                              _txtGioKetThuc.text = formattedTime;
                            });
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Giờ kết thúc',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.access_time),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Ghi chú",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Roboto",
                              fontSize: 13),
                        ),
                      ),
                      TextField(
                        maxLines: null,
                        controller: _txtGhiChu,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          hintText: 'Ghi chú',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(height: 1.0),
                        onEditingComplete: () =>
                            FocusScope.of(context).unfocus(),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () => _onClickAddTask(context),
                  child: const Text(
                    "Thêm mới",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                  ),
                  onPressed: () => _onClick(context),
                  child: const Text(
                    "Đóng",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
