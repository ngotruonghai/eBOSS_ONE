import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Services/NetWork/NetWorkRequest.dart';
import '../../Model/Calendar/CalendarViewerModel.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  List<CalendarViewerModel> listdata = [];

  DateTime today = DateTime.now();

  void initState() {
    super.initState();
    loadCalendarData(today);
  }

  void _onDaySelect(DateTime day, DateTime forcusDay){
    setState(() {
      today = day;
    });
    loadCalendarData(today);
  }

  Future<void> loadCalendarData(DateTime day) async {
    final String dateStr = "${today.day.toString().padLeft(2, '0')}/${today.month.toString().padLeft(2, '0')}/${today.year.toString().padLeft(2, '0')}";

    final response = await NetWorkRequest.PostJWT(
        "/eBOSS/api/Calendar/GetCalendarViewerInfo",
      {
        "SelectionDate": dateStr,
      },);

    if (response != null && response["data"] != null) {
      List<dynamic> rawData = response["data"];
      setState(() {
        listdata = rawData.map((item) => CalendarViewerModel.fromJson(item)).toList();
      });
    } else {
      setState(() {
        listdata = [];
      });
    }
    //print("ngày: $dateStr");
    //print("API Response: $response");
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Color(0xFFFED801C),
        title: Text("Lịch"),
        titleTextStyle: TextStyle(
          color: Colors.white, // Set the title color
          fontSize: 20,        // Optional: Set font size
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
        child: Column(
          children: [
            TableCalendar(
              rowHeight: 32,
              locale: "vi_VN",
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: today,
              onDaySelected: _onDaySelect,
              selectedDayPredicate: (day)=>isSameDay(day, today),
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: HeaderStyle(
                  titleCentered: true
              ),
              availableCalendarFormats: {
                CalendarFormat.month: 'Month',
              },
            ),
            Divider( // Đây là đường kẻ ngang
              color: Color(0xFFdfe6e9), // Màu sắc của đường kẻ
              thickness: 1, // Độ dày của đường kẻ
              indent: 10, // Khoảng cách từ lề trái
              endIndent: 10, // Khoảng cách từ lề phải
            ),
            Expanded( // Scroll
              child: listdata.isEmpty
                  ? Center(
                child: Text(
                  "",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                itemCount: listdata.length,
                itemBuilder: (context, index) {
                  final item = listdata[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/${item.imageKey}',
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            "${item.description}",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Roboto",
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}