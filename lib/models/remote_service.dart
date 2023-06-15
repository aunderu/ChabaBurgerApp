import 'dart:convert';

import 'package:chaba_burger_app/models/order_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'menu_model.dart';

const url = "https://chaba-pos.com/api";

MenuModel? resultMenuModel;
OrderModel? resultOrderModel;

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
}
