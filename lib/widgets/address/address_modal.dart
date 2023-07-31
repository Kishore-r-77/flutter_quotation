import 'package:flutter/material.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customWidgets/custom_field.dart';

class AddressModal extends StatelessWidget {
  const AddressModal({super.key, required this.addressResponse});

  final Map<String, dynamic> addressResponse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
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
            Row(
              children: [
                CustomField(
                    value: addressResponse['AddressType'],
                    label: "Address Type"),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                    value: addressResponse['AddressLine1'], label: "Line 1"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomField(
                    value: addressResponse['AddressLine2'], label: "Line 2"),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                    value: addressResponse['AddressLine3'], label: "Line 3"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomField(
                    value: addressResponse['AddressLine4'], label: "Line 4"),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                    value: addressResponse['AddressPostCode'],
                    label: "Postal Code"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomField(
                    value: addressResponse['AddressState'], label: "State"),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                    value: addressResponse['AddressCountry'], label: "Country"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomField(
                    value: AppUtils.formatDate(
                        addressResponse['AddressStartDate']),
                    label: "Start Date"),
                const SizedBox(
                  width: 20,
                ),
                CustomField(
                    value:
                        AppUtils.formatDate(addressResponse['AddressEndDate']),
                    label: "End Date"),
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
