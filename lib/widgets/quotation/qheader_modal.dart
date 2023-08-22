import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/providers/quotationProvider/quotation_provider.dart';
import 'package:quotation_flutter/screens/address/address.dart';
import 'package:quotation_flutter/screens/agency/agency.dart';
import 'package:quotation_flutter/screens/client/client.dart';
import 'package:quotation_flutter/services/quotation/quotation_services.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';

class QHeaderModal extends ConsumerStatefulWidget {
  const QHeaderModal({
    super.key,
    required this.loginResponse,
  });
  final dynamic loginResponse;

  @override
  ConsumerState<QHeaderModal> createState() => _QHeaderModalState();
}

class _QHeaderModalState extends ConsumerState<QHeaderModal> {
  @override
  void initState() {
    super.initState();
    getQNri();
    getQccg();
    getQProduct();
    getQccs();
  }

  List<dynamic> qNri = [];
  List<dynamic> qCcg = [];
  List<dynamic> qProduct = [];
  List<dynamic> qCcs = [];

  String dropdownValue1 = 'N';
  String dropdownValue2 = 'ACC';
  String dropdownValue3 = 'AEN';
  String dropdownValue4 = 'CHEM';

  Future<dynamic> getQNri() async {
    final response = await QuotationServices.Params(
        widget.loginResponse['authToken'],
        widget.loginResponse['companyId'],
        widget.loginResponse['languageId'],
        "P0046");
    setState(() {
      qNri = response["data"];
    });
  }

  Future<dynamic> getQccg() async {
    final response = await QuotationServices.Params(
        widget.loginResponse['authToken'],
        widget.loginResponse['companyId'],
        widget.loginResponse['languageId'],
        "Q0007");
    setState(() {
      qCcg = response["data"];
    });
  }

  Future<dynamic> getQProduct() async {
    final response = await QuotationServices.Params(
        widget.loginResponse['authToken'],
        widget.loginResponse['companyId'],
        widget.loginResponse['languageId'],
        "Q0005");
    setState(() {
      qProduct = response["data"];
    });
  }

  Future<dynamic> getQccs() async {
    final response = await QuotationServices.Params(
        widget.loginResponse['authToken'],
        widget.loginResponse['companyId'],
        widget.loginResponse['languageId'],
        "Q0008");
    setState(() {
      qCcs = response["data"];
    });
  }

