// To parse this JSON data, do
//
//     final menuModel = menuModelFromJson(jsonString);

import 'dart:convert';

MenuModel menuModelFromJson(String str) => MenuModel.fromJson(json.decode(str));

String menuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
    bool status;
    List<Datum> data;
    String message;

    MenuModel({
        required this.status,
        required this.data,
        required this.message,
    });

    factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
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
    String name;
    String img;
    String category;
    int price;
    String? status;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        required this.id,
        required this.name,
        required this.img,
        required this.category,
        required this.price,
        this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        img: json["img"],
        category: json["category"],
        price: json["price"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
        "category": category,
        "price": price,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
