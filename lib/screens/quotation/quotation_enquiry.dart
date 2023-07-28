import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quotation_flutter/services/client/client_service.dart';
import 'package:quotation_flutter/widgets/client/client_modal.dart';
import 'package:quotation_flutter/widgets/customWidgets/custom_lookup_field.dart';

import '../../utils/appUtils/app_utils.dart';
import '../../widgets/customAppbar/custom_appbar.dart';
import '../../widgets/customWidgets/custom_field.dart';

class QuotationEnquiry extends StatefulWidget {
  const QuotationEnquiry(
      {super.key, required this.quotationResponse, required this.authToken});

  final dynamic quotationResponse;
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
      body: Padding(
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
                CustomField(
                  value: "${widget.quotationResponse['ID']}",
                  label: "Quotation ID",
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                  value: "${widget.quotationResponse['QProduct']}",
                  label: "Product",
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                  value: formatDate(widget.quotationResponse['QuoteDate']),
                  label: "Quote Date",
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomField(
                  value: "${widget.quotationResponse['QFirstName']}",
                  label: "First Name",
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                  value: "${widget.quotationResponse['QMidName']}",
                  label: "Mid Name",
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                  value: "${widget.quotationResponse['QLastName']}",
                  label: "Last Name",
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomField(
                  value: formatDate(widget.quotationResponse['QDob']),
                  label: "DOB",
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                  value: "${widget.quotationResponse['QGender']}",
                  label: "Gender",
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                  value: "${widget.quotationResponse['QEmail']}",
                  label: "Email",
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomField(
                  value: "${widget.quotationResponse['QNri']}",
                  label: "Nri",
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                  value: "${widget.quotationResponse['QMobile']}",
                  label: "Mobile",
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                  value: "${widget.quotationResponse['QOccGroup']}",
                  label: "Occ Group",
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomField(
                  value: "${widget.quotationResponse['QOccupation']}",
                  label: "Occupation",
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                  value: "${widget.quotationResponse['QAnnualIncome']}",
                  label: "Anual Income",
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                  value: "${widget.quotationResponse['QDeclaration']}",
                  label: "Decleration",
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomLookupField(
                  value: "${widget.quotationResponse['ClientID']}",
                  label: "Client ID",
                  icon: const Icon(Icons.info),
                  lookupFunction: () {
                    ClientService.getClient(widget.authToken,
                            widget.quotationResponse['ClientID'])
                        .then((clientResp) {
                      return showModalBottomSheet(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        useSafeArea: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) =>
                            ClientModal(clientResponse: clientResp["Client"]),
                      );
                    }).catchErr((err) {
                      return err.message;
                    });
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomLookupField(
                  value: "${widget.quotationResponse['AddressID']}",
                  label: "Address ID",
                  icon: const Icon(Icons.info),
                  lookupFunction: () {},
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomLookupField(
                  value: "${widget.quotationResponse['AgencyID']}",
                  label: "Agency ID",
                  icon: const Icon(Icons.info),
                  lookupFunction: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
