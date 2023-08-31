import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quotation_flutter/services/address/address_service.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';

// ignore: must_be_immutable
class AddressEdit extends StatefulWidget {
  const AddressEdit({
    super.key,
    required this.addressRecord,
    required this.authToken,
    required this.companyId,
    required this.languageId,
    required this.loginResponse,
  });

  final dynamic addressRecord;
  final dynamic loginResponse;
  final String? authToken;
  final dynamic companyId;
  final dynamic languageId;

  @override
  State<AddressEdit> createState() => _AddressEditState();
}

class _AddressEditState extends State<AddressEdit> {
  List<dynamic> addresstypes = [];
  // List<dynamic> addressLists = [];
  TextEditingController searchString = TextEditingController();
  String searchCriteria = "address_line1";
  String dropdownValue = "BU";
  TextEditingController pageNo = TextEditingController();
  int pageSize = 0;

  Map<String, dynamic> initialvalues = {
    "AddressType": "",
    "AddressLine1": "",
    "AddressLine2": "",
    "AddressLine3": "",
    "AddressLine4": "",
    "AddressLine5": "",
    "AddressPostCode": "",
    "AddressState": "",
    "AddressCountry": "",
    "AddressStartDate": "",
    "AddressEndDate": "",
    "ClientID": "",
  };

  void resetInitialValues() {
    initialvalues.update("AddressType", (value) => "");
    initialvalues.update("AddressLine1", (value) => "");
    initialvalues.update("AddressLine2", (value) => "");
    initialvalues.update("AddressLine3", (value) => "");
    initialvalues.update("AddressLine4", (value) => "");
    initialvalues.update("AddressLine5", (value) => "");
    initialvalues.update("AddressPostCode", (value) => "");
    initialvalues.update("AddressState", (value) => "");
    initialvalues.update("AddressCountry", (value) => "");
    initialvalues.update("AddressStartDate", (value) => "");
    initialvalues.update("AddressEndDate", (value) => "");
    initialvalues.update("ClientID", (value) => "");
  }

  TextEditingController addressStartDate = TextEditingController();
  TextEditingController clientIdController = TextEditingController();

  Future<dynamic> getAddressTypes() async {
    final response = await AddressService.getAddressTypes(
        widget.authToken, widget.companyId, widget.languageId, "P0022");
    setState(() {
      addresstypes = response["data"];
    });
  }

  @override
  void initState() {
    super.initState();
    getAddressTypes();
  }

