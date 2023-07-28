import 'package:dio/dio.dart';

Dio dio = Dio();

class ClientService {
  static dynamic getClient(token, id) async {
    try {
      final response = await dio.get(
        'http://localhost:3000/api/v1/basicservices/clientget/$id',
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
