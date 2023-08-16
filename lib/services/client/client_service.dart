import 'package:dio/dio.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';

Dio dio = Dio();

class ClientService {
  // Get All Client
  static getAllClients(
      token, searchString, searchCriteria, pageNo, pageSize) async {
    try {
      final response = await dio.get(
        "${AppUtils.appUrl}/api/v1/basicservices/getallclient",
        queryParameters: {
          "searchString": searchString,
          "searchCriteria": searchCriteria,
          "pageSize": pageSize
        },
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );
      print(pageSize);
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

// Create Client With Address

  static dynamic createClientWithAddresses(
    token,
    companyId,
    clientData,
  ) async {
    try {
      final response = await dio.post(
        '${AppUtils.appUrl}/api/v1/basicservices/clientcreatewithaddress',
        data: {
          "CompanyID": companyId,
          "ClientShortName": clientData["ClientShortName"],
          //"QuoteDate": "20230101",
          "ClientLongName": clientData["ClientLongName"],
          "ClientSurName": clientData["ClientSurName"],
          "Gender": clientData["Gender"],
          "Salutation": clientData["Salutation"],
          "Language": clientData["Language"],
          "ClientDob": clientData["ClientDob"],
          "ClientEmail": clientData["ClientEmail"],
          "ClientMobile": clientData["ClientMobile"],
          "ClientStatus": clientData["ClientStatus"],
          "ClientType": clientData["ClientType"],
          "Addresses": clientData["Addresses"]
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

  static void softDeleteClient(token, id) async {
    try {
      await dio.delete(
        "${AppUtils.appUrl}/api/v1/basicservices/clientdelete/$id",
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );
    } catch (err) {
      throw Exception(err);
    }
  }
}
