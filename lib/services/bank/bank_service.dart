import 'package:dio/dio.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';

Dio dio = Dio();

class BankService {
  static dynamic getAllBank(
      token, searchString, searchCriteria, pageNo, pageSize) async {
    try {
      final response = await dio.get(
        '${AppUtils.appUrl}/api/v1/basicservices/banks',
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
        throw Exception('Failed to get Bank data');
      }
    } catch (err) {
      throw Exception('An error occurred: $err');
    }
  }

  static dynamic getBank(token, id) async {
    try {
      final response = await dio.get(
        '${AppUtils.appUrl}/api/v1/basicservices/bankget/$id',
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get Bank data');
      }
    } catch (err) {
      throw Exception('An error occurred: $err');
    }
  }

  static dynamic createBank(
    token,
    companyId,
    bankData,
  ) async {
    try {
      final response = await dio.post(
        'http://localhost:3000/api/v1/basicservices/bankcreate',
        data: {
          "CompanyID": companyId,
          "BankCode": bankData["BankCode"],
          "BankAccountNo": bankData["BankAccountNo"],
          "StartDate": bankData["StartDate"],
          "EndDate": bankData["EndDate"],
          "BankType": bankData["BankType"],
          "BankAccountStatus": bankData["BankAccountStatus"],
          "ClientID": int.tryParse(bankData["ClientID"])
        },
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );

      return response.data;
    } catch (err) {
      print(err);
      throw Exception(err);
    }
  }

  static void softDeleteBank(token, id) async {
    try {
      await dio.delete(
        "${AppUtils.appUrl}/api/v1/basicservices/bankdelete/$id",
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );
    } catch (err) {
      throw Exception(err);
    }
  }

  static dynamic getBankTypes(token, companyid, languageid, name) async {
    try {
      final response = await dio.get(
        '${AppUtils.appUrl}/api/v1/basicservices/paramItems?companyId=$companyid&name=$name&languageId=$languageid',
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get Bank Type');
      }
    } catch (err) {
      throw Exception('An error occurred: $err');
    }
  }

  static dynamic getAccountTypes(token, companyid, languageid, name) async {
    try {
      final response = await dio.get(
        '${AppUtils.appUrl}/api/v1/basicservices/paramItems?companyId=$companyid&name=$name&languageId=$languageid',
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get Account Type');
      }
    } catch (err) {
      throw Exception('An error occurred: $err');
    }
  }

  static dynamic getBankGroups(token, companyid, languageid, name, item) async {
    try {
      final response = await dio.get(
        '${AppUtils.appUrl}/api/v1/basicservices/paramItem?companyId=1&name=P0050&languageId=1&item=BANKGROUP',
        options: Options(headers: {"Cookie": "Authorization=$token"}),
      );
      if (response.statusCode == 200) {
        print(response.data);
        return response.data;
      } else {
        throw Exception('Failed to get Account Type');
      }
    } catch (err) {
      throw Exception('An error occurred: $err');
    }
  }
}
