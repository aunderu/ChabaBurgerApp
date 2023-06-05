import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/menu_model.dart';
import '../../models/menu_repository.dart';
import '../../utils/color.dart';

class AddMenuPage extends StatefulWidget {
  const AddMenuPage({super.key});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  final _formKey = GlobalKey<FormState>();
  List<String> items = [
    "ทั้งหมด",
    "เบอร์เกอร์",
    "ของทานเล่น",
    "เครื่องดื่ม",
    "เซ็ตอาหาร",
    "อื่น ๆ",
  ];

  String? selectedItem;

  final menuController = Get.put(MemuRepository());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'รายการอาหาร',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: FutureBuilder<List<MenuModel>>(
              future: menuController.getAllMenu(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    var menuData = snapshot.data;
                    return GridView.builder(
                      itemCount: menuData!.length + 1,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () =>
                                        FocusScope.of(context).unfocus(),
                                    child: StatefulBuilder(
                                      builder: (context, setState) {
                                        return AlertDialog(
                                          scrollable: true,
                                          title: const Text('เพิ่มรายการอาหาร'),
                                          elevation: 30,
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.5,
                                              child: Form(
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[100],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: DropdownButton<
                                                          String>(
                                                        icon: const Icon(Icons
                                                            .arrow_drop_down),
                                                        iconSize: 42,
                                                        underline:
                                                            const SizedBox(),
                                                        hint: const Text(
                                                            'เลือกหมวดหมู่'),
                                                        value: selectedItem,
                                                        isExpanded: true,
                                                        items: items
                                                            .map((item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: item,
                                                                  child: Text(
                                                                      item),
                                                                ))
                                                            .toList(),
                                                        onChanged: (item) {
                                                          setState(() {
                                                            selectedItem = item;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(height: 30),
                                                    TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'ชิ่อรายการ',
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                          child: TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  'ราคาตั้ง',
                                                              suffix:
                                                                  Text('บาท'),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                          child: TextFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  'ราคาขาย',
                                                              suffix:
                                                                  Text('บาท'),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text("ยกเลิก"),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                            const SizedBox(width: 20),
                                            ElevatedButton.icon(
                                              onPressed: () {},
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
                                                'เพิ่มรายการ',
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: DottedBorder(
                              color: darkMainColor,
                              strokeWidth: 1,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(35),
                              strokeCap: StrokeCap.round,
                              dashPattern: const [10, 10],
                              child: Container(
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: darkMainColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  menuData[index - 1].img,
                                ),
                                fit: BoxFit.fill,
                              ),
                              color: mainColor,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0, 1),
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: Container(
                                    width: double.infinity,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(35),
                                        bottomRight: Radius.circular(35),
                                      ),
                                      color: Color.fromARGB(154, 40, 26, 1),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // ชื่อเมนู
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 10, right: 10),
                                          child: Text(
                                            menuData[index - 1].name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              color: mainColor,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        // หมวดหมู่ของเมนู
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            menuData[index - 1].category,
                                            style: const TextStyle(
                                              color: mainColor,
                                            ),
                                          ),
                                        ),
                                        // ราคา
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "${menuData[index - 1].salePrice} บาท",
                                            style: const TextStyle(
                                              color: mainColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      padding: const EdgeInsets.all(20),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return const Center(
                      child: Text('ดูเหมือนมีบางอย่างผิดปกติ..'),
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
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    physics: const BouncingScrollPhysics(),
                    itemExtent: 150,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   widget.current = index;
                              // });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.all(5),
                              width: 200,
                              height: 70,
                              decoration: BoxDecoration(
                                // color: widget.current == index
                                //     ? mainGreen
                                //     : Colors.white,
                                color: index == 0 ? darkMainColor : gray,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: const AlignmentDirectional(0, 0),
                              child: Text(
                                items[index],
                                style: const TextStyle(
                                  // color: widget.current == index
                                  //     ? Colors.white
                                  //     : Colors.black,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
