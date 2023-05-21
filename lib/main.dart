import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/screen_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Chaba Burger Application',
      debugShowCheckedModeBanner: false,
      home: ScreenPage(),
    );
  }
}
