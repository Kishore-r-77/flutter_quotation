import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/providers/quotationProvider/quotation_provider.dart';
import 'package:quotation_flutter/services/quotation/quotation_services.dart';

class QDetailsModal2 extends ConsumerWidget {
  const QDetailsModal2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, dynamic> qDetailModal2 =
        ref.watch(quotationProvider.notifier).modal2;

    List<dynamic> qDetails = ref.watch(quotationProvider)["QDetails"];
    //qDetails.add(qDetailModal2);
    bool isAdd = ref.watch(quotationProvider.notifier).isAdd;
    bool isRemove = ref.watch(quotationProvider.notifier).isRemove;
    final Map<String, dynamic> qHeaderQDetails = ref.watch(quotationProvider);
    final authToken =
        ref.watch(loginProvider.notifier).prefs?.getString("authToken");
    final companyId =
        ref.watch(loginProvider.notifier).prefs?.getInt("companyId");
    print(isAdd);
    print(isRemove);
    print(isAdd);
    print(isRemove);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: ListView(
          children: [
            Center(
              child: Text(
                "QDetails 2/5",
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
                    initialValue: qDetailModal2["QCoverage"],
                    onChanged: (value) {
                      qDetailModal2.update("QCoverage", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "QCoverage",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
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
                    initialValue: qDetailModal2["QRiskCessTerm"],
                    onChanged: (value) {
                      qDetailModal2.update("QRiskCessTerm", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "QRiskCessTerm",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
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
                    initialValue: qDetailModal2["QPremCessTerm"],
                    onChanged: (value) {
                      qDetailModal2.update("QPremCessTerm", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "QPremCessTerm",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
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
                    initialValue: qDetailModal2["QBeneCessTerm"],
                    onChanged: (value) {
                      qDetailModal2.update("QBeneCessTerm", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "QBeneCessTerm",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
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
                    initialValue: qDetailModal2["QSumAssured"],
                    onChanged: (value) {
                      qDetailModal2.update("QSumAssured", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "QSumAssured",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
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
                    initialValue: qDetailModal2["QEmrRating"],
                    onChanged: (value) {
                      qDetailModal2.update("QEmrRating", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "QEmrRating",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: TextFormField(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                initialValue: qDetailModal2["QAgeAdmitted"],
                onChanged: (value) {
                  qDetailModal2.update("QAgeAdmitted", (val) => value);
                },
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text(
                      "QAgeAdmitted",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StatefulBuilder(
              builder: (context, setState) => Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAdd == false && isRemove == true
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                      foregroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                    ),
                    onPressed: isAdd == true
                        ? null
                        : () {
                            qDetails.add({
                              "QCoverage": qDetailModal2["QCoverage"],
                              "QAgeAdmitted": qDetailModal2["QAgeAdmitted"],
                              "QRiskCessTerm": int.tryParse(
                                qDetailModal2["QRiskCessTerm"],
                              ),
                              "QPremCessTerm": int.tryParse(
                                qDetailModal2["QPremCessTerm"],
                              ),
                              "QBeneCessTerm": int.tryParse(
                                qDetailModal2["QBeneCessTerm"],
                              ),
                              "QEmrRating": int.tryParse(
                                qDetailModal2["QEmrRating"],
                              ),
                              "QSumAssured": int.tryParse(
                                qDetailModal2["QSumAssured"],
                              ),
                            });
                          },
                    child: const Text("Add"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAdd == true && isRemove == false
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
                            print(isRemove);
                          },
                    child: const Text("Remove"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
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
                print("Clicked");
                print(qHeaderQDetails);
                if (quotationStatusCode.statusCode == 200) {
                  Navigator.pop(context);
                  qDetailModal2.update("QCoverage", (value) => "");
                  qDetailModal2.update("QRiskCessTerm", (value) => "");
                  qDetailModal2.update("QPremCessTerm", (value) => "");
                  qDetailModal2.update("QBeneCessTerm", (value) => "");
                  qDetailModal2.update("QSumAssured", (value) => "");
                  qDetailModal2.update("QEmrRating", (value) => "");
                  qDetailModal2.update("QAgeAdmitted", (value) => "");
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
