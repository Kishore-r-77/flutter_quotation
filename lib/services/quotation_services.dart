import 'package:dio/dio.dart';

Dio dio = Dio();

class QuotationServices {
  static getAllQuotation(token) async {
    try {
      final response = await dio.get(
        "http://localhost:3000/api/v1/quotationservices/qheaders",
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );

      return response.data["All QHeaders"];
    } catch (err) {
      throw Exception(err);
    }
  }
}
