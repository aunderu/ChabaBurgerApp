import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/screen_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  bool isShopOpen = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isOpen = prefs.getBool("isShopOpen");

    isOpen != null ? isShopOpen = isOpen : isShopOpen = false;

    await prefs.setBool('isShopOpen', isShopOpen);
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //   // stream: Auth().authStateChanges,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return const ScreenPage();
    //     } else {
    //       return const LoginPage();
    //     }
    //   },
    // );
    return const ScreenPage();
  }
}
