import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/appUtils/app_utils.dart';
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
            // Row(
            //   children: [
            //     CustomLookupField(
            //       value: "${widget.clientResponse['ClientID']}",
            //       label: "Client ID",
            //       icon: Icon(Icons.info,
            //           color: Theme.of(context).colorScheme.primary),
            //       lookupFunction: () {
            //         ClientService.getClient(widget.authToken,
            //                 widget.clientResponse['ClientID'])
            //             .then((clientResp) {
            //           return showModalBottomSheet(
            //             backgroundColor:
            //                 Theme.of(context).colorScheme.surface,
            //             useSafeArea: true,
            //             isScrollControlled: true,
            //             context: context,
            //             builder: (ctx) =>
            //                 ClientModal(clientResponse: clientResp["Client"]),
            //           );
            //         });
            //       },
            //     ),
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     CustomLookupField(
            //       value: "${widget.clientResponse['AddressID']}",
            //       label: "Address ID",
            //       icon: Icon(Icons.info,
            //           color: Theme.of(context).colorScheme.primary),
            //       lookupFunction: () {
            //         AddressService.getAddress(widget.authToken,
            //                 widget.clientResponse['AddressID'])
            //             .then((addressResp) {
            //           return showModalBottomSheet(
            //             backgroundColor:
            //                 Theme.of(context).colorScheme.surface,
            //             useSafeArea: true,
            //             isScrollControlled: true,
            //             context: context,
            //             builder: (ctx) => AddressModal(
            //                 addressResponse: addressResp["Address"]),
            //           );
            //         });
            //       },
            //     ),
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     CustomLookupField(
            //       value: "${widget.clientResponse['AgencyID']}",
            //       label: "Agency ID",
            //       icon: Icon(Icons.info,
            //           color: Theme.of(context).colorScheme.primary),
            //       lookupFunction: () async {
            //         final agencyResponse = await AgencyService.getAddress(
            //             widget.authToken, widget.clientResponse['AgencyID']);

            //         setState(() {
            //           showModalBottomSheet(
            //             backgroundColor:
            //                 Theme.of(context).colorScheme.surface,
            //             useSafeArea: true,
            //             isScrollControlled: true,
            //             context: context,
            //             builder: (ctx) => AgencyModal(
            //               clientResponse: agencyResponse["Agency"],
            //             ),
            //           );
            //         });
            //       },
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
