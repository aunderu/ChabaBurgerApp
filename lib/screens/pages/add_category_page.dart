import 'package:chaba_burger_app/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/category_model.dart';
import '../../models/category_repository.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  // final DataTableSource _data = CategoryData();
  final categoryController = Get.put(CategoryRepository());

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
                onPressed: () {},
                child: const Text('+ เพิ่มหมวดหมู่'),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: FutureBuilder<List<CategoryModel>>(
                future: categoryController.getAllCategory(),
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
        DataCell(Text(category[index].name)),
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
