import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String? id;
  final String name;
  final Timestamp createAt;

  const CategoryModel({
    this.id,
    required this.name,
    required this.createAt,
  });

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return CategoryModel(
      id: document.id,
      name: data['name'],
      createAt: data['create_at'],
    );
  }
}
