import 'package:chaba_burger_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/category_model.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  // final DataTableSource _data = CategoryData();
  TextEditingController? nameController;
  final _formKey = GlobalKey<FormState>();

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

  // Future<void> addCategory(String name) async {
  //   await category
  //       .add({
  //         'name': name,
  //         'create_at': Timestamp.now(),
  //       })
  //       .then((value) => Get.snackbar(
  //             'เรียบร้อย!',
  //             'เพิ่มข้อมูลเสร็จสิ้น',
  //             snackPosition: SnackPosition.BOTTOM,
  //             backgroundColor: Colors.green[300],
  //           ))
  //       .catchError((error) => Get.snackbar(
  //             'มีบางอย่างผิดพลาด',
  //             '$error',
  //             snackPosition: SnackPosition.BOTTOM,
  //             colorText: Colors.white,
  //             backgroundColor: Colors.red[300],
  //           ));
  //   setState(() {});
  // }

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
                'หมวดหมู่รายการอาหาร',
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
                                title: const Text('เพิ่มหมวดหมู่รายการอาหาร'),
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
                                            labelText: 'ชิ่อหมวดหมู่รายการ',
                                          ),
                                          keyboardType: TextInputType.name,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'กรุณาใส่ชื่อของหมวดหมู่รายการอาหาร';
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
                                      'เพิ่มหมวดหมู่',
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
                child: const Text('+ เพิ่มหมวดหมู่'),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: FutureBuilder<List<CategoryModel>>(
                // future: categoryController.getAllCategory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      var categoryData = snapshot.data;
                      final DataTableSource allUsers =
                          CategoryData(categoryData as List<CategoryModel>);
                      return PaginatedDataTable(
                        showFirstLastButtons: true,
                        columnSpacing: MediaQuery.of(context).size.width * 0.65,
                        columns: const [
                          DataColumn(label: Text("รายการ")),
                          DataColumn(label: Text("ตัวเลือก")),
                        ],
                        source: allUsers,
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

class CategoryData extends DataTableSource {
  final List<CategoryModel> category;

  CategoryData(this.category);

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        // DataCell(Text(category[index].name)),
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
                icon: const Icon(Icons.delete_forever_rounded),
                color: mainRed,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => category.length;

  @override
  int get selectedRowCount => 0;
}
