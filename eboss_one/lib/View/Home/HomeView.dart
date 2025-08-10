import 'package:eboss_one/View/Task/TaskManagementView.dart';
import 'package:flutter/material.dart';
import '../../View/Home/HomeDrawerView.dart';
import '../../View/Home/HomeScreenView.dart';
import '../UserInfo/UserInfoView.dart';


class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    // TaskManagementView(),
    UserInfoView(),
  ];
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFF70A1FF),
      appBar: AppBar(
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(

                image: AssetImage("assets/lego_eboss.png"),
                width: 40,
                height: 40,
              ),
              Text("eBOSS ONE", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),
              SizedBox(
                width: 30,
              )
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFED801C),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            tooltip: "menu",
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        actions: <Widget>[
          // IconButton(
          //     onPressed: () {}, icon: const Icon(Icons.notifications_sharp))
        ],
      ),
      drawer: const DrawerHome(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: AppBarBootom(onItemTapped: onItemTapped),
    );
  }
}

class AppBarBootom extends StatefulWidget {
  const AppBarBootom({super.key, required this.onItemTapped});

  final onItemTapped;

  @override
  State<AppBarBootom> createState() => _AppBarBootomState();
}

class _AppBarBootomState extends State<AppBarBootom> {
  int IndexTab = 0;

  void clickOnTab(int Index) {
    widget.onItemTapped(Index);
    setState(() {
      IndexTab = Index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white54,
            width: 1.0,
          ),
        ),
        ),
      child:  BottomNavigationBar(
        currentIndex: IndexTab,
        backgroundColor: const Color(0xFFFFFFFF),
        type: BottomNavigationBarType.fixed,
        selectedItemColor:
        const Color(0xFFFED801C), // Set the color of the selected tab
        unselectedItemColor: Colors.black38,
        items: [
          BottomNavigationBarItem(icon: Image.asset(
            "assets/home.png",
            width: 25, // bạn có thể điều chỉnh kích thước icon
            height: 25,
          ), label: "Trang chủ"),
          // BottomNavigationBarItem(
          //   icon: Image.asset(
          //     "assets/productivity.png",
          //     width: 25, // bạn có thể điều chỉnh kích thước icon
          //     height: 25,
          //   ),
          //   label: "Nhiệm vụ",
          // ),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/profile.png",
                width: 25, // bạn có thể điều chỉnh kích thước icon
                height: 25,
              ), label: "Hồ sơ")
        ],
        onTap: (index) {
          clickOnTab(index);
        },
      ),
    );
  }
}
