import 'package:chaba_burger_app/models/order_model.dart';
import 'package:chaba_burger_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/order_repository.dart';
import 'sub_page/sub_order_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final orderController = Get.put(OrderRepository());

  List<OrderModel> filteredItems = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: FutureBuilder<List<OrderModel>>(
        future: orderController.getAllOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var orderData = snapshot.data;
              return DefaultTabController(
                length: 4,
                initialIndex: 0,
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        children: [
                          OrderWidget(orderData: orderData, filter: "paid"),
                          OrderWidget(orderData: orderData, filter: "waiting"),
                          OrderWidget(orderData: orderData, filter: "done"),
                          OrderWidget(orderData: orderData, filter: "all"),
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
    );
  }
}

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.orderData,
    required this.filter,
  });

  final List<OrderModel>? orderData;
  final String filter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            (() {
              if (filter == "paid") {
                return "PAID ORDER (${orderData!.where((element) => element.status == "paid").length})";
              } else if (filter == "waiting") {
                return "WAITING ORDER (${orderData!.where((element) => element.status == "waiting").length})";
              } else if (filter == "done") {
                return "DONE ORDER (${orderData!.where((element) => element.status == "done").length})";
              } else {
                return "All ORDER (${orderData!.length})";
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
            itemCount: orderData!.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              switch (filter) {
                case "paid":
                  return orderData![index].status == "paid"
                      ? Card(
                          color: (() {
                            if (orderData![index].status == "paid") {
                              return mainColor;
                            } else if (orderData![index].status == "done") {
                              return Colors.green[100];
                            } else if (orderData![index].status == "waiting") {
                              return lightGrey;
                            }
                          }()),
                          child: ListTile(
                            minVerticalPadding: 20,
                            
                            onTap: () {
                              Get.to(
                                () => const SubOrderPage(),
                                transition: Transition.cupertino,
                              );
                            },
                            title: Text(
                              "ORDER #${orderData![index].orderQueue}",
                              style: const TextStyle(
                                color: darkMainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              orderData![index].orderItem.join(", "),
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
                                    "รวมทั้งหมด ${NumberFormat.decimalPattern().format(orderData![index].totalPrice)} บาท",
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
                  return orderData![index].status == "waiting"
                      ? Card(
                          color: (() {
                            if (orderData![index].status == "paid") {
                              return mainColor;
                            } else if (orderData![index].status == "done") {
                              return Colors.green[100];
                            } else if (orderData![index].status == "waiting") {
                              return lightGrey;
                            }
                          }()),
                          child: ListTile(
                            minVerticalPadding: 20,
                            onTap: () {
                              Get.to(
                                () => const SubOrderPage(),
                                transition: Transition.cupertino,
                              );
                            },
                            title: Text(
                              "ORDER #${orderData![index].orderQueue}",
                              style: const TextStyle(
                                color: darkMainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              orderData![index].orderItem.join(", "),
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
                                    "รวมทั้งหมด ${NumberFormat.decimalPattern().format(orderData![index].totalPrice)} บาท",
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
                  return orderData![index].status == "done"
                      ? Card(
                          color: (() {
                            if (orderData![index].status == "paid") {
                              return mainColor;
                            } else if (orderData![index].status == "done") {
                              return Colors.green[100];
                            } else if (orderData![index].status == "waiting") {
                              return lightGrey;
                            }
                          }()),
                          child: ListTile(
                            minVerticalPadding: 20,
                            onTap: () {
                              Get.to(
                                () => const SubOrderPage(),
                                transition: Transition.cupertino,
                              );
                            },
                            title: Text(
                              "ORDER #${orderData![index].orderQueue}",
                              style: const TextStyle(
                                color: darkMainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              orderData![index].orderItem.join(", "),
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
                                    "รวมทั้งหมด ${NumberFormat.decimalPattern().format(orderData![index].totalPrice)} บาท",
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
                      if (orderData![index].status == "paid") {
                        return mainColor;
                      } else if (orderData![index].status == "done") {
                        return Colors.green[100];
                      } else if (orderData![index].status == "waiting") {
                        return lightGrey;
                      }
                    }()),
                    child: ListTile(
                      minVerticalPadding: 20,
                      onTap: () {
                        Get.to(
                          () => const SubOrderPage(),
                          transition: Transition.cupertino,
                        );
                      },
                      title: Text(
                        "ORDER #${orderData![index].orderQueue}",
                        style: const TextStyle(
                          color: darkMainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        orderData![index].orderItem.join(", "),
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
                              "รวมทั้งหมด ${NumberFormat.decimalPattern().format(orderData![index].totalPrice)} บาท",
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
