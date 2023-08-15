import 'package:dio/dio.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';

Dio dio = Dio();

class AgencyService {
  static dynamic getAllAgency(
      token, searchString, searchCriteria, pageNo, pageSize) async {
    try {
      final response = await dio.get(
        '${AppUtils.appUrl}/api/v1/pacificservices/agencies',
        queryParameters: {
          "searchString": searchString,
          "searchCriteria": searchCriteria,
          "pageSize": pageSize,
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
        '${AppUtils.appUrl}/api/v1/pacificservices/agencyget/$id',
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

  static dynamic createAgency(
    token,
    companyId,
    agencyData,
  ) async {
    try {
      final response = await dio.post(
        '${AppUtils.appUrl}/api/v1/pacificservices/agencycreate',
        data: {
          "CompanyID": companyId,
          "AgencyChannelSt": agencyData["AgencyChannelSt"],
          "Office": agencyData["Office"],
          "AgencySt": agencyData["AgencySt"],
          "LicenseNo": agencyData["LicenseNo"],
          "LicenseStartDate": agencyData["LicenseStartDate"],
          "LicenseEndDate": agencyData["LicenseEndDate"],
          "Startdate": agencyData["Startdate"],
          "EndDate": agencyData["EndDate"],
          "TerminationReason": agencyData["TerminationReason"],
          "Aadhar": agencyData["Aadhar"],
          "Pan": agencyData["Pan"],
          "ClientID": int.tryParse(agencyData["ClientID"]),
          "AddressID": int.tryParse(agencyData["AddressID"]),
          "BankID": int.tryParse(agencyData["BankID"]),
        },
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );
      print(response.data);
      return response.data;
    } catch (err) {
      print(err);
      throw Exception(err);
    }
  }
}
