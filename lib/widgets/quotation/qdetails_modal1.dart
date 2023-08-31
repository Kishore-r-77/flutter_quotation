import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/providers/quotationProvider/quotation_provider.dart';
import 'package:quotation_flutter/services/quotation/quotation_services.dart';

import '../../utils/appUtils/app_utils.dart';

class QDetailsModal1 extends ConsumerStatefulWidget {
  const QDetailsModal1({super.key, required this.loginResponse});

  final dynamic loginResponse;

  @override
  ConsumerState<QDetailsModal1> createState() => _QDetailsModal1State();
}

class _QDetailsModal1State extends ConsumerState<QDetailsModal1> {
  @override
  void initState() {
    super.initState();
    getQCover();
    getTerms();
  }

  List<dynamic> qCovers = [];
  List<dynamic> qTerms = [];
  String dropdownValue1 = 'END1';
  String dropdownValue2 = '5';

  Future<dynamic> getQCover() async {
    final response = await QuotationServices.Params(
        widget.loginResponse['authToken'],
        widget.loginResponse['companyId'],
        widget.loginResponse['languageId'],
        "Q0006");
    setState(() {
      qCovers = response["data"];
    });
  }

  Future<dynamic> getTerms() async {
    final response = await QuotationServices.TermParams(
        widget.loginResponse['authToken'],
        "Q0016",
        "20220101",
        dropdownValue1,
        widget.loginResponse['companyId'],
        "TermRange");
    setState(() {
      qTerms = response["ppt"];
    });
  }

