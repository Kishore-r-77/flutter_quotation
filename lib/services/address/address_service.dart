import 'package:dio/dio.dart';

Dio dio = Dio();

class AddressService {
  static dynamic getAllAddress(
      token, searchString, searchCriteria, pageNo, pageSize) async {
    try {
      final response = await dio.get(
        'http://localhost:3000/api/v1/basicservices/addresses',
        queryParameters: {
          "searchString": searchString,
          "searchCriteria": searchCriteria,
          // "pageSize": 100
        },
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get Address data');
      }
    } catch (err) {
      throw Exception('An error occurred: $err');
    }
  }

  static dynamic getAddress(token, id) async {
    try {
      final response = await dio.get(
        'http://localhost:3000/api/v1/basicservices/addressget/$id',
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get Address data');
      }
    } catch (err) {
      throw Exception('An error occurred: $err');
    }
  }
}
