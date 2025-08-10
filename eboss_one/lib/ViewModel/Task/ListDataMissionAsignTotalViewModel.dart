import 'package:eboss_one/View/UserInfo/UserInfoDetailView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/MissionUnFinish/DataMissionAsignTotalModel.dart';
import '../../View/Statistical/MissionAsignTotalDetail_View.dart';

class ListDataMissionAsignTotalViewModel extends StatelessWidget {
  ListDataMissionAsignTotalViewModel({super.key, required this.data,required this.TypeRID});
  String TypeRID;
  Data data;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 50,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MissionAsignTotalDetail_View(NameVietnamese: data.nameVietnamese.toString()
                        ,TypeRID: TypeRID,)
                      ));
                    },
                    child: Container(
                      width: 100,
                      child: Text(data.nameVietnamese.toString() == 0 ? "_" : data.nameVietnamese.toString(),style: TextStyle(fontFamily: "Roboto",fontSize: 13,color: Colors.black,fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Container(
                    width: 65,
                    child: Center(
                      child: Text(data.qtyAssign.toString() == 0 ? "_" : data.qtyAssign.toString(),style: TextStyle(fontFamily: "Roboto",fontSize: 13,color: Colors.black),),
                    ),
                  ),
                  Container(
                    width: 65,
                    child: Center(
                      child: Text(data.qtyReceive.toString() == 0 ? "_" : data.qtyDeal.toString(),style: TextStyle(fontFamily: "Roboto",fontSize: 13,color: Colors.black),),
                    ),
                  ),
                  Container(
                    width: 65,
                    child: Center(
                      child: Text(data.qtyDeal.toString() == 0 ? "_" : data.qtyChecked.toString(),style: TextStyle(fontFamily: "Roboto",fontSize: 13,color: Colors.black),),
                    ),
                  ),
                  Container(
                    width: 65,
                    child: Center(
                      child: Text(data.chuaXuLy.toString() == 0 ? "_" : data.chuaXuLy.toString(),style: TextStyle(fontFamily: "Roboto",fontSize: 13,color: Colors.black),),
                    ),
                  ),
                 SizedBox(
                   width: 2,
                 )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}