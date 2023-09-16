import 'package:flutter/material.dart';

import '../../models/category/category_model.dart';
import '../../models/remote_service.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
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
                          DataColumn(label: Text("ชื่อรายการ")),
                          DataColumn(label: Text("หมวดหมู่")),
                          DataColumn(label: Text("จำนวนที่ขายได้ (ชิ้น)")),
                          DataColumn(label: Text("รวมราคา (บาท)")),
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
                        rows: const [
                          DataRow(
                            cells: [
                              DataCell(Text("American Style")),
                              DataCell(Text("เบอร์เกอร์")),
                              DataCell(Text("52")),
                              DataCell(Text("8,201")),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text("Thai Style")),
                              DataCell(Text("เบอร์เกอร์")),
                              DataCell(Text("29")),
                              DataCell(Text("3,625")),
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
