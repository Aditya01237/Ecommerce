// use of this is that it fetch the raw data from api and
// put data in user model

import 'dart:convert';
import 'package:cart/core/api.dart';
import 'package:cart/data/models/user/user_model.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final _api = Api();

  Future<UserModel> createAccount(
      {required String email, required String password}) async {
    try {
      Response response = await _api.sendRequest.post("/user/createAccount",
          data: jsonEncode({"email": email, "password": password}));

      ApiResponse apiResponse = ApiResponse.fromResponce(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      //convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<UserModel> signIn(
      {required String email, required String password}) async {
    print("sigin in model called");
    try {
      Response response = await _api.sendRequest.post("/user/signIn",
          data: jsonEncode({"email": email, "password": password}));
      print(response);
      print("api res recived");
      ApiResponse apiResponse = ApiResponse.fromResponce(response);
      print(apiResponse);
      if (!apiResponse.success) {
        print(apiResponse.success);
        throw apiResponse.message.toString();
      }
      print(apiResponse.success);
      //convert raw data to model
      return UserModel.fromJson(apiResponse.data);
    } catch (ex) {
      rethrow;
    }
  }
}
