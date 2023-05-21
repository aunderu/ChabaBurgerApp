import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "หน้ารายงานข้อมูล อยู่ระหว่างการพัฒนา\nขออภัยในความไม่สะดวก",
        textAlign: TextAlign.center,
      ),
    );
  }
}
