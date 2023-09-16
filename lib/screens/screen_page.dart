import 'package:flutter/material.dart';

import '../utils/color.dart';
import 'pages/add_category_page.dart';
import 'pages/add_menu_page.dart';
import 'pages/member_page.dart';
import 'pages/menu_page.dart';
import 'pages/order_page.dart';
import 'pages/report_page.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key});

  // final bool isOpen;

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? searchController;

  /// The currently selected index of the bar
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController?.dispose();
    super.dispose();
  }

  /// Views to display
  final List<Widget> _screens = [
    const MenuPage(),
    const OrderPage(),
    const AddMenuPage(),
    const AddCategoryPage(),
    const MemberPage(),
    const ReportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: FutureBuilder(
          // future: usersCollection.doc(user!.uid).snapshots(),
          builder: (ctx, streamSnapshot) {
        var userData = streamSnapshot;
        if (userData.connectionState == ConnectionState.waiting) {
          // return Scaffold(
          //   body: Center(
          //     child: Container(
          //       height: 150,
          //       child: Image.asset(
          //         "assets/images/logo_lowres.jpg",
          //       ),
          //     ),
          //   ),
          // );
          return screenPageWidget(scaffoldKey, userData);
        }
        return screenPageWidget(scaffoldKey, userData);
      }),
    );
  }

  Widget screenPageWidget(
    GlobalKey<ScaffoldState> scaffoldKey,
    userData,
  ) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Image.asset(
          "assets/images/logo_lowres.jpg",
        ),
        leadingWidth: 100,
        title: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: const Offset(12, 26),
                blurRadius: 50,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.1),
              ),
            ],
          ),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              //Do something wi
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: darkMainColor,
              ),
              filled: true,
              fillColor: mainColor,
              hintText: "ค้นหาเมนู",
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: mainColor, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: secondColor, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
          ),
        ),
        actions: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // userData.data != null
              //     ? Text(
              //         userData.data!['user_name'],
              //         style: const TextStyle(
              //           fontWeight: FontWeight.bold,
              //           color: darkGray,
              //           fontSize: 20,
              //         ),
              //       )
              //     : const SizedBox.shrink(),\
              Text(
                "Aun Suthawee",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: darkGray,
                  fontSize: 20,
                ),
              ),
              // userData.data != null
              //     ? Text(
              //         "${userData.data!['role']} / ${userData.data!['gender']}",
              //         style: const TextStyle(
              //           fontWeight: FontWeight.bold,
              //           color: gray,
              //         ),
              //       )
              //     : const SizedBox.shrink(),
              Text(
                // "${userData.data!['role']} / ${userData.data!['gender']}",
                "400012 / ยะลา",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: gray,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              onTap: () => scaffoldKey.currentState!.openEndDrawer(),
              child: const CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage("assets/images/profile.png"),
                backgroundColor: Colors.transparent,
              ),
            ),
          )
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.fastfood_outlined),
                selectedIcon: Icon(Icons.fastfood_rounded),
                label: Text("เมนูอาหาร"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.auto_stories_outlined),
                selectedIcon: Icon(Icons.auto_stories_rounded),
                label: Text("ออเดอร์"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add_box_outlined),
                selectedIcon: Icon(Icons.add_box_rounded),
                label: Text("เพิ่มเมนู"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add_box_outlined),
                selectedIcon: Icon(Icons.add_box_rounded),
                label: Text("เพิ่มหมวดหมู่"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people_outline_rounded),
                selectedIcon: Icon(Icons.people_rounded),
                label: Text("เมมเบอร์"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bar_chart_outlined),
                selectedIcon: Icon(Icons.bar_chart_rounded),
                label: Text("รายงาน"),
              ),
            ],
            minWidth: 100,
            labelType: NavigationRailLabelType.all,
            selectedIconTheme: const IconThemeData(color: darkMainColor),
            selectedLabelTextStyle: const TextStyle(
                color: secondColor, fontWeight: FontWeight.bold),
            unselectedIconTheme: const IconThemeData(color: gray),
            unselectedLabelTextStyle: const TextStyle(color: gray),
            useIndicator: true,
            indicatorColor: mainColor,
            elevation: 1,
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.exit_to_app_rounded,
                      color: Colors.red[400],
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            onDestinationSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
            selectedIndex: selectedIndex,
          ),
          Expanded(child: _screens[selectedIndex]),
        ],
      ),
    );
  }
}
