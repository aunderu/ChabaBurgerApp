import 'package:chaba_burger_app/models/order/order_detail_model.dart';
import 'package:chaba_burger_app/models/remote_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/color.dart';

class SubOrderPage extends StatefulWidget {
  const SubOrderPage({
    super.key,
    required this.orderId,
  });

  final int orderId;

  @override
  State<SubOrderPage> createState() => _SubOrderPageState();
}

class _SubOrderPageState extends State<SubOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<OrderDetailModel?>(
        future: RemoteService().getOrderDetailModel(widget.orderId.toString()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: const IconThemeData(
                    color: darkMainColor,
                    size: 30,
                  ),
                  titleTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case ConnectionState.active:
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: const IconThemeData(
                    color: darkMainColor,
                    size: 30,
                  ),
                  titleTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case ConnectionState.none:
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: const IconThemeData(
                    color: darkMainColor,
                    size: 30,
                  ),
                  titleTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                body: const Center(child: Text('ไม่มีข้อมูลนี้อยู่ในระบบ..')),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    iconTheme: const IconThemeData(
                      color: darkMainColor,
                      size: 30,
                    ),
                    titleTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                  body: const Center(
                    child: Text(
                        'ดูเหมือนมีบางอย่างผิดปกติ กรุณาลองอีกครั้งในภายหลัง'),
                  ),
                );
              } else if (snapshot.hasData) {
                var data = snapshot.data!;
                return OrderDetailScreen(orderDetail: data);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
          }
        },
      ),
    );
  }
}

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({
    super.key,
    required this.orderDetail,
  });

  final OrderDetailModel orderDetail;

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
        title: Text("ORDER #${widget.orderDetail.data.orderQueue}"),
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
                    DateFormat.jm().format(widget.orderDetail.data.createdAt),
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
                        columns: const [
                          DataColumn(label: Text('รายการ')),
                          DataColumn(label: Text('จำนวน')),
                          DataColumn(label: Text('ราคา')),
                          DataColumn(label: Text('ตัวเลือก')),
                        ],
                        rows: widget.orderDetail.data.orderItems
                            .map(
                              (data) => DataRow(cells: [
                                DataCell(Text(data.name)),
                                DataCell(Text(data.quantity)),
                                DataCell(Text(
                                    data.price == null ? "0" : data.price!)),
                                DataCell(
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.delete_forever_rounded),
                                    color: mainRed,
                                  ),
                                ),
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
                                              itemCount: widget.orderDetail.data
                                                  .orderItems.length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      widget
                                                          .orderDetail
                                                          .data
                                                          .orderItems[index]
                                                          .name,
                                                      style: const TextStyle(
                                                          color: darkGray),
                                                    ),
                                                    Text(
                                                      "${widget.orderDetail.data.orderItems[index].quantity} x ${widget.orderDetail.data.orderItems[index].price} บาท",
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
                                                      "${widget.orderDetail.data.totalPrice} บาท",
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
                                                  "${widget.orderDetail.data.totalPrice} บาท",
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
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () {
                              if (isQRcode == false) {
                                showNumberPadDialog(context);
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
                        ),
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

class NumberPadDialog extends StatelessWidget {
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
            child: NumberPadWidget(),
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
  @override
  _NumberPadWidgetState createState() => _NumberPadWidgetState();
}

class _NumberPadWidgetState extends State<NumberPadWidget> {
  String _cash = '';
  int _currentPageIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  void _addDigit(String digit) {
    setState(() {
      _cash += digit;
    });
  }

  void _removeDigit() {
    setState(() {
      if (_cash.isNotEmpty) {
        _cash = _cash.substring(0, _cash.length - 1);
      }
    });
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
            Text(
              _cash,
              style: const TextStyle(fontSize: 35),
            ),
            const SizedBox(height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberButton(
                  digit: '1',
                  onPressed: () => _addDigit('1'),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                NumberButton(
                  digit: '2',
                  onPressed: () => _addDigit('2'),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                NumberButton(
                  digit: '3',
                  onPressed: () => _addDigit('3'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberButton(
                  digit: '4',
                  onPressed: () => _addDigit('4'),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                NumberButton(
                  digit: '5',
                  onPressed: () => _addDigit('5'),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                NumberButton(
                  digit: '6',
                  onPressed: () => _addDigit('6'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberButton(
                  digit: '7',
                  onPressed: () => _addDigit('7'),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                NumberButton(
                  digit: '8',
                  onPressed: () => _addDigit('8'),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                NumberButton(
                  digit: '9',
                  onPressed: () => _addDigit('9'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.check_box_rounded,
                    size: 50,
                    color: Colors.green,
                  ),
                  onPressed: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                NumberButton(
                  digit: '0',
                  onPressed: () => _addDigit('0'),
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
        Text("test Next Page This is Page 2!!"),
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

// Example usage
void showNumberPadDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return NumberPadDialog();
    },
  );
}
