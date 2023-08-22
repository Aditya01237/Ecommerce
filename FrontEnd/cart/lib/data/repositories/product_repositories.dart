// use of this is that it fetch the raw data from api and
// put data in user model
import 'package:cart/core/api.dart';
import 'package:cart/data/models/category/category_model.dart';
import 'package:cart/data/models/product/product_model.dart';
import 'package:dio/dio.dart';

class ProductRepository {
  final _api = Api();

  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      Response response = await _api.sendRequest.get("/product");

      ApiResponse apiResponse = ApiResponse.fromResponce(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      //convert raw data to model
      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProductBuCategory(String categoryId) async {
    try {
      Response response =
          await _api.sendRequest.get("/product/category/$categoryId");

      ApiResponse apiResponse = ApiResponse.fromResponce(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      //convert raw data to model
      return (apiResponse.data as List<dynamic>)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }
}
