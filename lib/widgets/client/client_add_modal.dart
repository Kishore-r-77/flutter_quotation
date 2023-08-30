import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/providers/clientProvider/client_provider.dart';
import 'package:quotation_flutter/services/client/client_service.dart';

class ClientAddModal extends ConsumerStatefulWidget {
  const ClientAddModal({super.key, required this.loginResponse});

  final dynamic loginResponse;

  @override
  ConsumerState<ClientAddModal> createState() => _ClientAddModalState();
}

class _ClientAddModalState extends ConsumerState<ClientAddModal> {
  List<dynamic> gender = [];
  List<dynamic> salutations = [];
  List<dynamic> languages = [];
  List<dynamic> clientstatuses = [];
  String selectedValue = 'I';
  String dropdownValue1 = 'F';
  String dropdownValue2 = 'Capt';
  String dropdownValue3 = 'E';
  String dropdownValue4 = 'AC';

  @override
  void initState() {
    super.initState();
    getGender();
    getSalutation();
    getLanguage();
    getClientStatus();
  }

  Future<dynamic> getGender() async {
    final response = await ClientService.getParam(
        widget.loginResponse['authToken'],
        widget.loginResponse['companyId'],
        "P0001",
        widget.loginResponse['languageId']);
    setState(() {
      gender = response["data"];
    });
  }

  Future<dynamic> getSalutation() async {
    final response = await ClientService.getParam(
        widget.loginResponse['authToken'],
        widget.loginResponse['companyId'],
        "P0006",
        widget.loginResponse['languageId']);
    setState(() {
      salutations = response["data"];
    });
  }

  Future<dynamic> getLanguage() async {
    final response = await ClientService.getParam(
        widget.loginResponse['authToken'],
        widget.loginResponse['companyId'],
        "P0002",
        widget.loginResponse['languageId']);
    setState(() {
      languages = response["data"];
    });
  }

  Future<dynamic> getClientStatus() async {
    final response = await ClientService.getParam(
        widget.loginResponse['authToken'],
        widget.loginResponse['companyId'],
        "P0009",
        widget.loginResponse['languageId']);
    setState(() {
      clientstatuses = response["data"];
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(selectedValue);

    TextEditingController clientDob =
        ref.watch(clientProvider.notifier).clientDob;
    final Map<String, dynamic> clientAddressDetails = ref.watch(clientProvider);
    final authToken =
        ref.watch(loginProvider.notifier).prefs?.getString("authToken");
    final companyId =
        ref.watch(loginProvider.notifier).prefs?.getInt("companyId");

    void handleRadioValueChanged(String? value) {
      setState(() {
        selectedValue = value!;
        clientAddressDetails.update("ClientType", (val) => selectedValue);
      });
    }

    // print("client type");
    // clientAddressDetails.update("ClientType", (val) => selectedValue);
    // print(clientAddressDetails["ClientType"]);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: ListView(
          children: [
            Center(
              child: Text(
                "Client",
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
                  child: RadioListTile<String>(
                    title: const Text('Individual'),
                    value: 'I',
                    groupValue: selectedValue,
                    onChanged: handleRadioValueChanged,
                  ),
                ),
                Flexible(
                  child: RadioListTile<String>(
                    title: const Text('Corporate'),
                    value: 'C',
                    groupValue: selectedValue,
                    onChanged: handleRadioValueChanged,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    initialValue: clientAddressDetails["ClientShortName"],
                    onChanged: (value) {
                      clientAddressDetails.update(
                          "ClientShortName", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Client Short Name",
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
                    initialValue: clientAddressDetails["ClientLongName"],
                    onChanged: (value) {
                      clientAddressDetails.update(
                          "ClientLongName", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Client Long Name",
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
                    initialValue: clientAddressDetails["ClientSurName"],
                    onChanged: (value) {
                      clientAddressDetails.update(
                          "ClientSurName", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Client Sur Name",
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
                      value: dropdownValue1,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      decoration: const InputDecoration(
                        labelText: "Gender",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (selectedvalue) {
                        setDropdownState(() {
                          dropdownValue1 = selectedvalue!;
                          clientAddressDetails.update(
                              "Gender", (val) => dropdownValue1);
                        });
                      },
                      items: gender
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
                StatefulBuilder(
                  builder: (context, setDropdownState) => Flexible(
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue2,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      decoration: const InputDecoration(
                        labelText: "Salutation",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (selectedvalue) {
                        setDropdownState(() {
                          dropdownValue2 = selectedvalue!;
                          clientAddressDetails.update(
                              "Salutation", (val) => dropdownValue2);
                        });
                      },
                      items: salutations
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
                      value: dropdownValue3,
                      elevation: 16,
                      decoration: const InputDecoration(
                        labelText: "Language",
                        border: OutlineInputBorder(),
                      ),
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (selectedvalue) {
                        setDropdownState(() {
                          dropdownValue3 = selectedvalue!;
                          clientAddressDetails.update(
                              "Language", (val) => dropdownValue3);
                        });
                      },
                      items: languages
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
                    initialValue: clientAddressDetails["ClientEmail"],
                    onChanged: (value) {
                      clientAddressDetails.update(
                          "ClientEmail", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Email",
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
                    initialValue: clientAddressDetails["ClientMobile"],
                    onChanged: (value) {
                      clientAddressDetails.update(
                          "ClientMobile", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Mobile",
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
                // Flexible(
                //   child: TextFormField(
                //     style: TextStyle(
                //       color: Theme.of(context).colorScheme.primary,
                //     ),
                //     initialValue: clientAddressDetails["ClientType"],
                //     onChanged: (value) {
                //       clientAddressDetails.update("ClientType", (val) => value);
                //     },
                //     decoration: InputDecoration(
                //         border: const OutlineInputBorder(),
                //         label: Text(
                //           "Client Type",
                //           style: TextStyle(
                //             color: Theme.of(context).colorScheme.primary,
                //           ),
                //         )),
                //   ),
                // ),
                // const SizedBox(
                //   width: 10,
                // ),
                StatefulBuilder(
                  builder: (context, setDropdownState) => Flexible(
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue4,
                      decoration: const InputDecoration(
                        labelText: "ClientStatus",
                        border: OutlineInputBorder(),
                      ),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (selectedvalue) {
                        setDropdownState(() {
                          dropdownValue4 = selectedvalue!;
                          clientAddressDetails.update(
                              "ClientStatus", (val) => dropdownValue4);
                        });
                      },
                      items: clientstatuses
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

                Flexible(
                  child: TextFormField(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    controller: clientDob,
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now());
                      if (pickeddate != null) {
                        setState(() {
                          clientDob.text =
                              DateFormat('dd/MM/yyyy').format(pickeddate);
                          clientAddressDetails.update(
                              "ClientDob",
                              (val) =>
                                  DateFormat('yyyyMMdd').format(pickeddate));
                        });
                      }
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Client DOB",
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
            Icon(
              Icons.swipe,
              color: Theme.of(context).colorScheme.primary,
            ),
            Center(
              child: Text(
                "Swipe Left to Add Addresses",
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
                    await ClientService.createClientWithAddresses(
                        authToken, companyId, clientAddressDetails);
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
