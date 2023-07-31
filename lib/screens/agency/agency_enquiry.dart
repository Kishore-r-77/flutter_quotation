import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/appUtils/app_utils.dart';
import '../../widgets/customAppbar/custom_appbar.dart';
import '../../widgets/customWidgets/custom_field.dart';

class AgencyEnquiry extends StatefulWidget {
  const AgencyEnquiry(
      {super.key, required this.agencyResponse, required this.authToken});

  final dynamic agencyResponse;
  final String? authToken;

  @override
  State<AgencyEnquiry> createState() => _AgencyEnquiryState();
}

class _AgencyEnquiryState extends State<AgencyEnquiry> {
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
                "Agency Enquiry",
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
                value: "${widget.agencyResponse['ID']}",
                label: "Agency ID",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.agencyResponse['AgencyChannelSt']}",
                label: "AgencyChannelSt",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.agencyResponse['Office']}",
                label: "Office",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.agencyResponse['AgencySt']}",
                label: "AgencySt",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.agencyResponse['LicenseNo']}",
                label: "LicenseNo",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.agencyResponse['TerminationReason']}",
                label: "Termination Reason",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: widget.agencyResponse['LicenseStartDate'] == ""
                    ? ""
                    : formatDate(widget.agencyResponse['LicenseStartDate']),
                label: "License Start Date",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: widget.agencyResponse['LicenseEndDate'] == ""
                    ? ""
                    : formatDate(widget.agencyResponse['LicenseEndDate']),
                label: "Licencse End Date",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
