import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? id;
  final List<String> orderItem;
  final String orderQueue;
  final int totalPrice;
  final String status;
  final Timestamp createAt;

  const OrderModel({
    this.id,
    required this.orderItem,
    required this.orderQueue,
    required this.totalPrice,
    required this.status,
    required this.createAt,
  });

  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return OrderModel(
      id: document.id,
      orderItem: List.from(data['order_items']),
      orderQueue: data['order_queue'],
      totalPrice: data['total_price'],
      status: data['status'],
      createAt: data['timestamp'],
    );
  }
}
