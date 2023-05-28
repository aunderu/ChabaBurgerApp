import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../utils/color.dart';

class AddMenuPage extends StatefulWidget {
  const AddMenuPage({super.key});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  List<String> items = [
    "ทั้งหมด",
    "เบอร์เกอร์",
    "ของทานเล่น",
    "เครื่องดื่ม",
    "เซ็ตอาหาร",
    "อื่น ๆ",
  ];

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
            child: GridView.builder(
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
              ),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return GestureDetector(
                    onTap: () {},
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
                      image: const DecorationImage(
                        // image: NetworkImage(
                        //   "https://scontent.fbkk5-4.fna.fbcdn.net/v/t39.30808-6/347795186_769637034690078_7656852021213171053_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=730e14&_nc_ohc=pqc3FG1JkmwAX-T5bN0&_nc_ht=scontent.fbkk5-4.fna&oh=00_AfAjKIe9PTxQR4d5a-7emswRW2FdA8ymFmoUdTzxdOlPeA&oe=646EB3C9",
                        // ),
                        image:
                            AssetImage("assets/images/mockup-burger-img.jpg"),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                // รูปภาพของเมนู
                                // Expanded(
                                //   child: ClipRRect(
                                //     borderRadius: const BorderRadius.only(
                                //       topLeft: Radius.circular(35),
                                //       topRight: Radius.circular(35),
                                //     ),
                                //     child: Image.network(
                                //       "https://scontent.fbkk5-4.fna.fbcdn.net/v/t39.30808-6/347795186_769637034690078_7656852021213171053_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=730e14&_nc_ohc=pqc3FG1JkmwAX-T5bN0&_nc_ht=scontent.fbkk5-4.fna&oh=00_AfAjKIe9PTxQR4d5a-7emswRW2FdA8ymFmoUdTzxdOlPeA&oe=646EB3C9",
                                //       fit: BoxFit.fill,
                                //       height: 170,
                                //       width: double.infinity,
                                //     ),
                                //   ),
                                // ),
                                // ชื่อเมนู
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "ชบาเบอร์เกอร์",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                                // หมวดหมู่ของเมนู
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "เบอร์เกอร์",
                                    style: TextStyle(
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
