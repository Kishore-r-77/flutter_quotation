import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quotation_flutter/services/address/address_service.dart';
import 'package:quotation_flutter/services/agency/agency_service.dart';
import 'package:quotation_flutter/services/client/client_service.dart';
import 'package:quotation_flutter/widgets/address/address_modal.dart';
import 'package:quotation_flutter/widgets/agency/agency_modal.dart';
import 'package:quotation_flutter/widgets/client/client_modal.dart';
import 'package:quotation_flutter/widgets/customWidgets/custom_lookup_field.dart';

import '../../utils/appUtils/app_utils.dart';
import '../../widgets/customAppbar/custom_appbar.dart';
import '../../widgets/customWidgets/custom_field.dart';

class AddressEnquiry extends StatefulWidget {
  const AddressEnquiry(
      {super.key, required this.addressResponse, required this.authToken});

  final dynamic addressResponse;
  final String? authToken;

  @override
  State<AddressEnquiry> createState() => _AddressEnquiryState();
}

class _AddressEnquiryState extends State<AddressEnquiry> {
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
                "Address Enquiry",
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
                value: "${widget.addressResponse['ID']}",
                label: "Address ID",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.addressResponse['AddressType']}",
                label: "Address Type",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.addressResponse['AddressLine1']}",
                label: "Address Line 1",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.addressResponse['AddressLine2']}",
                label: "Address Line 2",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.addressResponse['AddressPostCode']}",
                label: "Post Code",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.addressResponse['AddressState']}",
                label: "State",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: "${widget.addressResponse['AddressCountry']}",
                label: "Country",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: widget.addressResponse['AddressStartDate'] == ""
                    ? ""
                    : formatDate(widget.addressResponse['AddressStartDate']),
                label: "Address Start Date",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                value: widget.addressResponse['AddressEndDate'] == ""
                    ? ""
                    : formatDate(widget.addressResponse['AddressEndDate']),
                label: "Address End Date",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
