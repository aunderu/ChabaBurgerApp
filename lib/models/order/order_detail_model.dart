// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) => OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) => json.encode(data.toJson());

class OrderDetailModel {
    bool status;
    Data data;
    String message;

    OrderDetailModel({
        required this.status,
        required this.data,
        required this.message,
    });

    factory OrderDetailModel.fromJson(Map<String, dynamic> json) => OrderDetailModel(
        status: json["Status"],
        data: Data.fromJson(json["Data"]),
        message: json["Message"],
    );

    Map<String, dynamic> toJson() => {
        "Status": status,
        "Data": data.toJson(),
        "Message": message,
    };
}

class Data {
    int id;
    List<OrderItem> orderItems;
    String orderQueue;
    String totalPrice;
    String status;
    DateTime createdAt;
    DateTime updatedAt;

    Data({
        required this.id,
        required this.orderItems,
        required this.orderQueue,
        required this.totalPrice,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        orderItems: List<OrderItem>.from(json["order_items"].map((x) => OrderItem.fromJson(x))),
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
}
