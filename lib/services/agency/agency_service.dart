import 'package:dio/dio.dart';

Dio dio = Dio();

class AgencyService {
  static dynamic getAddress(token, id) async {
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
