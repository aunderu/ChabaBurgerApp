import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'category/category_model.dart';
import 'menu/menu_model.dart';
import 'order/order_detail_model.dart';
import 'order/order_model.dart';

const url = "https://chaba-pos.com/api";

MenuModel? resultMenuModel;
OrderModel? resultOrderModel;
OrderDetailModel? resultOrderDetailModel;
CategoryModel? resultCategoryModel;

class RemoteService {
  // ################################ MenuModel #################################
  Future<MenuModel?> getMenuModel() async {
    try {
      final response = await http.get(
        Uri.parse("$url/menu/show"),
      );
      if (response.statusCode == 200) {
        final itemMenuModel = json.decode(response.body);
        resultMenuModel = MenuModel.fromJson(itemMenuModel);
      } else {
        throw Exception(jsonDecode(response.body));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return resultMenuModel;
  }

  // ################################ OrderModel #################################
  Future<OrderModel?> getOrderModel() async {
    try {
      final response = await http.get(
        Uri.parse("$url/order/show"),
      );
      if (response.statusCode == 200) {
        final itemOrderModel = json.decode(response.body);
        resultOrderModel = OrderModel.fromJson(itemOrderModel);
      } else {
        throw Exception(jsonDecode(response.body));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return resultOrderModel;
  }

  // ################################ OrderDetailModel #################################
  Future<OrderDetailModel?> getOrderDetailModel(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$url/order/detail/$id"),
      );
      if (response.statusCode == 200) {
        final itemOrderDetailModel = json.decode(response.body);
        resultOrderDetailModel =
            OrderDetailModel.fromJson(itemOrderDetailModel);
      } else {
        throw Exception(jsonDecode(response.body));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return resultOrderDetailModel;
  }


  // ################################ CategoryModel #################################
  Future<CategoryModel?> getCategoryModel() async {
    try {
      final response = await http.get(
        Uri.parse("$url/category/show"),
      );
      if (response.statusCode == 200) {
        final itemCategoryModel = json.decode(response.body);
        resultCategoryModel =
            CategoryModel.fromJson(itemCategoryModel);
      } else {
        throw Exception(jsonDecode(response.body));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return resultCategoryModel;
  }
}
