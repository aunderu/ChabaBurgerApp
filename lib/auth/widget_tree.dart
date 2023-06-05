import 'package:chaba_burger_app/auth/auth.dart';
import 'package:flutter/material.dart';

import '../screens/screen_page.dart';
import 'login_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const ScreenPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