  @override
  Widget build(BuildContext context) {
    double annualIncome = 300000;

    TextEditingController quoteDate =
        ref.watch(quotationProvider.notifier).quoteDate;
    final TextEditingController addressIdController =
        ref.watch(quotationProvider.notifier).addressIdController;
    final TextEditingController agencyIdController =
        ref.watch(quotationProvider.notifier).agencyIdController;

    final TextEditingController clientIdController =
        ref.watch(quotationProvider.notifier).clientIdController;

    final Map<String, dynamic> qHeaderQDetails = ref.watch(quotationProvider);
    final authToken =
        ref.watch(loginProvider.notifier).prefs?.getString("authToken");
    final companyId =
        ref.watch(loginProvider.notifier).prefs?.getInt("companyId");

    print(qHeaderQDetails["QAnnualIncome"]);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: ListView(
          children: [
            Center(
              child: Text(
                "QHeader",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    controller:
                        clientIdController, // Use the TextEditingController
                    onTap: () async {
                      final clientId = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => ClientScreen(
                            isLookUp: true,
                            loginResponse: ref.watch(loginProvider),
                          ),
                        ),
                      );

                      clientIdController.text = clientId ?? 0;
                      qHeaderQDetails.update(
                        "ClientID",
                        (value) => clientIdController.text,
                      );
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      label: Text("Client Id"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    controller:
                        agencyIdController, // Use the TextEditingController
                    onTap: () async {
                      final agencyId = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => AgencyScreen(
                            isLookUp: true,
                            loginResponse: ref.watch(loginProvider),
                          ),
                        ),
                      );

                      agencyIdController.text = agencyId ?? 0;
                      qHeaderQDetails.update(
                        "AgencyID",
                        (value) => agencyIdController.text,
                      );
                    },
                    // onChanged: (value) {

                    // },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      label: Text("AgencyID Id"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    controller:
                        addressIdController, // Use the TextEditingController
                    onTap: () async {
                      final addressId = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => AddressScreen(
                            isLookUp: true,
                            loginResponse: ref.watch(loginProvider),
                          ),
                        ),
                      );

                      addressIdController.text = addressId ?? 0;
                      qHeaderQDetails.update(
                        "AddressID",
                        (value) => addressIdController.text,
                      );
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      label: Text("Address Id"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                StatefulBuilder(
                  builder: (context, setDropdownState) => Flexible(
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue1,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      decoration:
                          const InputDecoration(labelText: "NRI status"),
                      onChanged: (selectedvalue) {
                        setDropdownState(() {
                          dropdownValue1 = selectedvalue!;
                          qHeaderQDetails.update(
                              "QNri", (val) => dropdownValue1);
                        });
                      },
                      items: qNri
                          .map(
                            (values) => DropdownMenuItem(
                              value: "${values['item']}",
                              child: Text(
                                "${values['longdesc']}",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                StatefulBuilder(
                  builder: (context, setDropdownState) => Flexible(
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue2,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      decoration:
                          const InputDecoration(labelText: "Occupation Group"),
                      onChanged: (selectedvalue) {
                        setDropdownState(() {
                          dropdownValue2 = selectedvalue!;
                          qHeaderQDetails.update(
                              "QOccGroup", (val) => dropdownValue2);
                        });
                      },
                      items: qCcg
                          .map(
                            (values) => DropdownMenuItem(
                              value: "${values['item']}",
                              child: Text(
                                "${values['longdesc']}",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    controller: quoteDate,
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now());
                      if (pickeddate != null) {
                        setState(() {
                          quoteDate.text =
                              DateFormat('dd/MM/yyyy').format(pickeddate);
                          qHeaderQDetails.update(
                              "QuoteDate",
                              (val) =>
                                  DateFormat('yyyyMMdd').format(pickeddate));
                        });
                      }
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Quote Date",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                StatefulBuilder(
                  builder: (context, setDropdownState) => Flexible(
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue3,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      decoration: const InputDecoration(labelText: "Product"),
                      onChanged: (selectedvalue) {
                        setDropdownState(() {
                          dropdownValue3 = selectedvalue!;
                          qHeaderQDetails.update(
                              "QProduct", (val) => dropdownValue3);
                        });
                      },
                      items: qProduct
                          .map(
                            (values) => DropdownMenuItem(
                              value: "${values['item']}",
                              child: Text(
                                "${values['shortdesc']}",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    initialValue: qHeaderQDetails["QOccupation"],
                    onChanged: (value) {
                      qHeaderQDetails.update("QOccupation", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Occupation",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                StatefulBuilder(
                  builder: (context, setDropdownState) => Flexible(
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue4,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      decoration:
                          const InputDecoration(labelText: "Occupation Sector"),
                      onChanged: (selectedvalue) {
                        setDropdownState(() {
                          dropdownValue4 = selectedvalue!;
                          qHeaderQDetails.update(
                              "QOccSect", (val) => dropdownValue4);
                        });
                      },
                      items: qCcs
                          .map(
                            (values) => DropdownMenuItem(
                              value: "${values['item']}",
                              child: Text(
                                "${values['longdesc']}",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            StatefulBuilder(
              builder: (context, setSliderState) => Row(
                children: [
                  Text(
                    "Annual Income: ${AppUtils.formatCurrency().format(
                      annualIncome,
                    )}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Flexible(
                    child: Slider.adaptive(
                      value: annualIncome,
                      min: 300000,
                      max: 1000000,
                      divisions: 700000, // Adjust divisions to match the range
                      label: AppUtils.formatCurrency().format(
                        annualIncome,
                      ), // Removed the toStringAsFixed(2) method here
                      onChanged: (newValue) => setSliderState(
                        () {
                          annualIncome = newValue;
                          qHeaderQDetails.update(
                            "QAnnualIncome",
                            (val) => newValue.toString(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Icon(
              Icons.swipe,
              color: Theme.of(context).colorScheme.primary,
            ),
            Center(
              child: Text(
                "Swipe Left to Add QDetails",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Center(
              child: Text(
                "Or",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final quotationStatusCode =
                    await QuotationServices.createQheaderWithQDetails(
                        authToken, companyId, qHeaderQDetails);
                if (quotationStatusCode == 200) {
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
              ),
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
