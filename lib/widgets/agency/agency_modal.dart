import 'package:flutter/material.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customWidgets/custom_field.dart';

class AgencyModal extends StatelessWidget {
  const AgencyModal({super.key, required this.clientResponse});

  final Map<String, dynamic> clientResponse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
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
                value: clientResponse['AgencyChannelSt'],
                label: "Channel list"),
            const SizedBox(
              height: 20,
            ),
            CustomField(value: clientResponse['Office'], label: "Office"),
            const SizedBox(
              height: 20,
            ),
            CustomField(value: clientResponse['AgencySt'], label: "AgencySt"),
            const SizedBox(
              height: 20,
            ),
            CustomField(
                value: clientResponse['LicenseNo'], label: "License No"),
            const SizedBox(
              height: 20,
            ),
            CustomField(
                value: AppUtils.formatDate(clientResponse['LicenseStartDate']),
                label: "License StartDate"),
            const SizedBox(
              height: 20,
            ),
            CustomField(
                value: AppUtils.formatDate(clientResponse['LicenseEndDate']),
                label: "License EndDate"),
            const SizedBox(
              height: 20,
            ),
            CustomField(
                value: AppUtils.formatDate(clientResponse['Startdate']),
                label: "Start Date"),
            const SizedBox(
              height: 20,
            ),
            CustomField(
                value: AppUtils.formatDate(clientResponse['EndDate']),
                label: "End Date"),
            const SizedBox(
              height: 20,
            ),
            CustomField(
                value: clientResponse['TerminationReason'],
                label: "Termination Reason"),
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
