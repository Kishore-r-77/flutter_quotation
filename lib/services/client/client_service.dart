import 'package:dio/dio.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';

Dio dio = Dio();

class ClientService {
  // Get All Client
  static getAllClients(
      token, searchString, searchCriteria, pageNo, pageSize) async {
    try {
      final response = await dio.get(
        "http://localhost:3000/api/v1/basicservices/getallclient",
        queryParameters: {
          "searchString": searchString,
          "searchCriteria": searchCriteria
        },
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );

      return response.data;
    } catch (err) {
      throw Exception(err);
    }
  }

  // get Client
  static dynamic getClient(token, id) async {
    try {
      final response = await dio.get(
        '${AppUtils.appUrl}/api/v1/basicservices/clientget/$id',
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get QHeader data');
      }
    } catch (err) {
      throw Exception('An error occurred: $err');
    }
  }
}