  @override
  Widget build(BuildContext context) {
    double sumAssured = 100000;

    final Map<String, dynamic> qDetailModal1 =
        ref.watch(quotationProvider.notifier).modal1;

    List<dynamic> qDetails = ref.watch(quotationProvider)["QDetails"];
    bool isAdd = ref.watch(quotationProvider.notifier).isAdd;
    bool isRemove = ref.watch(quotationProvider.notifier).isRemove;
    final Map<String, dynamic> qHeaderQDetails = ref.watch(quotationProvider);
    final authToken =
        ref.watch(loginProvider.notifier).prefs?.getString("authToken");
    final companyId =
        ref.watch(loginProvider.notifier).prefs?.getInt("companyId");

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: ListView(
          children: [
            Center(
              child: Text(
                "QDetails 1/5",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StatefulBuilder(
              builder: (context, setDropdownState) => Flexible(
                child: DropdownButtonFormField<String>(
                  value: dropdownValue1,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  decoration: const InputDecoration(
                    labelText: "Coverage",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (selectedvalue) {
                    setDropdownState(() {
                      dropdownValue1 = selectedvalue!;
                      qDetailModal1.update(
                          "QCoverage", (val) => dropdownValue1);
                    });
                  },
                  items: qCovers
                      .map(
                        (values) => DropdownMenuItem(
                          value: "${values['item']}",
                          child: Text(
                            "${values['item']}",
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
              height: 20,
            ),
            StatefulBuilder(
              builder: (context, setDropdownState) => Flexible(
                child: DropdownButtonFormField<String>(
                  value: dropdownValue2,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Risk Cess Term"),
                  onChanged: (selectedvalue) {
                    setDropdownState(() {
                      dropdownValue2 = selectedvalue!;
                      qDetailModal1.update(
                          "QRiskCessTerm", (val) => dropdownValue2);
                    });
                  },
                  items: qTerms
                      .map(
                        (values) => DropdownMenuItem(
                          value: "${values}",
                          child: Text(
                            "${values}",
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
              height: 20,
            ),
            StatefulBuilder(
              builder: (context, setDropdownState) => Flexible(
                child: DropdownButtonFormField<String>(
                  value: dropdownValue2,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Premium Cess Term"),
                  onChanged: (selectedvalue) {
                    setDropdownState(() {
                      dropdownValue2 = selectedvalue!;
                      qDetailModal1.update(
                          "QPremCessTerm", (val) => dropdownValue2);
                    });
                  },
                  items: qTerms
                      .map(
                        (values) => DropdownMenuItem(
                          value: "${values}",
                          child: Text(
                            "${values}",
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
              height: 20,
            ),
            StatefulBuilder(
              builder: (context, setDropdownState) => Flexible(
                child: DropdownButtonFormField<String>(
                  value: dropdownValue2,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Benefit Cess Term"),
                  onChanged: (selectedvalue) {
                    setDropdownState(() {
                      dropdownValue2 = selectedvalue!;
                      qDetailModal1.update(
                          "QBeneCessTerm", (val) => dropdownValue2);
                    });
                  },
                  items: qTerms
                      .map(
                        (values) => DropdownMenuItem(
                          value: "${values}",
                          child: Text(
                            "${values}",
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
              height: 20,
            ),
            StatefulBuilder(
              builder: (context, setSliderState) => Row(
                children: [
                  Text(
                    "Sum Assured: ${AppUtils.formatCurrency().format(
                      sumAssured,
                    )}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Flexible(
                    child: Slider.adaptive(
                      value: sumAssured,
                      min: 100000,
                      max: 1000000,
                      divisions: 700000, // Adjust divisions to match the range
                      label: AppUtils.formatCurrency().format(
                        sumAssured,
                      ), // Removed the toStringAsFixed(2) method here
                      onChanged: (newValue) => setSliderState(
                        () {
                          sumAssured = newValue;
                          qDetailModal1.update(
                            "QSumAssured",
                            (val) => newValue.toInt().toString(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: TextFormField(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                initialValue: qDetailModal1["QEmrRating"],
                onChanged: (value) {
                  qDetailModal1.update("QEmrRating", (val) => value);
                },
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(
                      "EmrRating",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: TextFormField(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                initialValue: qDetailModal1["QAgeAdmitted"],
                onChanged: (value) {
                  qDetailModal1.update("QAgeAdmitted", (val) => value);
                },
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(
                      "AgeAdmitted",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StatefulBuilder(
              builder: (context, setState) => Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAdd == false
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                      foregroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                    ),
                    onPressed: isAdd == true
                        ? null
                        : () {
                            qDetails.add({
                              "QCoverage": qDetailModal1["QCoverage"],
                              "QAgeAdmitted": qDetailModal1["QAgeAdmitted"],
                              "QRiskCessTerm": int.tryParse(
                                qDetailModal1["QRiskCessTerm"],
                              ),
                              "QPremCessTerm": int.tryParse(
                                qDetailModal1["QPremCessTerm"],
                              ),
                              "QBeneCessTerm": int.tryParse(
                                qDetailModal1["QBeneCessTerm"],
                              ),
                              "QEmrRating": int.tryParse(
                                qDetailModal1["QEmrRating"],
                              ),
                              "QSumAssured": int.tryParse(
                                qDetailModal1["QSumAssured"],
                              ),
                            });
                            setState(() {
                              isAdd = true;
                              isRemove = false;
                            });
                          },
                    child: const Text("Add"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isRemove == false
                          ? Theme.of(context).colorScheme.error
                          : Colors.grey,
                      foregroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                    ),
                    onPressed: isRemove == true
                        ? null
                        : () {
                            qDetails.removeLast();
                            setState(() {
                              isAdd = false;
                              isRemove = true;
                            });
                          },
                    child: const Text("Remove"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
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
                  authToken,
                  companyId,
                  qHeaderQDetails,
                );
                if (quotationStatusCode.statusCode == 200) {
                  Navigator.pop(context);
                  qDetailModal1.update("QCoverage", (value) => "");
                  qDetailModal1.update("QRiskCessTerm", (value) => "");
                  qDetailModal1.update("QPremCessTerm", (value) => "");
                  qDetailModal1.update("QBeneCessTerm", (value) => "");
                  qDetailModal1.update("QSumAssured", (value) => "");
                  qDetailModal1.update("QEmrRating", (value) => "");
                  qDetailModal1.update("QAgeAdmitted", (value) => "");
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
