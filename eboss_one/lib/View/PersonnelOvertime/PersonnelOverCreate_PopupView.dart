import 'package:flutter/material.dart';
import '../../Model/PersonnelOverTime/PersonnelOverTypeModel.dart'
as DataOverType;


class PersonnelOverCreate_PopupView extends StatelessWidget {
  PersonnelOverCreate_PopupView(
      {super.key, required this.AddPersonnelAbsenType, required this.listData});
  List<DataOverType.Data> listData;

  String textvalues = '';
  final Function AddPersonnelAbsenType;

  TextEditingController controller = TextEditingController();
  void _onClick(BuildContext context, String TypeName, String TypeID) {
    // if(controller.text.isEmpty){
    //   return;
    // }
    AddPersonnelAbsenType(TypeName, TypeID);
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
                      children: listData.map((item) {
                        return Column(
                          children: [
                            if(listData == null)
                              Text("")
                            else
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _onClick(context, item.nameType.toString(), item.typeID.toString());
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(item.nameType.toString()),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    // Đường kẻ ngang
                                    color: Colors.grey, // Màu sắc của đường kẻ ngang
                                    thickness: 0.5, // Độ dày của đường kẻ ngang
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )
                          ],
                        );
                      }).toList(),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent
                  ),
                  onPressed: () => _onClick(context, "", ""),
                  child: const Text("Đóng",style: TextStyle(color:Colors.white,fontSize: 15, fontWeight: FontWeight.bold),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