  @override
  Widget build(BuildContext context) {
    String selectedValue = widget.addressRecord["AddressType"];
    TextEditingController startDate = TextEditingController();
    startDate.text =
        AppUtils.formatDate(widget.addressRecord["AddressStartDate"]);

    return Scaffold(
      appBar: const CustomAppBar(title: "Address Edit", isBack: false),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Row(
              children: [
                StatefulBuilder(
                  builder: (context, setRadioState) => Flexible(
                    child: Row(
                      children: [
                        ...addresstypes.map((address) => Flexible(
                              child: RadioListTile<String>(
                                // title: const Text('Business'),
                                title: Text(address['longdesc']),
                                value: address['item'],
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setRadioState(() {
                                    selectedValue = value!;
                                    widget.addressRecord.update(
                                        "AddressType", (val) => selectedValue);
                                  });
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    initialValue: widget.addressRecord["AddressLine1"],
                    onChanged: (value) {
                      widget.addressRecord
                          .update("AddressLine1", (val) => value);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      label: Text("Address Line 1"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
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
                    initialValue: widget.addressRecord["AddressLine2"],
                    onChanged: (value) {
                      widget.addressRecord
                          .update("AddressLine2", (val) => value);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      label: Text("Address Line 2"),
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
                    initialValue: widget.addressRecord["AddressLine3"],
                    onChanged: (value) {
                      widget.addressRecord
                          .update("AddressLine3", (val) => value);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      label: Text("Address Line 3"),
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
                    initialValue: widget.addressRecord["AddressLine4"],
                    onChanged: (value) {
                      widget.addressRecord
                          .update("AddressLine4", (val) => value);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      label: Text("Address Line 4"),
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
                    initialValue: widget.addressRecord["AddressLine5"],
                    onChanged: (value) {
                      widget.addressRecord
                          .update("AddressLine5", (val) => value);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      label: Text("Address Line 5"),
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
                    initialValue: widget.addressRecord["AddressPostCode"],
                    onChanged: (value) {
                      widget.addressRecord
                          .update("AddressPostCode", (val) => value);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      label: Text("Address Post Code"),
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
                    initialValue: widget.addressRecord["AddressState"],
                    onChanged: (value) {
                      widget.addressRecord
                          .update("AddressState", (val) => value);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      label: Text("Address State"),
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
                    initialValue: widget.addressRecord["AddressCountry"],
                    onChanged: (value) {
                      widget.addressRecord
                          .update("AddressCountry", (val) => value);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      label: Text("Address Country"),
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
                    controller: startDate,
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now());
                      if (pickeddate != null) {
                        setState(() {
                          startDate.text =
                              DateFormat('dd/MM/yyyy').format(pickeddate);
                          widget.addressRecord.update(
                              "AddressStartDate",
                              (val) =>
                                  DateFormat('yyyyMMdd').format(pickeddate));
                        });
                      }
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        label: Text(
                          "Address Start Date",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )),
                  ),
                ),
              ],
            ),

            // Flexible(
            //   child: TextFormField(
            //     initialValue: widget.addressRecord["AddressStartDate"],
            //     controller: addressStartDate,
            //     decoration: const InputDecoration(
            //       icon: Icon(Icons.calendar_today_rounded),
            //       labelText: "Start Date",
            //     ),
            //     onTap: () async {
            //       DateTime? pickeddate = await showDatePicker(
            //           context: context,
            //           initialDate:
            //               widget.addressRecord["AddressStartDate"] ??
            //                   DateTime.now(),
            //           firstDate: DateTime(1900),
            //           lastDate: DateTime.now());
            //       if (pickeddate != null) {
            //         setState(() {
            //           addressStartDate.text =
            //               DateFormat('dd/MM/yyyy').format(pickeddate);
            //           widget.addressRecord.update(
            //               "AddressStartDate",
            //               (val) =>
            //                   DateFormat('yyyyMMdd').format(pickeddate));
            //         });
            //       }
            //     },
            //   ),
            // ),

            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                // Flexible(
                //   child: TextFormField(
                //     initialValue: widget.addressRecord["ClientID"].toString(),
                //     style: TextStyle(
                //       color: Theme.of(context).colorScheme.primary,
                //     ),
                //     controller:
                //         clientIdController, // Use the TextEditingController
                //     onTap: () async {
                //       final clientId = await Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (ctx) => ClientScreen(
                //             isLookUp: true,
                //             loginResponse: widget.loginResponse,
                //           ),
                //         ),
                //       );

                //       clientIdController.text = clientId ?? 0;
                //       initialvalues.update(
                //         "ClientID",
                //         (value) => clientIdController.text,
                //       );
                //     },
                //     // onChanged: (value) {

                //     // },
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(8),
                //         ),
                //       ),
                //       label: Text("Owner Id"),
                //     ),
                //   ),
                // ),

                Flexible(
                  child: TextFormField(
                    initialValue: widget.addressRecord["ClientID"].toString(),
                    onChanged: (value) {
                      widget.addressRecord.update("ClientID", (val) => value);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      label: Text("Client ID"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
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
                    await AddressService.editAddress(widget.authToken,
                        widget.companyId, widget.addressRecord);
                    final addressResp = await AddressService.getAllAddress(
                      widget.loginResponse['authToken'],
                      searchString.text,
                      searchCriteria,
                      pageNo.text,
                      pageSize,
                    );
                    setState(() {
                      Navigator.pop(context, addressResp["All Addresses"]);
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
