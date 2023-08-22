import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/customAppbar/custom_appbar.dart';
import '../../widgets/customWidgets/custom_field.dart';

class ClientEnquiry extends StatefulWidget {
  const ClientEnquiry(
      {super.key, required this.clientResponse, required this.authToken});

  final dynamic clientResponse;
  final String? authToken;

  @override
  State<ClientEnquiry> createState() => _ClientEnquiryState();
}

class _ClientEnquiryState extends State<ClientEnquiry> {
  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Client Enquiry", isBack: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(
              "Client Enquiry",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize:
                    Theme.of(context).textTheme.titleLarge?.fontSize ?? 0.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomField(
              value: "${widget.clientResponse['ID']}",
              label: "Client ID",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomField(
              value: "${widget.clientResponse['ClientShortName']}",
              label: "Short Name",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomField(
              value: "${widget.clientResponse['ClientLongName']}",
              label: "Long Name",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomField(
              value: "${widget.clientResponse['Gender']}",
              label: "Gender",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomField(
              value: formatDate(widget.clientResponse['ClientDob']),
              label: "DOB",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomField(
              value: "${widget.clientResponse['ClientEmail']}",
              label: "Email",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomField(
              value: "${widget.clientResponse['ClientMobile']}",
              label: "Mobile",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomField(
              value: "${widget.clientResponse['ClientStatus']}",
              label: "Status",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomField(
              value: "${widget.clientResponse['ClientType']}",
              label: "Client Type",
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
