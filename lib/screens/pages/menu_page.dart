import 'dart:ui';

import 'package:chaba_burger_app/models/category/category_model.dart';
import 'package:chaba_burger_app/models/remote_service.dart';
import 'package:chaba_burger_app/utils/color.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../models/menu/menu_model.dart';
import '../../models/menu/menu_select_item.dart';
import 'sub_page/sub_order_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<MenuSelectItem> selectedItems = [];
  int _totalPrice = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> addOrder(String status, int totalPrice) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(darkMainColor),
            strokeWidth: 7,
          ),
        );
      },
    );

    Map<String, String> headers = {
      'Content-type': 'multipart/form-data',
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse("https://chaba-pos.com/api/order/store"))
      ..headers.addAll(headers)
      ..fields.addAll({
        'order_queue': "00001",
        'status': status,
        'total_price': totalPrice.toString(),
      });

    for (var i = 0; i < selectedItems.length; i++) {
      request.fields.addAll({
        'name[$i]': selectedItems[i].name,
        'quantity[$i]': selectedItems[i].quantity.toString(),
      });
    }

    var response = await request.send();

    Get.back();

    if (response.statusCode == 200) {
      return true;
    } else {
      throw false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // left side widget
        Expanded(
          flex: 7,
          child: Column(
            children: [
              // menu
              Expanded(
                flex: 8,
                child: FutureBuilder<MenuModel?>(
                  future: RemoteService().getMenuModel(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return const CircularProgressIndicator();
                      case ConnectionState.waiting:
                        if (snapshot.hasData) {
                          var data = snapshot.data!.data;
                          return menuItemWidget(data);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      case ConnectionState.active:
                        if (snapshot.hasData) {
                          var data = snapshot.data!.data;
                          return menuItemWidget(data);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text("ดูเหมือนมีอะไรผิดปกติ.."));
                        } else {
                          if (snapshot.hasData) {
                            var data = snapshot.data!.data;
                            return menuItemWidget(data);
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else {
                            return const Center(
                              child: Text('ดูเหมือนมีบางอย่างผิดปกติ..'),
                            );
                          }
                        }
                    }
                  },
                ),
              ),

              // category of menu
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
                      child: FutureBuilder<List<CategoryModel>>(
                        // future: categoryController.getAllCategory(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              var categoryData = snapshot.data;
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: categoryData!.length,
                                physics: const BouncingScrollPhysics(),
                                itemExtent: 150,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // setState(() {
                                          //   widget.current = index;
                                          // });
                                        },
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          margin: const EdgeInsets.all(5),
                                          width: 200,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            // color: widget.current == index
                                            //     ? mainGreen
                                            //     : Colors.white,
                                            color: index == 0
                                                ? darkMainColor
                                                : gray,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          alignment:
                                              const AlignmentDirectional(0, 0),
                                          // child: Text(
                                          //   categoryData[index].name,
                                          //   style: const TextStyle(
                                          //     // color: widget.current == index
                                          //     //     ? Colors.white
                                          //     //     : Colors.black,
                                          //     color: Colors.white,
                                          //     fontWeight: FontWeight.bold,
                                          //     fontSize: 20,
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
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
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // right side widget
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // order number tag
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(
                      "ORDER #",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),

                // order details
                Expanded(
                  child: DottedBorder(
                    color: darkGray,
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(35),
                    strokeCap: StrokeCap.round,
                    dashPattern: const [10, 10],
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          // ส่วนบน
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ListView.builder(
                                itemCount: selectedItems.length,
                                physics: const BouncingScrollPhysics(),
                                // itemExtent: 85,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Builder(builder: (context) {
                                      return Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              color: mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          selectedItems[index]
                                                              .name,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        Text(
                                                          'ราคา ${selectedItems[index].price} x ${selectedItems[index].quantity} ชิ้น',
                                                          style:
                                                              const TextStyle(
                                                            color: darkGray,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        'บาท',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${selectedItems[index].price * selectedItems[index].quantity}',
                                                        // _totalPrice.toString(),

                                                        style:
                                                            const TextStyle(),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (selectedItems[index]
                                                      .quantity >
                                                  1) {
                                                setState(() {
                                                  selectedItems[index] =
                                                      MenuSelectItem(
                                                    id: selectedItems[index].id,
                                                    name: selectedItems[index]
                                                        .name,
                                                    price: selectedItems[index]
                                                        .price,
                                                    quantity:
                                                        selectedItems[index]
                                                            .quantity -= 1,
                                                  );
                                                });
                                              } else {
                                                setState(() {
                                                  selectedItems.removeAt(index);
                                                });
                                              }
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  );
                                },
                              ),
                            ),
                          ),
                          const Divider(color: gray),

                          // ส่วนล่าง
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  const Spacer(),
                                  // รวมทั้งหมด
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text(
                                        'รวมทั้งหมด',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        (() {
                                          _totalPrice = selectedItems.fold(
                                            0,
                                            (previousValue, element) =>
                                                previousValue +
                                                (element.price *
                                                    element.quantity),
                                          );

                                          return '${NumberFormat.decimalPattern().format(_totalPrice)} บาท';
                                        }()),
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),

                                  // ปุ่ม
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // setState(() {
                                          //   selectedItems.clear();
                                          // });

                                          // print(
                                          //     "______________________________");
                                          // print(selectedItems);

                                          addOrder("waiting", _totalPrice)
                                              .then((value) {
                                            if (value == true) {
                                              Get.snackbar(
                                                "เรียบร้อย!",
                                                "ออเดอร์คิวที่ #0001 เรียบร้อย รายการดังนี้ : ${selectedItems.join(", ")}",
                                                backgroundColor:
                                                    Colors.green[50],
                                                colorText: Colors.black,
                                              );

                                              setState(() {
                                                selectedItems.clear();
                                              });
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 60,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            color: Colors.green[200],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "ส่งออเดอร์",
                                              style: TextStyle(
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Get.to(
                                          //   () => SubOrderPage(
                                          //     orderId:
                                          //         orderData[reverseIndex].id,
                                          //   ),
                                          // );
                                        },
                                        child: Container(
                                          height: 60,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey[100],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "ชำระเงิน",
                                              style: TextStyle(
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget menuItemWidget(List<Datum> data) {
    return GridView.builder(
      itemCount: 2,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
      ),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (selectedItems
                .where((element) => element.id == data[index].id)
                .isEmpty) {
              setState(() {
                selectedItems.add(
                  MenuSelectItem(
                    id: data[index].id,
                    name: data[index].name,
                    price: data[index].price,
                    quantity: 1,
                  ),
                );

                _totalPrice = selectedItems.fold(
                    0,
                    (previousValue, element) =>
                        previousValue + (element.price * element.quantity));
              });
            } else {
              setState(() {
                MenuSelectItem(
                  id: selectedItems[selectedItems
                          .indexWhere((item) => item.id == data[index].id)]
                      .id,
                  name: selectedItems[selectedItems
                          .indexWhere((item) => item.id == data[index].id)]
                      .name,
                  price: selectedItems[selectedItems
                          .indexWhere((item) => item.id == data[index].id)]
                      .price,
                  quantity: selectedItems[selectedItems
                          .indexWhere((item) => item.id == data[index].id)]
                      .quantity += 1,
                );

                _totalPrice = selectedItems.fold(
                    0,
                    (previousValue, element) =>
                        previousValue + (element.price * element.quantity));
              });
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                      // data[index].img,
                      "https://chaba-pos.com/storage/menu_image/Thai%20Stlye_20230612212830.jpg",
                    ),
                    // image: AssetImage(
                    //     "assets/images/mockup-burger-img.jpg"),
                    fit: BoxFit.fill,
                  ),
                  color: mainColor,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Align(
                  alignment: const AlignmentDirectional(0, 1),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35),
                          ),
                          color: Color.fromARGB(154, 40, 26, 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // ชื่อเมนู
                              FittedBox(
                                child: Text(
                                  data[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: mainColor,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              // หมวดหมู่ของเมนู
                              Text(
                                data[index].category,
                                style: const TextStyle(
                                  color: mainColor,
                                ),
                              ),
                              // ราคา
                              Text(
                                "${data[index].price} บาท",
                                style: const TextStyle(
                                  color: mainColor,
                                  fontSize: 20,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // selectedItems
              //         .where((element) => element.name == data[index].name)
              //         .isNotEmpty
              //     ? Align(
              //         alignment: Alignment.topRight,
              //         child: GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               selectedItems.removeWhere(
              //                   (element) => element.name == data[index].name);
              //             });
              //           },
              //           child: Container(
              //             decoration: const BoxDecoration(
              //               color: Colors.red,
              //               shape: BoxShape.circle,
              //             ),
              //             child: const Icon(
              //               Icons.close_rounded,
              //               color: Colors.white,
              //               size: 40,
              //             ),
              //           ),
              //         ),
              //       )
              //     : const SizedBox.shrink(),
              selectedItems
                      .where((element) => element.name == data[index].name)
                      .isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Container(
                          width: 75,
                          color: const Color.fromARGB(211, 40, 26, 1),
                          child: Text(
                            selectedItems[selectedItems.indexWhere(
                                    (element) => element.id == data[index].id)]
                                .quantity
                                .toString(),
                            style: const TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        );
      },
      padding: const EdgeInsets.all(20),
    );
  }
}
