import 'package:flutter/material.dart';

class AddMenuPage extends StatefulWidget {
  const AddMenuPage({super.key});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("หน้าเพิ่ม เมนูนะจ้ะ"),
    );
  }
}