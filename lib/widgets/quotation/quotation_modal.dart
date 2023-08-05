import 'package:flutter/material.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';
import 'package:quotation_flutter/widgets/quotation/qdetails_modal1.dart';
import 'package:quotation_flutter/widgets/quotation/qdetails_modal2.dart';
import 'package:quotation_flutter/widgets/quotation/qheader_modal.dart';

class QuotationModal extends StatefulWidget {
  const QuotationModal({super.key});

  @override
  State<QuotationModal> createState() => _QuotationModalState();
}

class _QuotationModalState extends State<QuotationModal> {
  var controller = PageController();
  Map<String, dynamic> qHeaderQDetails = {
    "QuoteDate": "",
    "QProduct": "END",
    "ClientID": 0,
    "QNri": "Y",
    "QOccGroup": "ABC",
    "QOccSect": "DD",
    "QOccupation": "Software Engineer",
    "QAnnualIncome": 0,
    "QDeclaration": "",
    "AddressID": 0,
    "AgencyID": 0,
    "QDetails": [
      {
        "QHeaderID": 0,
        "QCoverage": "",
        "QRiskCessTerm": 0,
        "QPremCessTerm": 0,
        "QBeneCessTerm": 0,
        "QSumAssured": 0,
        "QEmrRating": 0,
        "QAgeAdmitted": ""
      },
    ]
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Quotation Modal", isBack: true),
      body: PageView(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          QHeaderModal(
            qHeaderQDetails: qHeaderQDetails,
          ),
          QDetailsModal1(
            qDetails: qHeaderQDetails["QDetails"],
          ),
          QDetailsModal2(
            qDetails: qHeaderQDetails["QDetails"],
          )
        ],
      ),
    );
  }
}
