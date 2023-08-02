import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/appUtils/app_utils.dart';
import '../../widgets/customAppbar/custom_appbar.dart';
import '../../widgets/customWidgets/custom_field.dart';

class BankEnquiry extends StatefulWidget {
  const BankEnquiry(
      {super.key, required this.bankResponse, required this.authToken});

  final dynamic bankResponse;
  final String? authToken;

  @override
  State<BankEnquiry> createState() => _BankEnquiryState();
}

class _BankEnquiryState extends State<BankEnquiry> {
  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppUtils.quotationTitle, isBack: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flexible(
          fit: FlexFit.loose,
          child: ListView(
            children: [
              Text(
                "Bank Enquiry",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize:
                        Theme.of(context).textTheme.titleLarge?.fontSize ?? 0.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.bankResponse['ID']}",
                label: "Bank ID",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.bankResponse['BankCode']}",
                label: "Bank Code",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.bankResponse['BankAccountNo']}",
                label: "Bank Account No",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: formatDate(widget.bankResponse['StartDate']),
                label: "Start Date",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: formatDate(widget.bankResponse['EndDate']),
                label: "End Date",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.bankResponse['BankType']}",
                label: "Bank Type",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.bankResponse['BankAccountStatus']}",
                label: "Bank Account Status",
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
