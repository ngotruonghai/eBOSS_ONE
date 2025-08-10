import 'package:flutter/material.dart';
class PersonnelAbsentAttachFile_PopupView extends StatelessWidget {
  PersonnelAbsentAttachFile_PopupView(
      {super.key, required this.AddPersonnelAbsentAttachFile});

  final Function AddPersonnelAbsentAttachFile;

  TextEditingController _txtDienGai = TextEditingController();
  TextEditingController _txtGhiChu = TextEditingController();

  void _onClick(BuildContext context, String TypeName, String TypeID) {
    // if(controller.text.isEmpty){
    //   return;
    // }

    Navigator.pop(context);
  }
//String description,String remark,String workDescription,String workSolution
  void _onClickAddTask(BuildContext context){
    AddPersonnelAbsentAttachFile(_txtDienGai.text,_txtGhiChu.text);
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
                        Padding(padding: EdgeInsets.only(bottom: 10),
                          child: Text("Diễn giải",style: TextStyle(color: Colors.grey,fontFamily: "Roboto",
                              fontSize: 13)),),
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

                        Padding(padding: EdgeInsets.only(bottom: 10),
                          child: Text("Ghi chú",style: TextStyle(color: Colors.grey,fontFamily: "Roboto",
                              fontSize: 13)),),
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
                        SizedBox(
                          height: 15,
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
                      backgroundColor:  Colors.green
                  ),
                  onPressed: () => _onClickAddTask(context),
                  child: const Text("Thêm mới",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
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
                      backgroundColor:  Colors.orangeAccent
                  ),
                  onPressed: () => _onClick(context, "", ""),
                  child: const Text("Đóng",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
