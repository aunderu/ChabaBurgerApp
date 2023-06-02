import 'package:cloud_firestore/cloud_firestore.dart';

class MenuModel {
  final String? id;
  final String name;
  final String category;
  final String img;
  final String salePrice;
  final String price;
  final String status;

  const MenuModel({
    this.id,
    required this.name,
    required this.category,
    required this.img,
    required this.salePrice,
    required this.price,
    required this.status,
  });

  factory MenuModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return MenuModel(
      id: document.id,
      name: data['name'],
      category: data['category'],
      img: data['img'],
      salePrice: data['sale_price'],
      price: data['price'],
      status: data['status'],
    );
  }
}
