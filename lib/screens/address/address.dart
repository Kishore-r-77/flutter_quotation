import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/screens/address/address_enquiry.dart';
import 'package:quotation_flutter/services/address/address_service.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';

class AddressScreen extends ConsumerStatefulWidget {
  const AddressScreen({super.key, required this.loginResponse});
  final dynamic loginResponse;

  @override
  ConsumerState<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends ConsumerState<AddressScreen> {
  List<dynamic> addressLists = [];
  List<dynamic> fieldMap = [];

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

  TextEditingController searchString = TextEditingController();
  String searchCriteria = "address_line1";
  TextEditingController pageNo = TextEditingController();
  int pageSize = 0;
  @override
  void initState() {
    super.initState();
    getAllAddress(widget.loginResponse['authToken'], searchString.text,
        searchCriteria, pageNo.text, pageSize);
  }

  Future<dynamic> getAllAddress(
      token, searchString, searchCriteria, pageNo, pageSize) async {
    final response = await AddressService.getAllAddress(
      token,
      searchString,
      searchCriteria,
      pageNo,
      pageSize,
    );
    setState(() {
      addressLists = response["All Addresses"];
      fieldMap = response["Field Map"];
    });
  }

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

  TextEditingController _date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authToken =
        ref.read(loginProvider.notifier).prefs?.getString("authToken");

    dynamic addressResponse;

    deleteAddress(id) async {
      AddressService.softDeleteAddress(
        widget.loginResponse['authToken'],
        id,
      );
      var getData = await AddressService.getAllAddress(
          widget.loginResponse['authToken'],
          searchString.text,
          searchCriteria,
          pageNo.text,
          pageSize);
      setState(() {
        addressLists = getData["All Addresses"];
      });
    }

    return Scaffold(
      floatingActionButton: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: IconButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              useSafeArea: true,
              context: context,
              builder: (ctx) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              initialValue: initialvalues["AddressLine1"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "AddressLine1", (val) => value);
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
                          Flexible(
                            child: TextFormField(
                              initialValue: initialvalues["AddressLine2"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "AddressLine2", (val) => value);
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
                              initialValue: initialvalues["AddressLine3"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "AddressLine3", (val) => value);
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
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              initialValue: initialvalues["AddressLine4"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "AddressLine4", (val) => value);
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
                              initialValue: initialvalues["AddressLine5"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "AddressLine5", (val) => value);
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
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              initialValue: initialvalues["AddressType"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "AddressType", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("Address Type"),
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
                              initialValue: initialvalues["AddressPostCode"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "AddressPostCode", (val) => value);
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
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              initialValue: initialvalues["AddressState"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "AddressState", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("State"),
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
                              initialValue: initialvalues["AddressCountry"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "AddressCountry", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("Country"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              controller: _date,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.calendar_today_rounded),
                                labelText: "Start Date",
                              ),
                              onTap: () async {
                                DateTime? pickeddate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now());
                                if (pickeddate != null) {
                                  setState(() {
                                    _date.text = DateFormat('dd/MM/yyyy')
                                        .format(pickeddate);
                                    initialvalues.update(
                                        "AddressStartDate",
                                        (val) => DateFormat('yyyyMMdd')
                                            .format(pickeddate));
                                  });
                                }
                              },
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
                              initialValue: initialvalues["ClientID"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "ClientID", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("Owner Id"),
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
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onSecondary,
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
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onSecondary,
                            ),
                            onPressed: () async {
                              await AddressService.createAddress(
                                  widget.loginResponse['authToken'],
                                  ref
                                      .watch(loginProvider.notifier)
                                      .prefs
                                      ?.getInt('companyId'),
                                  initialvalues);
                              final addressResp = await getAllAddress(
                                widget.loginResponse['authToken'],
                                searchString.text,
                                searchCriteria,
                                pageNo.text,
                                pageSize,
                              );
                              setState(() {
                                Navigator.pop(context);
                                addressLists = addressResp["All Addresses"];
                                resetInitialValues();
                              });
                            },
                            child: const Text(
                              "Submit",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          icon: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
      appBar: CustomAppBar(
        title: AppUtils.quotationTitle,
        isBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                "Address Enquiry",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Theme.of(context).colorScheme.primary),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: DropdownButton<String>(
                      value: searchCriteria,
                      elevation: 5,
                      items: fieldMap
                          .map(
                            (values) => DropdownMenuItem(
                              value: "${values['fieldName']}",
                              child: Text(
                                "${values['displayName']}",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (selectedValue) {
                        setState(
                          () {
                            searchCriteria = selectedValue!;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: TextFormField(
                      onChanged: (value) {
                        searchString.text = value;
                      },
                      decoration: InputDecoration(
                          labelText: "Search String",
                          border: const OutlineInputBorder(),
                          suffix: IconButton(
                              onPressed: () async {
                                var response =
                                    await AddressService.getAllAddress(
                                  authToken,
                                  searchString.text,
                                  searchCriteria,
                                  pageNo.text,
                                  pageSize,
                                );
                                setState(() {
                                  addressLists = response['All Addresses'];
                                });
                              },
                              icon: const Icon(Icons.search))),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                  itemCount: addressLists.length,
                  itemBuilder: (context, index) => Dismissible(
                    key: ValueKey(addressLists[index]['ID']),
                    background: Container(
                      color:
                          Theme.of(context).colorScheme.error.withOpacity(0.75),
                      // margin: EdgeInsets.symmetric(
                      //     horizontal:
                      //         Theme.of(context).cardTheme.margin!.horizontal),
                    ),
                    onDismissed: (direction) {
                      deleteAddress(addressLists[index]['ID']);
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Address Deleted"),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: "Undo",
                            onPressed: () {
                              // setState(() {
                              //   _registeredExpenses.insert(expenseIndex, expense);
                              // });
                            },
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Theme.of(context).colorScheme.surface,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      borderOnForeground: false,
                      // shadowColor: Theme.of(context).colorScheme.primary,
                      elevation: 12,
                      child: ListTile(
                        title: Row(
                          children: [
                            Text(
                              '${addressLists[index]['ID']}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${addressLists[index]['AddressType']}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              '${addressLists[index]['AddressLine1']}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${addressLists[index]['AddressPostCode']}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () async {
                              addressResponse = await AddressService.getAddress(
                                  authToken, addressLists[index]['ID']);

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddressEnquiry(
                                    addressResponse: addressResponse["Address"],
                                    authToken: authToken,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.info,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
