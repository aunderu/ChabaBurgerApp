import 'package:chaba_burger_app/utils/color.dart';
import 'package:flutter/material.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final DataTableSource _data = MyData();

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
              child: PaginatedDataTable(
                showFirstLastButtons: true,
                columnSpacing: MediaQuery.of(context).size.width * 0.65,
                columns: const [
                  DataColumn(label: Text("รายการ")),
                  DataColumn(label: Text("ตัวเลือก")),
                ],
                source: _data,
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
      "category_name": "หมวดหมู่ $index",
    },
  );

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(_data[index]['category_name'])),
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
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
