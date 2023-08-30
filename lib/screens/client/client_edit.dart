import 'package:flutter/material.dart';
import 'package:quotation_flutter/services/client/client_service.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';
import 'package:intl/intl.dart';

class ClientEdit extends StatefulWidget {
  const ClientEdit({
    super.key,
    required this.clientRecord,
    required this.authToken,
    required this.companyId,
    required this.languageId,
    required this.loginResponse,
  });

  final dynamic clientRecord;
  final String? authToken;
  final dynamic loginResponse;
  final dynamic companyId;
  final dynamic languageId;

  @override
  State<ClientEdit> createState() => _ClientEditState();
}

class _ClientEditState extends State<ClientEdit> {
  List<dynamic> clienttypes = [];
  List<dynamic> gender = [];
  List<dynamic> salutations = [];
  List<dynamic> languages = [];
  List<dynamic> clientstatuses = [];
  TextEditingController searchString = TextEditingController();
  String searchCriteria = "client_sur_name";
  String dropdownValue = "I";
  TextEditingController pageNo = TextEditingController();
  int pageSize = 0;

  Map<String, dynamic> initialvalues = {
    "ClientType": "",
    "ClientShortName": "",
    "ClientLongName": "",
    "ClientSurName": "",
    "Gender": "",
    "Salutation": "",
    "Language": "",
    "ClientDob": "",
    "ClientDod": "",
    "ClientEmail": "",
    "ClientMobile": "",
    "ClientStatus": "",
  };

  void resetInitialValues() {
    initialvalues.update("ClientType", (value) => "");
    initialvalues.update("ClientShortName", (value) => "");
    initialvalues.update("ClientLongName", (value) => "");
    initialvalues.update("ClientSurName", (value) => "");
    initialvalues.update("Gender", (value) => "");
    initialvalues.update("Salutation", (value) => "");
    initialvalues.update("Language", (value) => "");
    initialvalues.update("ClientDob", (value) => "");
    initialvalues.update("ClientDod", (value) => "");
    initialvalues.update("ClientEmail", (value) => "");
    initialvalues.update("ClientMobile", (value) => "");
    initialvalues.update("ClientStatus", (value) => "");
  }

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

  TextEditingController clientDob = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String selectedValue = widget.clientRecord["ClientType"];
    String dropdownValue1 = widget.clientRecord["Gender"];
    String dropdownValue2 = widget.clientRecord["Salutation"];
    String dropdownValue3 = widget.clientRecord["Language"];
    String dropdownValue4 = widget.clientRecord["ClientStatus"];

    TextEditingController dob = TextEditingController();
    dob.text = AppUtils.formatDate(widget.clientRecord["ClientDob"]);

    // TextEditingController ClientDod = TextEditingController();
    // ClientDod.text = AppUtils.formatDate(widget.clientRecord["ClientDod"]);

    void handleRadioValueChanged(String? value) {
      setState(() {
        selectedValue = value!;
        widget.clientRecord.update("ClientType", (val) => selectedValue);
      });
    }

    return Scaffold(
      appBar: const CustomAppBar(title: "Client Edit", isBack: false),
      body: Form(
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
                    initialValue: widget.clientRecord["ClientShortName"],
                    onChanged: (value) {
                      widget.clientRecord
                          .update("ClientShortName", (val) => value);
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
                    initialValue: widget.clientRecord["ClientLongName"],
                    onChanged: (value) {
                      widget.clientRecord
                          .update("ClientLongName", (val) => value);
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
                    initialValue: widget.clientRecord["ClientSurName"],
                    onChanged: (value) {
                      widget.clientRecord
                          .update("ClientSurName", (val) => value);
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
                          widget.clientRecord
                              .update("Gender", (val) => dropdownValue1);
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
                          widget.clientRecord
                              .update("Salutation", (val) => dropdownValue2);
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
                      style: const TextStyle(color: Colors.deepPurple),
                      decoration: const InputDecoration(
                        labelText: "Language",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (selectedvalue) {
                        setDropdownState(() {
                          dropdownValue3 = selectedvalue!;
                          widget.clientRecord
                              .update("Language", (val) => dropdownValue3);
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
                    initialValue: widget.clientRecord["ClientEmail"],
                    onChanged: (value) {
                      widget.clientRecord.update("ClientEmail", (val) => value);
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
                    initialValue: widget.clientRecord["ClientMobile"],
                    onChanged: (value) {
                      widget.clientRecord
                          .update("ClientMobile", (val) => value);
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
                          widget.clientRecord
                              .update("ClientStatus", (val) => dropdownValue4);
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
                    controller: dob,
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now());
                      if (pickeddate != null) {
                        setState(() {
                          dob.text =
                              DateFormat('dd/MM/yyyy').format(pickeddate);
                          widget.clientRecord.update(
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
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  onPressed: () {
                    resetInitialValues();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Close",
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  onPressed: () async {
                    await ClientService.editClient(widget.authToken,
                        widget.companyId, widget.clientRecord);
                    final clientResp = await ClientService.getAllClients(
                      widget.loginResponse['authToken'],
                      searchString.text,
                      searchCriteria,
                      pageNo.text,
                      pageSize,
                    );
                    setState(() {
                      Navigator.pop(context, clientResp["All Clients"]);
                      resetInitialValues();
                    });
                  },
                  child: const Text(
                    "Update",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
