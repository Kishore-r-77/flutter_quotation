import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/appUtils/app_utils.dart';
import '../../widgets/customAppbar/custom_appbar.dart';
import '../../widgets/quotation/quotation_field.dart';

class QuotationEnquiry extends StatefulWidget {
  QuotationEnquiry(
      {super.key, required this.quotationResponse, required this.authToken});

  dynamic quotationResponse;
  final String? authToken;

  @override
  State<QuotationEnquiry> createState() => _QuotationEnquiryState();
}

class _QuotationEnquiryState extends State<QuotationEnquiry> {
  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppUtils.quotationTitle),
      body: Card(
        // shadowColor: const Color.fromARGB(255, 184, 210, 237),

        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Quotation Enquiry",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize:
                        Theme.of(context).textTheme.titleLarge?.fontSize ?? 0.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  QuotationField(
                    value: "${widget.quotationResponse['ID']}",
                    label: "Quotation ID",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  QuotationField(
                    value: "${widget.quotationResponse['ClientID']}",
                    label: "Client ID",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  QuotationField(
                    value: "${widget.quotationResponse['QProduct']}",
                    label: "QProduct",
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  QuotationField(
                    value: formatDate(widget.quotationResponse['QuoteDate']),
                    label: "Quote Date",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  QuotationField(
                    value: "${widget.quotationResponse['QFirstName']}",
                    label: "QFirst Name",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  QuotationField(
                    value: "${widget.quotationResponse['QMidName']}",
                    label: "QMid Name",
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  QuotationField(
                    value: "${widget.quotationResponse['QLastName']}",
                    label: "QLast Name",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  QuotationField(
                    value: formatDate(widget.quotationResponse['QDob']),
                    label: "QDOB",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  QuotationField(
                    value: "${widget.quotationResponse['QGender']}",
                    label: "QGender",
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  QuotationField(
                    value: "${widget.quotationResponse['QEmail']}",
                    label: "QEmail",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  QuotationField(
                    value: "${widget.quotationResponse['QNri']}",
                    label: "QNri",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  QuotationField(
                    value: "${widget.quotationResponse['QMobile']}",
                    label: "QMobile",
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  QuotationField(
                    value: "${widget.quotationResponse['QOccGroup']}",
                    label: "QOcc Group",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  QuotationField(
                    value: "${widget.quotationResponse['QOccupation']}",
                    label: "QOccupation",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  QuotationField(
                    value: "${widget.quotationResponse['QAnnualIncome']}",
                    label: "QAnual Income",
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  QuotationField(
                    value: "${widget.quotationResponse['QDeclaration']}",
                    label: "QDecleration",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  QuotationField(
                    value: "${widget.quotationResponse['AddressID']}",
                    label: "Address ID",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  QuotationField(
                    value: "${widget.quotationResponse['AgencyID']}",
                    label: "Agency ID",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
