import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../utils/color.dart';

class SubOrderPage extends StatefulWidget {
  const SubOrderPage({super.key});

  @override
  State<SubOrderPage> createState() => _SubOrderPageState();
}

class _SubOrderPageState extends State<SubOrderPage> {
  final DataTableSource _data = MyData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: darkMainColor,
          size: 30,
        ),
        title: const Text("ORDER #00123"),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.black,
        ),
        actions: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: const [
                  Icon(
                    Icons.access_time_rounded,
                    color: Colors.black,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "เวลา",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    "08:02 น.",
                    style: TextStyle(
                      color: darkMainColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // left side
          Expanded(
            flex: 7,
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: SizedBox(
                    width: double.infinity,
                    child: PaginatedDataTable(
                      columns: const [
                        DataColumn(label: Text("รายการ")),
                        DataColumn(label: Text("ราคา (บาท)")),
                        DataColumn(label: Text("จำนวน")),
                        DataColumn(label: Text("ผลรวม")),
                        DataColumn(label: Text("")),
                      ],
                      source: _data,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: double.infinity,
                      child: const Center(
                        child: Text(
                          "ยกเลิกออเดอร์",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // right side
          Expanded(
            flex: 3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: [
                  // Column(
                  //   children: [
                  //     Text("วิธีการชำระ : เงินสด"),
                  //   ],
                  // ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "วิธีการชำระ : เงินสด",
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 80,
                              width: 130,
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.money_rounded,
                                    color: Colors.black45,
                                  ),
                                  Text("เงินสด"),
                                ],
                              ),
                            ),
                            Container(
                              height: 80,
                              width: 130,
                              decoration: BoxDecoration(
                                color: lightGrey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.qr_code_2_rounded,
                                    color: Colors.black45,
                                  ),
                                  Text("QRCode"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "วิธีการชำระ : เงินสด",
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: lightGrey,
                                  border: Border.all(color: darkGray),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: const [
                                      Expanded(
                                        child: Text(
                                          "ส่วนลด 10%",
                                          style: TextStyle(color: darkGray),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down_rounded,
                                        color: darkGray,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: DottedBorder(
                                  color: darkGray,
                                  strokeWidth: 1,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(35),
                                  strokeCap: StrokeCap.round,
                                  dashPattern: const [10, 10],
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35.0),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: const [
                                                    Text(
                                                      "รวมราคา",
                                                      style: TextStyle(
                                                          color: darkGray),
                                                    ),
                                                    Text(
                                                      "1000 บาท",
                                                      style: TextStyle(
                                                          color: darkGray),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: const [
                                                    Text(
                                                      "ส่วนลด 10%",
                                                      style: TextStyle(
                                                          color: darkGray),
                                                    ),
                                                    Text(
                                                      "100 บาท",
                                                      style: TextStyle(
                                                          color: darkGray),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: darkGray,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: const [
                                                Text(
                                                  "รวมทั้งหมด",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "900 บาท",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(25),
                            ),
                            width: double.infinity,
                            child: const Center(
                              child: Text(
                                "ยกเลิกออเดอร์",
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
    200,
    (index) => {
      "product_name": "เบอร์เกอร์ $index",
      "price": Random().nextInt(2000),
      "quantity": Random().nextInt(10),
      "sum": Random().nextInt(2000),
    },
  );

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(_data[index]['product_name'])),
        DataCell(Text(_data[index]['price'].toString())),
        DataCell(Text(_data[index]['quantity'].toString())),
        DataCell(Text(_data[index]['sum'].toString())),
        DataCell(
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_forever_rounded),
            color: mainRed,
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
