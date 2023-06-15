
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

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

  TextEditingController? nameController;
  TextEditingController? priceController;
  TextEditingController? salePriceController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    priceController = TextEditingController();
    salePriceController = TextEditingController();
  }

  @override
  void dispose() {
    nameController?.dispose();
    priceController?.dispose();
    salePriceController?.dispose();
    super.dispose();
  }

  // Future<void> addMenu(
  //   String category,
  //   String name,
  //   String imgUrl,
  //   int price,
  //   int salePrice,
  // ) async {
  //   await menu
  //       .add({
  //         'category': category,
  //         'name': name,
  //         'img': imgUrl,
  //         'price': price,
  //         'sale_price': salePrice,
  //         'create_at': Timestamp.now(),
  //         'status': "selling",
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

  String? selectedItem;

  String imageUrl = '';

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
            child: FutureBuilder(
              // future: menuController.getAllMenu(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    var menuData = snapshot.data;
                    return GridView.builder(
                      // itemCount: menuData!.length + 1,
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
                                        return Form(
                                          key: _formKey,
                                          child: AlertDialog(
                                            scrollable: true,
                                            title:
                                                const Text('เพิ่มรายการอาหาร'),
                                            elevation: 30,
                                            content: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
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
                                                      controller:
                                                          nameController,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'ชิ่อรายการ',
                                                      ),
                                                      keyboardType:
                                                          TextInputType.name,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'กรุณาใส่ชื่อของรายการอาหาร';
                                                        }
                                                        return null;
                                                      },
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
                                                            controller:
                                                                priceController,
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  'ราคาตั้ง',
                                                              suffix:
                                                                  Text('บาท'),
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'กรุณาใส่ราคาตั้ง';
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                          child: TextFormField(
                                                            controller:
                                                                salePriceController,
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  'ราคาขาย',
                                                              suffix:
                                                                  Text('บาท'),
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'กรุณาใส่ราคาขาย';
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    const Divider(
                                                      color: lightGrey,
                                                      height: 50,
                                                      thickness: 1,
                                                    ),
                                                    imageUrl == ""
                                                        ? SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.10,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.15,
                                                            child: DottedBorder(
                                                              color: darkGray,
                                                              strokeWidth: 1,
                                                              borderType:
                                                                  BorderType
                                                                      .RRect,
                                                              radius: const Radius
                                                                  .circular(20),
                                                              strokeCap:
                                                                  StrokeCap
                                                                      .round,
                                                              dashPattern: const [
                                                                10,
                                                                10
                                                              ],
                                                              child:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  PermissionStatus
                                                                      cameraStatus =
                                                                      await Permission
                                                                          .camera
                                                                          .request();
                                                                  if (cameraStatus ==
                                                                      PermissionStatus
                                                                          .granted) {
                                                                    // ImagePicker
                                                                    //     imagePicker =
                                                                    //     ImagePicker();
                                                                    // XFile?
                                                                    //     file =
                                                                    //     await imagePicker.pickImage(
                                                                    //         source:
                                                                    //             ImageSource.gallery);

                                                                    // if (file ==
                                                                    //     null) {
                                                                    //   return;
                                                                    // }

                                                                    // String
                                                                    //     uniqueFileName =
                                                                    //     DateTime.now()
                                                                    //         .millisecondsSinceEpoch
                                                                    //         .toString();

                                                                    // Reference
                                                                    //     referenceRoot =
                                                                    //     FirebaseStorage
                                                                    //         .instance
                                                                    //         .ref();
                                                                    // Reference
                                                                    //     referenceDirImage =
                                                                    //     referenceRoot
                                                                    //         .child('images');

                                                                    // Reference
                                                                    //     referenceImageToUpload =
                                                                    //     referenceDirImage
                                                                    //         .child(uniqueFileName);

                                                                    // try {
                                                                    //   await referenceImageToUpload
                                                                    //       .putFile(
                                                                    //           File(file.path));

                                                                    //   imageUrl =
                                                                    //       await referenceImageToUpload
                                                                    //           .getDownloadURL();
                                                                    // } catch (error) {}
                                                                  }
                                                                  if (cameraStatus ==
                                                                      PermissionStatus
                                                                          .denied) {}
                                                                  if (cameraStatus ==
                                                                      PermissionStatus
                                                                          .permanentlyDenied) {
                                                                    openAppSettings();
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            35),
                                                                  ),
                                                                  child:
                                                                      const Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .add_photo_alternate_outlined,
                                                                      // color: add,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                    imageUrl != ""
                                                        ? SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.10,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.15,
                                                            child:
                                                                Image.network(
                                                              imageUrl,
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink()
                                                  ],
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
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    if (selectedItem == null) {}

                                                    int priceValue = int.parse(
                                                        priceController!.text);
                                                    int salePriceValue =
                                                        int.parse(
                                                            salePriceController!
                                                                .text);
                                                    // addMenu(
                                                    //   selectedItem!,
                                                    //   nameController!.text,
                                                    //   imageUrl,
                                                    //   priceValue,
                                                    //   salePriceValue,
                                                    // );
                                                    nameController!.clear();
                                                    priceController!.clear();
                                                    salePriceController!
                                                        .clear();
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
                                                  'เพิ่มรายการ',
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
                              // image: DecorationImage(
                              //   image: NetworkImage(
                              //     menuData[index - 1].img,
                              //   ),
                              //   fit: BoxFit.fill,
                              // ),
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
                                          child: FittedBox(
                                            // child: Text(
                                            //   menuData[index - 1].name,
                                            //   style: const TextStyle(
                                            //     fontWeight: FontWeight.bold,
                                            //     fontSize: 25,
                                            //     color: mainColor,
                                            //   ),
                                            //   maxLines: 1,
                                            //   overflow: TextOverflow.ellipsis,
                                            // ),
                                          ),
                                        ),
                                        // หมวดหมู่ของเมนู
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          // child: Text(
                                          //   menuData[index - 1].category,
                                          //   style: const TextStyle(
                                          //     color: mainColor,
                                          //   ),
                                          // ),
                                        ),
                                        // ราคา
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          // child: Text(
                                          //   "${menuData[index - 1].salePrice} บาท",
                                          //   style: const TextStyle(
                                          //     color: mainColor,
                                          //   ),
                                          // ),
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
