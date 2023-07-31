import 'package:dio/dio.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';

Dio dio = Dio();

class AuthServices {
  static Future<dynamic> logout() async {
    try {
      final response = await dio.post("${AppUtils.appUrl}/api/v1/auth/logout");
      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        throw Exception("Something went wrong");
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}
