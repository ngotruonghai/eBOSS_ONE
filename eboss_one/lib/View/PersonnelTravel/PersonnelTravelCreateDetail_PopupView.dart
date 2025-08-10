import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../Model/PersonnelAbsentTravel/LoaiCongTacModel.dart'
    as ModelLoaiCongTac;
import '../../Model/PersonnelAbsentTravel/KhuVucModel.dart' as ModelKhuVuc;
import '../../Services/NetWork/NetWorkRequest.dart';
import '../../Services/ShowDialog/DialogMessage_Error.dart';
import 'dart:math';

class PersonnelTravelCreateDetail_PopupView extends StatefulWidget {
  PersonnelTravelCreateDetail_PopupView({super.key, required this.AddPersonnelTravelDetail});

  final Function AddPersonnelTravelDetail;
  @override
  State<PersonnelTravelCreateDetail_PopupView> createState() =>
      _PersonnelTravelCreateDetail_PopupView();
}

class _PersonnelTravelCreateDetail_PopupView
    extends State<PersonnelTravelCreateDetail_PopupView> {
  //final Function AddPersonnelAbsentDetails;

  TextEditingController _txtLyDoPhatSinh = TextEditingController();
  TextEditingController _txtChiPhiPhatSinh = TextEditingController();
  TextEditingController _txtDienGai = TextEditingController();
  TextEditingController _txtGhiChu = TextEditingController();
  String? _loaicongtac;
  String? _khuvuc;
  String? _tenkhuvuc;
  String? _tenloaicongtac;

  int _Status = 1;

  late List<ModelLoaiCongTac.Data> _ListLoaiCongTac;
  late List<ModelKhuVuc.Data> _ListKhuVuc;

  final List<String> items = List.generate(50, (index) => "Item ${index + 1}");

  Future<void> API_DanhSachLoaiCongTac() async {
    try {
      final responses =
          await NetWorkRequest.GetJWT("/eBOSS/api/PersonnelTravel/LoaiCongTac");
      final result = ModelLoaiCongTac.LoaiCongTacModel.fromJson(responses);
      if (result.statusCode == 200) {
        _ListLoaiCongTac = result.data!;
      } else {
        _ListLoaiCongTac = [];
      }
    } catch (e) {
      _ListLoaiCongTac = [];
    }
  }

  Future<void> API_DanhSachKhuVuc() async {
    try {
      final responses = await NetWorkRequest.GetJWT(
          "/eBOSS/api/PersonnelTravel/DanhSachKhuVuc");
      final result = ModelKhuVuc.KhuVucModel.fromJson(responses);
      if (result.statusCode == 200) {
        _ListKhuVuc = result.data!;
      } else {
        _ListKhuVuc = [];
      }
    } catch (e) {
      _ListKhuVuc = [];
    }
  }

  void _onClick(BuildContext context) {
    // if(controller.text.isEmpty){
    //   return;
    // }

    Navigator.pop(context);
  }

//String description,String remark,String workDescription,String workSolution
  Future<void> _onClickAddTask(BuildContext context) async {
    // Kiểm tra diều kiện khi add
    if (_khuvuc == "" || _khuvuc == null) {
      await DialogMessage_Error.showMyDialog(
          context, "Vui lòng chọn khu vực");
      return;
    }
    if (_loaicongtac == "" || _loaicongtac == null) {
      await DialogMessage_Error.showMyDialog(
          context, "Vui lòng chọn loại công tác");
      return;
    }
    if(_txtChiPhiPhatSinh.text != ""){
      if (num.tryParse(_txtChiPhiPhatSinh.text) == null) {
        await DialogMessage_Error.showMyDialog(
            context, "Chi phí phải là số");
        return;
      }
    }
    int randomId= Random().nextInt(1000);

    // add items
    widget.AddPersonnelTravelDetail(randomId,_khuvuc,_loaicongtac,_txtDienGai.text
        ,_txtChiPhiPhatSinh.text,_txtLyDoPhatSinh.text,_txtGhiChu.text,_tenkhuvuc,_tenloaicongtac);
    Navigator.pop(context);
  }

  Future<bool> loadData() async {
    //await Future.delayed(Duration(seconds: 1)); // Giả lập thời gian tải
    //ListLoaiCongTac = widget.ListLoaiCongTac != null?;
    await API_DanhSachLoaiCongTac();
    await API_DanhSachKhuVuc();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              _Status == 1) {
            _Status++;
            // Hiển thị trang tải
            return SizedBox(
              height: 500,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.deepOrange,
                ),
              ),
            );
          } else {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SizedBox(
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: double.infinity, // Đặt chiều rộng
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 2), // Viền màu xanh
                                      borderRadius:
                                      BorderRadius.circular(8), // Bo góc
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        items: _ListKhuVuc.map(
                                                (ModelKhuVuc.Data value) {
                                              return DropdownMenuItem<String>(
                                                value: value.areaID,
                                                child: Text(
                                                    value.description.toString()),
                                              );
                                            }).toList(),
                                        onChanged: (value) {
                                          // Xử lý khi lựa chọn thay đổi
                                          setState(() {
                                            _khuvuc = value as String;
                                            _tenkhuvuc = _ListKhuVuc.firstWhere((items) => items.areaID == _khuvuc).description.toString();
                                          });
                                        },
                                        value: _khuvuc,
                                        hint: Text("Khu vực"),
                                        isExpanded: true, //Cho phép dropdown mở rộng theo chiều dọc
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: Container(
                                    width: double.infinity, // Đặt chiều rộng
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 2), // Viền màu xanh
                                      borderRadius:
                                      BorderRadius.circular(8), // Bo góc
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        items: _ListLoaiCongTac.map(
                                                (ModelLoaiCongTac.Data value) {
                                              return DropdownMenuItem<String>(
                                                value: value.typeID,
                                                child: Text(value.name.toString()),
                                              );
                                            }).toList(),
                                        onChanged: (value) {
                                          // Xử lý khi lựa chọn thay đổi
                                          setState(() {
                                            _loaicongtac = value as String;
                                            _tenloaicongtac = _ListLoaiCongTac.firstWhere((item) => item.typeID == _loaicongtac).name.toString();
                                          });
                                        },
                                        value: _loaicongtac,
                                        hint: Text("Loại công tác"),
                                        isExpanded: true,
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200
                                        ),
                                        // isExpanded:
                                        // true, // Cho phép dropdown mở rộng theo chiều dọc
                                        // dropdownMaxHeight:
                                        // 200, // Đặt chiều cao tối đa của menu dropdown
                                        // dropdownDecoration: BoxDecoration(
                                        //   borderRadius: BorderRadius.circular(8),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text("Diễn giải",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Roboto",
                                          fontSize: 13)),
                                ),
                                TextField(
                                  maxLines: null,
                                  controller: _txtDienGai,
                                  textInputAction: TextInputAction.done,
                                  //textInputAction: TextInputAction.newline,
                                  decoration: InputDecoration(
                                    hintText:
                                    'Diễn giải', // Văn bản gợi ý khi không có văn bản được nhập
                                    border: OutlineInputBorder(), // Đường viền
                                    // Các thuộc tính khác của InputDecoration
                                  ),
                                  style: TextStyle(height: 1.0),
                                  onEditingComplete: () {
                                    // Gọi hàm để tắt bàn phím khi người dùng nhấn Enter
                                    FocusScope.of(context).unfocus();
                                  },
                                ),

                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text("Chi phí phát sinh",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Roboto",
                                          fontSize: 13)),
                                ),
                                TextField(
                                  maxLines: null,
                                  controller: _txtChiPhiPhatSinh,
                                  textInputAction: TextInputAction.done,
                                  //textInputAction: TextInputAction.newline,
                                  decoration: InputDecoration(
                                    hintText:
                                    'Chi phí phát sinh', // Văn bản gợi ý khi không có văn bản được nhập
                                    border: OutlineInputBorder(), // Đường viền
                                    // Các thuộc tính khác của InputDecoration
                                  ),
                                  style: TextStyle(height: 1.0),
                                  onEditingComplete: () {
                                    // Gọi hàm để tắt bàn phím khi người dùng nhấn Enter
                                    FocusScope.of(context).unfocus();
                                  },
                                ),

                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text("Lý do phát sinh",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Roboto",
                                          fontSize: 13)),
                                ),
                                TextField(
                                  maxLines: null,
                                  controller: _txtLyDoPhatSinh,
                                  textInputAction: TextInputAction.done,
                                  //textInputAction: TextInputAction.newline,
                                  decoration: InputDecoration(
                                    hintText:
                                    'Lý do phát sinh', // Văn bản gợi ý khi không có văn bản được nhập
                                    border: OutlineInputBorder(), // Đường viền
                                    // Các thuộc tính khác của InputDecoration
                                  ),
                                  style: TextStyle(height: 1.0),
                                  onEditingComplete: () {
                                    // Gọi hàm để tắt bàn phím khi người dùng nhấn Enter
                                    FocusScope.of(context).unfocus();
                                  },
                                ),

                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text("Ghi chú",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Roboto",
                                          fontSize: 13)),
                                ),
                                TextField(
                                  maxLines: null,
                                  controller: _txtGhiChu,
                                  textInputAction: TextInputAction.done,
                                  //textInputAction: TextInputAction.newline,
                                  decoration: InputDecoration(
                                    hintText:
                                    'Ghi chú', // Văn bản gợi ý khi không có văn bản được nhập
                                    border: OutlineInputBorder(), // Đường viền
                                    // Các thuộc tính khác của InputDecoration
                                  ),
                                  style: TextStyle(height: 1.0),
                                  onEditingComplete: () {
                                    // Gọi hàm để tắt bàn phím khi người dùng nhấn Enter
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.green
                          ),
                          onPressed: () => _onClickAddTask(context),
                          child: const Text("Thêm mới",style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold),),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent
                          ),
                          onPressed: () => _onClick(context),
                          child: const Text("Đóng",style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
