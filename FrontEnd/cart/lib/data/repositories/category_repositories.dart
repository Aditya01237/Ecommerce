// use of this is that it fetch the raw data from api and
// put data in user model
import 'package:cart/core/api.dart';
import 'package:cart/data/models/category/category_model.dart';
import 'package:dio/dio.dart';

class CategoryRepository {
  final _api = Api();

  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      Response response = await _api.sendRequest.get("/category");

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      //convert raw data to model
      return (apiResponse.data as List<dynamic>)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (ex) {
      rethrow;
    }
  }
}
