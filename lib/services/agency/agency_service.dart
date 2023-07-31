import 'package:dio/dio.dart';

Dio dio = Dio();

class AgencyService {
  static dynamic getAllAgency(
      token, searchString, searchCriteria, pageNo, pageSize) async {
    try {
      final response = await dio.get(
        'http://localhost:3000/api/v1/pacificservices/agencies',
        queryParameters: {
          "searchString": searchString,
          "searchCriteria": searchCriteria
        },
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get Agency data');
      }
    } catch (err) {
      throw Exception('An error occurred: $err');
    }
  }

  static dynamic getAgency(token, id) async {
    try {
      final response = await dio.get(
        'http://localhost:3000/api/v1/pacificservices/agencyget/$id',
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get Agency data');
      }
    } catch (err) {
      throw Exception('An error occurred: $err');
    }
  }
}
