import 'package:flutter/material.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "หน้าเพิ่มหมวดหมู่ อยู่ระหว่างการพัฒนา\nขออภัยในความไม่สะดวก",
        textAlign: TextAlign.center,
      ),
    );
  }
}
