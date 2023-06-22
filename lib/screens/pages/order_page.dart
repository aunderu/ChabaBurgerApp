import 'dart:async';
import 'dart:convert';

import 'package:chaba_burger_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/order/order_model.dart';
import 'sub_page/sub_order_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  StreamController<OrderModel> streamController = StreamController();

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 3), (timer) {
      _getOrderModel();
    });
  }

  Future<void> _getOrderModel() async {
    var url = Uri.parse("https://chaba-pos.com/api/order/show");

    final response = await http.get(url);
    final databody = json.decode(response.body);

    OrderModel orderModel = OrderModel.fromJson(databody);

    if (!streamController.isClosed) {
      streamController.sink.add(orderModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: StreamBuilder(
        stream: streamController.stream,
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.done) {
          //   if (snapshot.hasData) {
          //     var orderData = snapshot.data!.data;
          //     // print(orderData[2].orderItems);
          //     return DefaultTabController(
          //       length: 4,
          //       initialIndex: 0,
          //       child: Column(
          //         children: [
          //           Expanded(
          //             child: TabBarView(
          //               children: [
          //                 orderWidget(context, orderData, "paid"),
          //                 orderWidget(context, orderData, "waiting"),
          //                 orderWidget(context, orderData, "done"),
          //                 orderWidget(context, orderData, "all"),
          //               ],
          //             ),
          //           ),
          //           const TabBar(
          //             isScrollable: true,
          //             labelColor: Colors.black,
          //             unselectedLabelColor: lightMainColor,
          //             indicatorColor: darkMainColor,
          //             indicatorWeight: 5,
          //             physics: BouncingScrollPhysics(),
          //             labelStyle: TextStyle(
          //               fontSize: 25,
          //               fontWeight: FontWeight.bold,
          //             ),
          //             tabs: [
          //               Tab(
          //                 text: 'จ่ายแล้ว',
          //               ),
          //               Tab(
          //                 text: 'รอชำระ',
          //               ),
          //               Tab(
          //                 text: 'เสร็จสิ้น',
          //               ),
          //               Tab(
          //                 text: 'ทั้งหมด',
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     );
          //   } else if (snapshot.hasError) {
          //     return Center(
          //       child: Text(snapshot.error.toString()),
          //     );
          //   } else {
          //     return const Center(
          //       child: Text('ดูเหมือนมีบางอย่างผิดปกติ..'),
          //     );
          //   }
          // } else {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Text('กรุณารอสักครู่..');
              } else {
                var orderData = snapshot.data!.data;
                // print(orderData[2].orderItems);
                return DefaultTabController(
                  length: 4,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      Expanded(
                        child: TabBarView(
                          children: [
                            orderWidget(context, orderData, "paid"),
                            orderWidget(context, orderData, "waiting"),
                            orderWidget(context, orderData, "done"),
                            orderWidget(context, orderData, "all"),
                          ],
                        ),
                      ),
                      const TabBar(
                        isScrollable: true,
                        labelColor: Colors.black,
                        unselectedLabelColor: lightMainColor,
                        indicatorColor: darkMainColor,
                        indicatorWeight: 5,
                        physics: BouncingScrollPhysics(),
                        labelStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        tabs: [
                          Tab(
                            text: 'จ่ายแล้ว',
                          ),
                          Tab(
                            text: 'รอชำระ',
                          ),
                          Tab(
                            text: 'เสร็จสิ้น',
                          ),
                          Tab(
                            text: 'ทั้งหมด',
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }

  Widget orderWidget(
    BuildContext context,
    List<Datum> orderData,
    String filter,
  ) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            (() {
              if (filter == "paid") {
                return "PAID ORDER (${orderData.where((element) => element.status == "paid").length})";
              } else if (filter == "waiting") {
                return "WAITING ORDER (${orderData.where((element) => element.status == "waiting").length})";
              } else if (filter == "done") {
                return "DONE ORDER (${orderData.where((element) => element.status == "done").length})";
              } else {
                return "All ORDER (${orderData.length})";
              }
            }()),
            // "ALL ORDER (${orderData!.length})",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView.builder(
            itemCount: orderData.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              int reverseIndex = orderData.length - 1 - index;
              switch (filter) {
                case "paid":
                  return orderData[reverseIndex].status == "paid"
                      ? Card(
                          color: (() {
                            if (orderData[reverseIndex].status == "paid") {
                              return mainColor;
                            } else if (orderData[reverseIndex].status ==
                                "done") {
                              return Colors.green[100];
                            } else if (orderData[reverseIndex].status ==
                                "waiting") {
                              return lightGrey;
                            }
                          }()),
                          child: ListTile(
                            minVerticalPadding: 20,
                            onTap: () {
                              Get.to(
                                () => SubOrderPage(
                                  orderId: orderData[reverseIndex].id,
                                ),
                                transition: Transition.cupertino,
                              );
                            },
                            onLongPress: () {
                              // print('long press!!');
                            },
                            leading: const SizedBox(
                              height: double.infinity,
                              child: Icon(
                                Icons.circle_outlined,
                              ),
                            ),
                            title: Text(
                              "ORDER #${orderData[reverseIndex].orderQueue}",
                              style: const TextStyle(
                                color: darkMainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              orderData[reverseIndex].orderItems.join(", "),
                              // orderData[reverseIndex].orderItems,
                              // jsonDecode(orderData[index].orderItems),
                              style: const TextStyle(
                                color: lightMainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: SizedBox(
                              height: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "รวมทั้งหมด ${orderData[reverseIndex].totalPrice} บาท",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: darkMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: darkMainColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                case "waiting":
                  return orderData[reverseIndex].status == "waiting"
                      ? Card(
                          color: (() {
                            if (orderData[reverseIndex].status == "paid") {
                              return mainColor;
                            } else if (orderData[reverseIndex].status ==
                                "done") {
                              return Colors.green[100];
                            } else if (orderData[reverseIndex].status ==
                                "waiting") {
                              return lightGrey;
                            }
                          }()),
                          child: ListTile(
                            minVerticalPadding: 20,
                            onTap: () {
                              Get.to(
                                () => SubOrderPage(
                                  orderId: orderData[reverseIndex].id,
                                ),
                                transition: Transition.cupertino,
                              );
                            },
                            onLongPress: () {
                              // print('long press!!');
                            },
                            title: Text(
                              "ORDER #${orderData[reverseIndex].orderQueue}",
                              style: const TextStyle(
                                color: darkMainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              orderData[reverseIndex].orderItems.join(", "),
                              // orderData[reverseIndex].orderItems,
                              // jsonEncode(orderData[reverseIndex].orderItems),
                              style: const TextStyle(
                                color: lightMainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: SizedBox(
                              height: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "รวมทั้งหมด ${orderData[reverseIndex].totalPrice} บาท",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: darkMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: darkMainColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                case "done":
                  return orderData[reverseIndex].status == "done"
                      ? Card(
                          color: (() {
                            if (orderData[reverseIndex].status == "paid") {
                              return mainColor;
                            } else if (orderData[reverseIndex].status ==
                                "done") {
                              return Colors.green[100];
                            } else if (orderData[reverseIndex].status ==
                                "waiting") {
                              return lightGrey;
                            }
                          }()),
                          child: ListTile(
                            minVerticalPadding: 20,
                            onTap: () {
                              Get.to(
                                () => SubOrderPage(
                                  orderId: orderData[reverseIndex].id,
                                ),
                                transition: Transition.cupertino,
                              );
                            },
                            title: Text(
                              "ORDER #${orderData[reverseIndex].orderQueue}",
                              style: const TextStyle(
                                color: darkMainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              orderData[reverseIndex].orderItems.join(", "),
                              // orderData[reverseIndex].orderItems,
                              style: const TextStyle(
                                color: lightMainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: SizedBox(
                              height: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "รวมทั้งหมด ${orderData[reverseIndex].totalPrice} บาท",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: darkMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: darkMainColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                default:
                  return Card(
                    // color: mainColor,
                    color: (() {
                      if (orderData[reverseIndex].status == "paid") {
                        return mainColor;
                      } else if (orderData[reverseIndex].status == "done") {
                        return Colors.green[100];
                      } else if (orderData[reverseIndex].status == "waiting") {
                        return lightGrey;
                      }
                    }()),
                    child: ListTile(
                      minVerticalPadding: 20,
                      onTap: () {
                        Get.to(
                          () => SubOrderPage(
                            orderId: orderData[reverseIndex].id,
                          ),
                          transition: Transition.cupertino,
                        );
                      },
                      title: Text(
                        "ORDER #${orderData[reverseIndex].orderQueue}",
                        style: const TextStyle(
                          color: darkMainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        orderData[reverseIndex].orderItems.join(", "),
                        style: const TextStyle(
                          color: lightMainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: SizedBox(
                        height: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "รวมทั้งหมด ${orderData[reverseIndex].totalPrice} บาท",
                              style: const TextStyle(
                                fontSize: 20,
                                color: darkMainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: darkMainColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}
