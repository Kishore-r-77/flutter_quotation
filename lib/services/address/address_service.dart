import 'package:dio/dio.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';

Dio dio = Dio();

class AddressService {
  static dynamic getAllAddress(
      token, searchString, searchCriteria, pageNo, pageSize) async {
    try {
      final response = await dio.get(
        '${AppUtils.appUrl}/api/v1/basicservices/addresses',
        queryParameters: {
          "searchString": searchString,
          "searchCriteria": searchCriteria,
          "pageSize": pageSize
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
        '${AppUtils.appUrl}/api/v1/basicservices/addressget/$id',
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

  static dynamic createAddress(
    token,
    companyId,
    addressData,
  ) async {
    try {
      final response = await dio.post(
        '${AppUtils.appUrl}/api/v1/basicservices/addresscreate',
        data: {
          "CompanyID": companyId,
          "AddressLine1": addressData["AddressLine1"],
          "AddressLine2": addressData["AddressLine2"],
          "AddressLine3": addressData["AddressLine3"],
          "AddressLine4": addressData["AddressLine4"],
          "AddressLine5": addressData["AddressLine5"],
          "AddressType": addressData["AddressType"],
          "AddressPostCode": addressData["AddressPostCode"],
          "AddressState": addressData["AddressState"],
          "AddressCountry": addressData["AddressCountry"],
          "AddressStartDate": addressData["AddressStartDate"],
          "AddressEndDate": addressData["AddressEndDate"],
          "ClientID": int.tryParse(addressData["ClientID"])
        },
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );

      return response.data;
    } catch (err) {
      print(err);
      throw Exception(err);
    }
  }

  static void softDeleteAddress(token, id) async {
    try {
      await dio.delete(
        "${AppUtils.appUrl}/api/v1/basicservices/addressdelete/$id",
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );
    } catch (err) {
      throw Exception(err);
    }
  }
}
