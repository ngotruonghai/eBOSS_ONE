import 'package:flutter/material.dart';
import '../../Model/PersonnelAbsentTravel/PersonnelAbsentTypeModel.dart';


class PersonnelTravelCreate_PopupView extends StatelessWidget {
  PersonnelTravelCreate_PopupView(
      {super.key, required this.AddPersonnelTravelType, required this.ListData});
  List<Data> ListData;

  String textvalues = '';

  final Function AddPersonnelTravelType;

  TextEditingController controller = TextEditingController();
  void _onClick(BuildContext context, String Name, String TypeID) {
    // if(controller.text.isEmpty){
    //   return;
    // }
    AddPersonnelTravelType(Name, TypeID);
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
                      children: ListData.map((item) {
                        return Column(
                          children: [
                            if(ListData == null)
                              Text("")
                            else
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _onClick(context, item.nameTravel.toString(), item.transportID.toString());
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(item.nameTravel.toString()),
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
                  child: const Text("Đóng"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
