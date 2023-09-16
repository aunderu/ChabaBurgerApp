import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/category/category_model.dart';
import '../../models/remote_service.dart';
import '../../utils/color.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? nameController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
  }

  @override
  void dispose() {
    nameController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'รายการเมมเบอร์',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: darkMainColor,
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () => FocusScope.of(context).unfocus(),
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return Form(
                              key: _formKey,
                              child: AlertDialog(
                                scrollable: true,
                                title: const Text('เพิ่มเมมเบอร์'),
                                elevation: 30,
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          controller: nameController,
                                          decoration: const InputDecoration(
                                            labelText: 'ชิ่อเมมเบอร์',
                                          ),
                                          keyboardType: TextInputType.name,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'กรุณาใส่ชื่อของเมมเบอร์';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text("ยกเลิก"),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  const SizedBox(width: 20),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // addCategory(nameController!.text);
                                        nameController!.clear();
                                        Get.back();
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green),
                                    ),
                                    icon: const Icon(
                                      Icons.add_box_rounded,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      'เพิ่มเมมเบอร์',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                child: const Text('+ เพิ่มเมมเบอร์'),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: FutureBuilder<CategoryModel?>(
                future: RemoteService().getCategoryModel(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      var categoryData = snapshot.data!.data;
                      // final DataTableSource allItem =
                      //     CategoryData(categoryData.cast<categoryModel.CategoryModel>());
                      return DataTable(
                        columns: const [
                          DataColumn(label: Text("Member ID")),
                          DataColumn(label: Text("Member Name")),
                          DataColumn(label: Text("Member Point")),
                          DataColumn(label: Text("ตัวเลือก")),
                        ],
                        // rows: categoryData
                        //     .map(
                        //       (data) => DataRow(cells: [
                        //         DataCell(Text(data.name)),
                        //         DataCell(Text(data.name)),
                        //         DataCell(Text(data.name)),
                        //         DataCell(
                        //           Row(
                        //             children: [
                        //               IconButton(
                        //                 onPressed: () {
                        //                   // print("edit $index");
                        //                 },
                        //                 icon: const Icon(Icons.edit_rounded),
                        //                 color: Colors.amber,
                        //               ),
                        //               IconButton(
                        //                 onPressed: () {
                        //                   // print("deleted $index");
                        //                 },
                        //                 icon: const Icon(
                        //                     Icons.delete_forever_rounded),
                        //                 color: mainRed,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ]),
                        //     )
                        //     .toList(),
                        rows: [
                          DataRow(
                            cells: [
                              const DataCell(Text("0123456789")),
                              const DataCell(Text("test user")),
                              const DataCell(Text("0")),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // print("edit $index");
                                      },
                                      icon: const Icon(Icons.edit_rounded),
                                      color: Colors.amber,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // print("deleted $index");
                                      },
                                      icon: const Icon(
                                          Icons.delete_forever_rounded),
                                      color: mainRed,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(Text("022223456")),
                              const DataCell(Text("another user")),
                              const DataCell(Text("1112")),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // print("edit $index");
                                      },
                                      icon: const Icon(Icons.edit_rounded),
                                      color: Colors.amber,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // print("deleted $index");
                                      },
                                      icon: const Icon(
                                          Icons.delete_forever_rounded),
                                      color: mainRed,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          snapshot.error.toString(),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('มีบางอย่างผิดพลาด..'),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
