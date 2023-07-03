import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../../models/order/order_model.dart';
import '../../../utils/color.dart';
import '../../screen_page.dart';

class SubOrderPage extends StatefulWidget {
  const SubOrderPage({
    super.key,
    required this.orderId,
    required this.orderItems,
    required this.orderQueue,
    required this.totalPrice,
    required this.status,
    required this.time,
  });

  final int orderId;
  final List<OrderItem> orderItems;
  final String orderQueue;
  final String totalPrice;
  final String status;
  final DateTime time;

  @override
  State<SubOrderPage> createState() => _SubOrderPageState();
}

class _SubOrderPageState extends State<SubOrderPage> {
  @override
  Widget build(BuildContext context) {
    return OrderDetailScreen(
      orderId: widget.orderId,
      orderItems: widget.orderItems,
      orderQueue: widget.orderQueue,
      totalPrice: widget.totalPrice,
      status: widget.status,
      time: widget.time,
    );
  }
}

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({
    super.key,
    required this.orderId,
    required this.orderItems,
    required this.orderQueue,
    required this.totalPrice,
    required this.status,
    required this.time,
  });

  // final OrderDetailModel orderDetail;
  final int orderId;
  final List<OrderItem> orderItems;
  final String orderQueue;
  final String totalPrice;
  final String status;
  final DateTime time;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool isQRcode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: darkMainColor,
          size: 30,
        ),
        title: Text("ORDER #${widget.orderQueue}"),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.black,
        ),
        actions: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "เวลา",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    // "${widget.orderDetail.createdAt} น.",
                    DateFormat.jm().format(widget.time),
                    style: const TextStyle(
                      color: darkMainColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // left side
          Expanded(
            flex: 7,
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: DataTable(
                        columns: [
                          const DataColumn(label: Text('รายการ')),
                          const DataColumn(label: Text('จำนวน')),
                          const DataColumn(label: Text('ราคา')),
                          widget.status != "paid"
                              ? const DataColumn(label: Text('ตัวเลือก'))
                              : const DataColumn(label: Text('')),
                        ],
                        rows: widget.orderItems
                            .map(
                              (data) => DataRow(cells: [
                                DataCell(Text(data.name)),
                                DataCell(Text(data.quantity)),
                                DataCell(Text(
                                    data.price == null ? "0" : data.price!)),
                                widget.status != "paid"
                                    ? DataCell(
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.delete_forever_rounded),
                                          color: mainRed,
                                        ),
                                      )
                                    : DataCell.empty,
                              ]),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                        // decoration: BoxDecoration(
                        //   color: Colors.red[100],
                        //   borderRadius: BorderRadius.circular(25),
                        // ),
                        // width: double.infinity,
                        // child: const Center(
                        //   child: Text(
                        //     "ยกเลิกออเดอร์",
                        //     style: TextStyle(fontSize: 25),
                        //   ),
                        // ),
                        ),
                  ),
                ),
              ],
            ),
          ),

          // right side
          Expanded(
            flex: 3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: [
                  // Column(
                  //   children: [
                  //     Text("วิธีการชำระ : เงินสด"),
                  //   ],
                  // ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "วิธีการชำระ : ${isQRcode ? "QRCode" : "เงินสด"}",
                            style: const TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                if (isQRcode == true) {
                                  setState(() {
                                    isQRcode = !isQRcode;
                                  });
                                }
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Ink(
                                height: 80,
                                width: 130,
                                decoration: BoxDecoration(
                                  color:
                                      isQRcode == false ? mainColor : lightGrey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.money_rounded,
                                      color: Colors.black45,
                                    ),
                                    Text("เงินสด"),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (isQRcode == false) {
                                  setState(() {
                                    isQRcode = !isQRcode;
                                  });
                                }
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Ink(
                                height: 80,
                                width: 130,
                                decoration: BoxDecoration(
                                  color:
                                      isQRcode == true ? mainColor : lightGrey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.qr_code_2_rounded,
                                      color: Colors.black45,
                                    ),
                                    Text("QRCode"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Column(
                            children: [
                              // const Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: Text(
                              //     "วิธีการชำระ : เงินสด",
                              //     style: TextStyle(
                              //       // fontWeight: FontWeight.bold,
                              //       fontSize: 20,
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(height: 10),
                              // Container(
                              //   width: double.infinity,
                              //   height: 30,
                              //   decoration: BoxDecoration(
                              //     color: lightGrey,
                              //     border: Border.all(color: darkGray),
                              //     borderRadius: BorderRadius.circular(20),
                              //   ),
                              //   child: const Padding(
                              //     padding: EdgeInsets.symmetric(horizontal: 15),
                              //     child: Row(
                              //       children: [
                              //         Expanded(
                              //           child: Text(
                              //             "ส่วนลด 10%",
                              //             style: TextStyle(color: darkGray),
                              //           ),
                              //         ),
                              //         Icon(
                              //           Icons.arrow_drop_down_rounded,
                              //           color: darkGray,
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: DottedBorder(
                                  color: darkGray,
                                  strokeWidth: 1,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(35),
                                  strokeCap: StrokeCap.round,
                                  dashPattern: const [10, 10],
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35.0),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 7,
                                            child: ListView.builder(
                                              itemCount:
                                                  widget.orderItems.length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      widget.orderItems[index]
                                                          .name,
                                                      style: const TextStyle(
                                                          color: darkGray),
                                                    ),
                                                    Text(
                                                      "${widget.orderItems[index].quantity} x ${widget.orderItems[index].price} บาท",
                                                      style: const TextStyle(
                                                          color: darkGray),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "รวมราคา",
                                                      style: TextStyle(
                                                          color: darkGray),
                                                    ),
                                                    Text(
                                                      "${widget.totalPrice} บาท",
                                                      style: const TextStyle(
                                                          color: darkGray),
                                                    ),
                                                  ],
                                                ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceBetween,
                                                //   children: [
                                                //     Text(
                                                //       "ส่วนลด 10%",
                                                //       style: TextStyle(
                                                //           color: darkGray),
                                                //     ),
                                                //     Text(
                                                //       "100 บาท",
                                                //       style: TextStyle(
                                                //           color: darkGray),
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: darkGray,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  "รวมทั้งหมด",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "${widget.totalPrice} บาท",
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        widget.status != "paid"
                            ? Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    if (isQRcode == false) {
                                      showNumberPadDialog(
                                          context,
                                          widget.orderId,
                                          widget.orderItems,
                                          widget.orderQueue,
                                          widget.totalPrice,
                                          widget.status);
                                    } else {}
                                  },
                                  borderRadius: BorderRadius.circular(25),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    width: double.infinity,
                                    child: const Center(
                                      child: Text(
                                        "ชำระเงิน",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showNumberPadDialog(
  BuildContext context,
  int orderId,
  List<OrderItem> orderItems,
  String orderQueue,
  String totalPrice,
  String status,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return NumberPadDialog(
        orderId: orderId,
        orderItems: orderItems,
        orderQueue: orderQueue,
        totalPrice: totalPrice,
        status: status,
      );
    },
  );
}

class NumberPadDialog extends StatelessWidget {
  final int orderId;
  final List<OrderItem> orderItems;
  final String orderQueue;
  final String totalPrice;
  final String status;

  const NumberPadDialog({
    super.key,
    required this.orderId,
    required this.orderItems,
    required this.orderQueue,
    required this.totalPrice,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonBarTheme(
      data: const ButtonBarThemeData(
        alignment: MainAxisAlignment.center,
      ),
      child: AlertDialog(
        title: const Text(
          'รับเงินสด',
          style: TextStyle(fontSize: 35),
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: NumberPadWidget(
              orderId: orderId,
              orderItems: orderItems,
              orderQueue: orderQueue,
              totalPrice: totalPrice,
              status: status,
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class NumberPadWidget extends StatefulWidget {
  final int orderId;
  final List<OrderItem> orderItems;
  final String orderQueue;
  final String totalPrice;
  final String status;

  const NumberPadWidget({
    super.key,
    required this.orderId,
    required this.orderItems,
    required this.orderQueue,
    required this.totalPrice,
    required this.status,
  });

  @override
  _NumberPadWidgetState createState() => _NumberPadWidgetState();
}

class _NumberPadWidgetState extends State<NumberPadWidget> {
  final TextEditingController _myController = TextEditingController();
  PageController _pageController = PageController(initialPage: 0);

  void _addDigit(int digit) {
    setState(() {
      _myController.text += digit.toString();
    });
  }

  void _removeDigit() {
    setState(() {
      if (_myController.text.isNotEmpty) {
        _myController.text =
            _myController.text.substring(0, _myController.text.length - 1);
      }
    });
  }

  Future<bool> editOrder(
    String status,
    String orderQueue,
    String totalPrice,
    List<OrderItem> orderItems,
    String orderId,
  ) async {
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
        'POST', Uri.parse("https://chaba-pos.com/api/order/update/$orderId"))
      ..headers.addAll(headers)
      ..fields.addAll({
        'order_queue': orderQueue,
        'status': status,
        'total_price': totalPrice,
      });

    for (var i = 0; i < orderItems.length; i++) {
      request.fields.addAll({
        'name[$i]': orderItems[i].name,
        'quantity[$i]': orderItems[i].quantity.toString(),
        'price[$i]': orderItems[i].price.toString(),
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
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextField(
              controller: _myController,
              textAlign: TextAlign.center,
              showCursor: false,
              keyboardType: TextInputType.none,
              style: const TextStyle(fontSize: 35),
            ),
            const SizedBox(height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberButton(
                  digit: '1',
                  onPressed: () => _addDigit(1),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                NumberButton(
                  digit: '2',
                  onPressed: () => _addDigit(2),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                NumberButton(
                  digit: '3',
                  onPressed: () => _addDigit(3),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberButton(
                  digit: '4',
                  onPressed: () => _addDigit(4),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                NumberButton(
                  digit: '5',
                  onPressed: () => _addDigit(5),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                NumberButton(
                  digit: '6',
                  onPressed: () => _addDigit(6),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberButton(
                  digit: '7',
                  onPressed: () => _addDigit(7),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                NumberButton(
                  digit: '8',
                  onPressed: () => _addDigit(8),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                NumberButton(
                  digit: '9',
                  onPressed: () => _addDigit(9),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.check_box_rounded,
                    size: 50,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    if (_myController.text.isNotEmpty) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                NumberButton(
                  digit: '0',
                  onPressed: () => _addDigit(0),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.backspace,
                    size: 50,
                    color: Colors.red,
                  ),
                  onPressed: _removeDigit,
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "รับเงินสด",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "${_myController.text} บาท",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "จำนวนที่ต้องชำระ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "${widget.totalPrice} บาท",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "จำนวนเงินที่ต้องทอน",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "${int.parse(_myController.text.isEmpty ? "0" : _myController.text) - int.parse(widget.totalPrice)} บาท",
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: InkWell(
                        onTap: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        splashColor: Colors.blueGrey[100],
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 75,
                          padding: const EdgeInsets.all(25.0),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: const Center(
                            child: Text(
                              'ย้อนกลับ',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: InkWell(
                        onTap: () {
                          editOrder(
                            "paid",
                            widget.orderQueue,
                            widget.totalPrice,
                            widget.orderItems,
                            widget.orderId.toString(),
                          ).then((value) {
                            if (value) {
                              Get.offAll(() => const ScreenPage());
                            } else {
                              Get.snackbar("โอ้ะ?",
                                  "ดูเหมือนมีอะไรผิดพลาด กรุณาลอกอีกครั้งในภายหลัง");
                            }
                          });
                        },
                        splashColor: Colors.green[700],
                        child: Ink(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 75,
                          padding: const EdgeInsets.all(25.0),
                          decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(5.0)),
                          child: const Center(
                            child: Text(
                              'สำเร็จออเดอร์',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
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
    );
  }
}

class NumberButton extends StatelessWidget {
  final String digit;
  final VoidCallback onPressed;

  const NumberButton({super.key, required this.digit, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        digit,
        style: const TextStyle(fontSize: 50),
      ),
    );
  }
}
