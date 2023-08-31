import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/providers/clientProvider/client_provider.dart';
import 'package:quotation_flutter/services/address/address_service.dart';
import 'package:quotation_flutter/services/client/client_service.dart';

class AddressesModal5 extends ConsumerStatefulWidget {
  const AddressesModal5({super.key, required this.loginResponse});

  final dynamic loginResponse;

  @override
  ConsumerState<AddressesModal5> createState() => _AddressesModal5State();
}

List<dynamic> addresstypes = [];
String selectedValue = 'BU';

class _AddressesModal5State extends ConsumerState<AddressesModal5> {
  @override
  void initState() {
    super.initState();
    getAddressTypes();
  }

  Future<dynamic> getAddressTypes() async {
    final response = await AddressService.getAddressTypes(
        widget.loginResponse['authToken'],
        widget.loginResponse['companyId'],
        widget.loginResponse['languageId'],
        "P0022");
    setState(() {
      addresstypes = response["data"];
      // print(addresstypes);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> addressesModal5 =
        ref.watch(clientProvider.notifier).modal1;

    TextEditingController addressStartDate =
        ref.watch(clientProvider.notifier).addressStartDate;

    List<dynamic> addressDetails = ref.watch(clientProvider)["Addresses"];
    //qDetails.add(qDetailModal1);
    bool isAdd = ref.watch(clientProvider.notifier).isAdd;
    bool isRemove = ref.watch(clientProvider.notifier).isRemove;

    final Map<String, dynamic> clientAddressDetails = ref.watch(clientProvider);
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
                "Addresses 5/5",
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
                                    addressesModal5.update(
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
                    initialValue: addressesModal5["AddressLine1"],
                    onChanged: (value) {
                      addressesModal5.update("AddressLine1", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Address Line 1",
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
                    initialValue: addressesModal5["AddressLine2"],
                    onChanged: (value) {
                      addressesModal5.update("AddressLine2", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Address Line 2",
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
                    initialValue: addressesModal5["AddressLine3"],
                    onChanged: (value) {
                      addressesModal5.update("AddressLine3", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Address Line 3",
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
                    initialValue: addressesModal5["AddressLine4"],
                    onChanged: (value) {
                      addressesModal5.update("AddressLine4", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Address Line 4",
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
                    initialValue: addressesModal5["AddressLine5"],
                    onChanged: (value) {
                      addressesModal5.update("AddressLine5", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Address Line 5",
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
                    initialValue: addressesModal5["AddressPostCode"],
                    onChanged: (value) {
                      addressesModal5.update("AddressPostCode", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Post Code",
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
                    initialValue: addressesModal5["AddressState"],
                    onChanged: (value) {
                      addressesModal5.update("AddressState", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "State",
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
                    initialValue: addressesModal5["AddressCountry"],
                    onChanged: (value) {
                      addressesModal5.update("AddressCountry", (val) => value);
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          "Country",
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
                    controller: addressStartDate,
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now());
                      if (pickeddate != null) {
                        setState(() {
                          addressStartDate.text =
                              DateFormat('dd/MM/yyyy').format(pickeddate);
                          addressesModal5.update(
                              "AddressStartDate",
                              (val) =>
                                  DateFormat('yyyyMMdd').format(pickeddate));
                        });
                      }
                    },
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
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
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
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
                            addressDetails.add({
                              "AddressType": addressesModal5["AddressType"],
                              "AddressLine1": addressesModal5["AddressLine1"],
                              "AddressLine2": addressesModal5["AddressLine2"],
                              "AddressLine3": addressesModal5["AddressLine3"],
                              "AddressLine4": addressesModal5["AddressLine4"],
                              "AddressLine5": addressesModal5["AddressLine5"],
                              "AddressPostCode":
                                  addressesModal5["AddressPostCode"],
                              "AddressState": addressesModal5["AddressState"],
                              "AddressCountry":
                                  addressesModal5["AddressCountry"],
                              "AddressStartDate":
                                  addressesModal5["AddressStartDate"],
                            });
                            setState(() {
                              isAdd = true;
                              isRemove = false;
                            });
                          },
                    child: const Text("Add"),
                  ),
                  const SizedBox(
                    width: 10,
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
                            addressDetails.removeLast();
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
              height: 10,
            ),
            Center(
              child: Text(
                "Swipe Left to Add Address",
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
                final clientStatusCode =
                    await ClientService.createClientWithAddresses(
                  authToken,
                  companyId,
                  clientAddressDetails,
                );
                print("Clicked");
                print(clientAddressDetails);
                print(clientStatusCode);
                if (clientStatusCode.statusCode == 200) {
                  Navigator.pop(context);
                  addressesModal5.update("AddressType", (value) => "");
                  addressesModal5.update("AddressLine1", (value) => "");
                  addressesModal5.update("AddressLine2", (value) => "");
                  addressesModal5.update("AddressLine3", (value) => "");
                  addressesModal5.update("AddressLine4", (value) => "");
                  addressesModal5.update("AddressLine5", (value) => "");
                  addressesModal5.update("AddressPostCode", (value) => "");
                  addressesModal5.update("AddressState", (value) => "");
                  addressesModal5.update("AddressCountry", (value) => "");
                  addressesModal5.update("AddressStartDate", (value) => "");
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
