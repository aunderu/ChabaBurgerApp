
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'category_model.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategory() async {
    final snapshot =
        await _db.collection("categories").get();
    final categoryData = snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
    return categoryData;
  }
}
