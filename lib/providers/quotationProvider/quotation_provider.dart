import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuotationNotifier extends StateNotifier<Map<String, dynamic>> {
  QuotationNotifier()
      : super({
          "QuoteDate": "",
          "QProduct": "",
          "ClientID": "",
          "QNri": "",
          "QOccGroup": "",
          "QOccSect": "",
          "QOccupation": "",
          "QAnnualIncome": "",
          "QDeclaration": "",
          "AddressID": "",
          "AgencyID": "",
          "QDetails": []
        });
  bool isAdd = false;
  bool isRemove = false;

  Map<String, dynamic> modal1 = {
    "QCoverage": "",
    "QRiskCessTerm": "",
    "QPremCessTerm": "",
    "QBeneCessTerm": "",
    "QSumAssured": "",
    "QEmrRating": "",
    "QAgeAdmitted": ""
  };
  Map<String, dynamic> modal2 = {
    "QCoverage": "",
    "QRiskCessTerm": "",
    "QPremCessTerm": "",
    "QBeneCessTerm": "",
    "QSumAssured": "",
    "QEmrRating": "",
    "QAgeAdmitted": ""
  };
  Map<String, dynamic> modal3 = {
    "QCoverage": "",
    "QRiskCessTerm": "",
    "QPremCessTerm": "",
    "QBeneCessTerm": "",
    "QSumAssured": "",
    "QEmrRating": "",
    "QAgeAdmitted": ""
  };
  Map<String, dynamic> modal4 = {
    "QCoverage": "",
    "QRiskCessTerm": "",
    "QPremCessTerm": "",
    "QBeneCessTerm": "",
    "QSumAssured": "",
    "QEmrRating": "",
    "QAgeAdmitted": ""
  };
  Map<String, dynamic> modal5 = {
    "QCoverage": "",
    "QRiskCessTerm": "",
    "QPremCessTerm": "",
    "QBeneCessTerm": "",
    "QSumAssured": "",
    "QEmrRating": "",
    "QAgeAdmitted": ""
  };
}

final quotationProvider =
    StateNotifierProvider<QuotationNotifier, Map<String, dynamic>>(
        (ref) => QuotationNotifier());
