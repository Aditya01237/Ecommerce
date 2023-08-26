import 'dart:convert';
import 'package:cart/data/models/order/order_model.dart';
import 'package:dio/dio.dart';
import '../../core/api.dart';

class OrderRepository {
  final _api = Api();

  Future<List<OrderModel>> fetchOrdersForUser(String userId) async {
    try {
      Response response = await _api.sendRequest.get("/cart/$userId");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data as List<dynamic>)
          .map((json) => OrderModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<OrderModel> createOrder(OrderModel orderModel) async {
    try {
      Response response = await _api.sendRequest
          .post("/order", data: jsonEncode(orderModel.toJson()));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return OrderModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }
}
