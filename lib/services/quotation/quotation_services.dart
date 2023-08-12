import 'package:dio/dio.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';

Dio dio = Dio();

class QuotationServices {
  // Get All QHeader
  static getAllQuotation(
      token, searchString, searchCriteria, pageNo, pageSize) async {
    try {
      final response = await dio.get(
        "${AppUtils.appUrl}/api/v1/quotationservices/qheaders",
        queryParameters: {
          "searchString": searchString,
          "searchCriteria": searchCriteria,
          "pageSize": pageSize
        },
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );

      return response.data;
    } catch (err) {
      throw Exception(err);
    }
  }

  // Get QHeader

  static dynamic getQuotation(token, id) async {
    try {
      final response = await dio.get(
        '${AppUtils.appUrl}/api/v1/quotationservices/qheaderget/$id',
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

  static dynamic createQheaderWithQDetails(
    token,
    companyId,
    quotationData,
  ) async {
    print(int.tryParse(
      quotationData["QAnnualIncome"],
    ));
    try {
      final response = await dio.post(
        '${AppUtils.appUrl}/api/v1/quotationservices/qheaderandbenefitcreate',
        data: {
          "CompanyID": companyId,
          "QuoteDate": quotationData["QuoteDate"],
          //"QuoteDate": "20230101",
          "QProduct": quotationData["QProduct"],
          "QOccGroup": quotationData["QOccGroup"],
          "QOccSect": quotationData["QOccSect"],
          "QOccupation": quotationData["QOccupation"],
          "QNri": quotationData["QNri"],
          "QDeclaration": quotationData["QDeclaration"],
          "ClientID": int.tryParse(
            quotationData["ClientID"],
          ),
          "AddressID": int.tryParse(
            quotationData["AddressID"],
          ),
          "QAnnualIncome": int.tryParse(
            quotationData["QAnnualIncome"],
          ),
          "AgencyID": int.tryParse(
            quotationData["AgencyID"],
          ),
          "QDetails": quotationData["QDetails"]
          //"QDetails": quotationData["QDetails"]
        },
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );
      print(response);
      return response;
    } catch (err) {
      print(err);
      throw Exception(err);
    }
  }
}
