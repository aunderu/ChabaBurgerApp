
import 'package:chaba_burger_app/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> getAllOrder() async {
    final snapshot =
        await _db.collection("orders").get();
    final orderData = snapshot.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
    return orderData;
  }
}
