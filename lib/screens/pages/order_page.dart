import 'package:chaba_burger_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sub_page/sub_order_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "ALL ORDER (2)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
              child: ListView.builder(
            itemCount: 2,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Card(
                color: mainColor,
                child: ListTile(
                  minVerticalPadding: 20,
                  onTap: () {
                    Get.to(
                      () => const SubOrderPage(),
                      transition: Transition.cupertino,
                    );
                  },
                  title: const Text(
                    "ORDER #00123",
                    style: TextStyle(
                      color: darkMainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: const Text(
                    "ชบาเบอร์เกอร์, ชบาเบอร์เกอร์, ชบาเบอร์เกอ...",
                    style: TextStyle(
                      color: lightMainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  trailing: SizedBox(
                    height: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "รวมทั้งหมด 1,000 บาท",
                          style: TextStyle(
                            fontSize: 20,
                            color: darkMainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: darkMainColor,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
