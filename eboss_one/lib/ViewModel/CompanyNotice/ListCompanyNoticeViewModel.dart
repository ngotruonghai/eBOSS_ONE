import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/CompanyNoticeRecord/CompanyNoticeModel.dart';
import '../../View/CompanyNotice/DetailCompanyNoticeViewModel.dart';

class ListCompanyNoticeViewModel extends StatelessWidget {
   ListCompanyNoticeViewModel({
    super.key,
    required this.screenWidth,required this.data
  });
  Data data;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: 5, horizontal: 5),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailCompanyNoticeViewModel(
                      notificationID: data.notificationID.toString(),
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 1.0,
          child:SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.notifications,
                                    size: 25,
                                    color: Colors.green,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width:  screenWidth * 0.7,
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => DetailCompanyNoticeViewModel(notificationID:data.notificationID.toString())),
                                          );
                                        },
                                        child: Text(data.notificationAbout.toString(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontFamily: "Roboto"
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 5),
                                      child: Container(
                                        child: Text("Bộ phận: "+data.companyID.toString(),
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.blueAccent,
                                              fontFamily:"Roboto"
                                          ),),
                                      ),)
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ],
                            )),
                        // Padding(padding: EdgeInsets.only(right: 10),
                        //   child:InkWell(
                        //     onTap: (){ 
                        //       print("object");                    
                        //     },
                        //     child:  Icon(
                        //       Icons.my_library_books,
                        //       size: 20,color:  Color(0xFFe17055),
                        //     ),
                        //   ),
                        // )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    )
                ),
                SizedBox(
                  child: Padding(padding: EdgeInsets.only(top: 5,left: 40),
                    child:  Container(
                      width:  screenWidth * 0.7,
                      child: Text(data.description.toString(),
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontFamily: "Roboto"
                        ),
                        overflow: TextOverflow.ellipsis, maxLines: 3,),
                    ),),
                  height: 70,
                ),
                Padding(padding: EdgeInsets.only(top: 5, left: 40,right: 40),
                  child: Row(
                    mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Người phát hành: "+data.singerName.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontFamily: "Roboto"
                        ),),
                      Text(data.recordDate.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontFamily: "Roboto"
                        ),),
                    ],
                  ),),
                SizedBox(
                  height: 10,
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        )
      )
    );
  }
}