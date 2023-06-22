// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  bool status;
  List<Datum> data;
  String message;

  OrderModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        status: json["Status"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
        "Message": message,
      };
}

class Datum {
  int id;
  List<OrderItem> orderItems;
  String orderQueue;
  String totalPrice;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.orderItems,
    required this.orderQueue,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
        orderQueue: json["order_queue"],
        totalPrice: json["total_price"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "order_queue": orderQueue,
        "total_price": totalPrice,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class OrderItem {
  String name;
  String quantity;

  OrderItem({
    required this.name,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        name: json["name"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
      };

  @override
  String toString() {
    return "$name จำนวน $quantity ชิ้น";
  }
}
