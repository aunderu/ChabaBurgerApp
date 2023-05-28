import 'package:chaba_burger_app/utils/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  bool passwordVisibility = false;
  String? errorMessage = '';

  final _formKey = GlobalKey<FormState>();

  Future<void> signInWithEmailAndPassWord() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: userIdController.text,
        password: userPasswordController.text,
      );

      // addUserDetails();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  // Future addUserDetails() async {
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'email': userIdController.text,
  //     'profile_url': "",
  //     'role': "แอดมิน",
  //     'sex': "ชาย",
  //     'user_name': "Admin Aun",
  //     // 'uid': user.uid,
  //   });
  // }

  @override
  void initState() {
    super.initState();
    userIdController = TextEditingController();
    userPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    userIdController.dispose();
    userPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: mainColor,
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/logo_lowres.jpg",
                            height: 150,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: userIdController,
                                  onChanged: (value) {
                                    //Do something wi
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    label: const Text("อีเมลพนักงาน"),
                                    labelStyle:
                                        const TextStyle(color: darkMainColor),
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: darkMainColor,
                                    ),
                                    filled: true,
                                    fillColor: mainColor,
                                    hintText: 'itimsolution2022@gmail.com',
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(.75)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 20.0),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: mainColor, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: darkMainColor, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: mainRed, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: mainColor, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'กรุณากรอกอีเมลก่อนเพื่อเข้าสู่ระบบด้วย';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                TextFormField(
                                  controller: userPasswordController,
                                  onChanged: (value) {
                                    //Do something wi
                                  },
                                  obscureText: !passwordVisibility,
                                  keyboardType: TextInputType.visiblePassword,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  decoration: InputDecoration(
                                    label: const Text("รหัสผ่าน"),
                                    labelStyle:
                                        const TextStyle(color: darkMainColor),
                                    prefixIcon: const Icon(
                                      Icons.password,
                                      color: darkMainColor,
                                    ),
                                    filled: true,
                                    fillColor: mainColor,
                                    hintText: 'YourP@ssword123456',
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(.75)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 20.0),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: mainColor, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: darkMainColor, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: mainRed, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: mainColor, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => passwordVisibility =
                                            !passwordVisibility,
                                      ),
                                      child: Icon(
                                        passwordVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.grey.shade400,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'กรุณากรอกรหัสผ่านก่อนเพื่อเข้าสู่ระบบด้วย';
                                    }
                                    return null;
                                  },
                                ),
                                Visibility(
                                  visible: errorMessage != "",
                                  replacement: const SizedBox.shrink(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        errorMessage!,
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Material(
                                child: InkWell(
                                  onTap: () {
                                    bool validate =
                                        _formKey.currentState!.validate();
                                    if (validate) {
                                      // print(userIdController.text);
                                      // print(userPasswordController.text);
                                      signInWithEmailAndPassWord();
                                    }
                                  },
                                  child: Ink(
                                    height: 60,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: darkMainColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "เข้าสู่ระบบ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: mainColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
          ),
        ),
      ),
    );
  }
}