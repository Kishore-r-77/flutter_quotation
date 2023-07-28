import 'package:flutter/material.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customWidgets/custom_field.dart';

class ClientModal extends StatelessWidget {
  const ClientModal({super.key, required this.clientResponse});

  final Map<String, dynamic> clientResponse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "Client Enquiry",
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
                    value: clientResponse['ClientShortName'],
                    label: "Client Short Name"),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                    value: clientResponse['ClientLongName'],
                    label: "Client Long Name"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomField(
                    value: clientResponse['ClientLongName'],
                    label: "Client Long Name"),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                    value: AppUtils.formatDate(clientResponse['ClientDob']),
                    label: "Client Dob"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomField(
                    value: clientResponse['ClientSurName'],
                    label: "Client SurName"),
                const SizedBox(
                  width: 20,
                ),
                CustomField(value: clientResponse['Gender'], label: "Gender"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomField(
                    value: clientResponse['ClientEmail'], label: "Email"),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                    value: clientResponse['ClientMobile'], label: "Mobile"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomField(
                    value: clientResponse['ClientStatus'], label: "Status"),
                const SizedBox(
                  width: 20,
                ),
                CustomField(value: clientResponse['ClientType'], label: "Type"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary),
                onPressed: () => Navigator.pop(context),
                child: const Text("Back"))
          ],
        ),
      ),
    );
  }
}
