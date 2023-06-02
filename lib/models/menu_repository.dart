import 'package:chaba_burger_app/models/menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MemuRepository extends GetxController {
  static MemuRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<MenuModel>> getAllMenu() async {
    final snapshot =
        await _db.collection("menus").get();
    final menuData = snapshot.docs.map((e) => MenuModel.fromSnapshot(e)).toList();
    return menuData;
  }
}
