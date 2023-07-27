import 'package:dio/dio.dart';

Dio dio = Dio();

class QuotationServices {
  static getAllQuotation(
      token, searchString, searchCriteria, pageNo, pageSize) async {
    try {
      final response = await dio.get(
        "http://localhost:3000/api/v1/quotationservices/qheaders",
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
}
