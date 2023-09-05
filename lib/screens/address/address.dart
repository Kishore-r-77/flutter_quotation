import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/screens/address/address_edit.dart';
import 'package:quotation_flutter/providers/darkProvider/dark_provider.dart';
import 'package:quotation_flutter/screens/address/address_enquiry.dart';
import 'package:quotation_flutter/screens/client/client.dart';
import 'package:quotation_flutter/services/address/address_service.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';
import 'package:quotation_flutter/widgets/mainDrawer/main_drawer.dart';

//Address Screen
class AddressScreen extends ConsumerStatefulWidget {
  const AddressScreen({
    super.key,
    required this.loginResponse,
    required this.isLookUp,
  });
  final dynamic loginResponse;
  final bool isLookUp;

  @override
  ConsumerState<AddressScreen> createState() => _AddressScreenState();
}

// enum SingingCharacter { lafayette, jefferson }

class _AddressScreenState extends ConsumerState<AddressScreen> {
  List<dynamic> addressLists = [];
  List<dynamic> fieldMap = [];
  List<dynamic> addresstypes = [];

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
  String dropdownValue = "BU";
  TextEditingController pageNo = TextEditingController();
  int pageSize = 0;
  @override
  void initState() {
    super.initState();
    getAllAddress(widget.loginResponse['authToken'], searchString.text,
        searchCriteria, pageNo.text, pageSize);
    getAddressTypes();
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

  TextEditingController startDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //getting the token from flutter_riverpod
    final authToken =
        ref.watch(loginProvider.notifier).prefs?.getString("authToken");
    //getting theme from flutter_riverpod
    final isDark = ref.watch(darkProvider);

    dynamic addressResponse;

    // SingingCharacter? _character = SingingCharacter.lafayette;
    String selectedValue = 'BU';

    final TextEditingController clientIdController = TextEditingController();
    return Scaffold(
      drawer: MainDrawer(
        loginResponse: widget.loginResponse,
      ),
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
                                              initialvalues.update(
                                                  "AddressType",
                                                  (val) => selectedValue);
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
                          // StatefulBuilder(
                          //   builder: (context, setDropdownState) => Flexible(
                          //     child: DropdownButton<String>(
                          //       value: dropdownValue,
                          //       icon: const Icon(Icons.arrow_downward),
                          //       elevation: 16,
                          //       style:
                          //           const TextStyle(color: Colors.deepPurple),
                          //       underline: Container(
                          //         height: 2,
                          //         color: Colors.deepPurpleAccent,
                          //       ),
                          //       onChanged: (selectedvalue) {
                          //         setDropdownState(() {
                          //           dropdownValue = selectedvalue!;
                          //           initialvalues.update(
                          //               "AddressType", (val) => dropdownValue);
                          //         });
                          //       },
                          //       items: addresstypes
                          //           .map(
                          //             (values) => DropdownMenuItem(
                          //               value: "${values['item']}",
                          //               child: Text(
                          //                 "${values['longdesc']}",
                          //                 style: TextStyle(
                          //                   color: Theme.of(context)
                          //                       .colorScheme
                          //                       .primary,
                          //                 ),
                          //               ),
                          //             ),
                          //           )
                          //           .toList(),
                          //     ),
                          //   ),
                          // ),
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
                              controller: startDate,
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
                                    startDate.text = DateFormat('dd/MM/yyyy')
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
                                      loginResponse: widget.loginResponse,
                                    ),
                                  ),
                                );

                                clientIdController.text = clientId ?? 0;
                                initialvalues.update(
                                  "ClientID",
                                  (value) => clientIdController.text,
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
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if (widget.isLookUp) {
                        return Navigator.pop(
                          context,
                          addressLists[index]['ID'].toString(),
                        );
                      } else {
                        return;
                      }
                    },
                    child: Slidable(
                      startActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            icon: Icons.delete,
                            label: "Delete",
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            onPressed: (context) {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  content: const Text(
                                      "Are you sure you want to delete this Record"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                      },
                                      child: const Text("No"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        deleteAddress(
                                            addressLists[index]['ID']);
                                        Navigator.pop(ctx);

                                        ScaffoldMessenger.of(ctx)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(ctx).showSnackBar(
                                          const SnackBar(
                                            content: Text("Address Deleted"),
                                            duration: Duration(seconds: 2),
                                            // action: SnackBarAction(
                                            //   label: "Undo",
                                            //   onPressed: () {
                                            //     // setState(() {
                                            //     //   _registeredExpenses.insert(expenseIndex, expense);
                                            //     // });
                                            //   },
                                            //),
                                          ),
                                        );
                                      },
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                ),
                                barrierDismissible: true,
                              );
                            },
                          ),
                          SlidableAction(
                            icon: Icons.edit,
                            label: "Edit",
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            onPressed: (context) async {
                              addressResponse = await AddressService.getAddress(
                                  authToken, addressLists[index]['ID']);

                              // ignore: use_build_context_synchronously
                              final resp = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddressEdit(
                                    addressRecord: addressResponse["Address"],
                                    authToken: authToken,
                                    companyId:
                                        widget.loginResponse['companyId'],
                                    languageId:
                                        widget.loginResponse['languageId'],
                                    loginResponse: widget.loginResponse,
                                  ),
                                ),
                              );
                              setState(() {
                                if (resp == null) {
                                  return;
                                } else {
                                  addressLists = resp;
                                }
                              });
                            },
                          ),
                          SlidableAction(
                            icon: Icons.info,
                            label: "Info",
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            onPressed: (context) async {
                              addressResponse = await AddressService.getAddress(
                                  authToken, addressLists[index]['ID']);

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddressEnquiry(
                                      addressResponse:
                                          addressResponse["Address"],
                                      authToken: authToken),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            icon: Icons.delete,
                            label: "Delete",
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            onPressed: (context) {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  content: const Text(
                                      "Are you sure you want to delete this Record"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                      },
                                      child: const Text("No"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        deleteAddress(
                                            addressLists[index]['ID']);
                                        Navigator.pop(ctx);

                                        ScaffoldMessenger.of(ctx)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(ctx).showSnackBar(
                                          const SnackBar(
                                            content: Text("Address Deleted"),
                                            duration: Duration(seconds: 2),
                                            // action: SnackBarAction(
                                            //   label: "Undo",
                                            //   onPressed: () {
                                            //     // setState(() {
                                            //     //   _registeredExpenses.insert(expenseIndex, expense);
                                            //     // });
                                            //   },
                                            //),
                                          ),
                                        );
                                      },
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                ),
                                barrierDismissible: true,
                              );
                            },
                          ),
                          SlidableAction(
                            icon: Icons.edit,
                            label: "Edit",
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            onPressed: (context) async {
                              addressResponse = await AddressService.getAddress(
                                  authToken, addressLists[index]['ID']);
                              // ignore: use_build_context_synchronously
                              final resp = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddressEdit(
                                    addressRecord: addressResponse["Address"],
                                    authToken: authToken,
                                    companyId:
                                        widget.loginResponse['companyId'],
                                    languageId:
                                        widget.loginResponse['languageId'],
                                    loginResponse: widget.loginResponse,
                                  ),
                                ),
                              );
                              setState(() {
                                addressLists = resp;
                              });
                            },
                          ),
                          SlidableAction(
                            icon: Icons.info,
                            label: "Info",
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            onPressed: (context) async {
                              addressResponse = await AddressService.getAddress(
                                  authToken, addressLists[index]['ID']);

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddressEnquiry(
                                      addressResponse:
                                          addressResponse["Address"],
                                      authToken: authToken),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      child: InkWell(
                        onDoubleTap: () async {
                          addressResponse = await AddressService.getAddress(
                              authToken, addressLists[index]['ID']);
                          // ignore: use_build_context_synchronously
                          final resp = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddressEdit(
                                addressRecord: addressResponse["Address"],
                                authToken: authToken,
                                companyId: widget.loginResponse['companyId'],
                                languageId: widget.loginResponse['languageId'],
                                loginResponse: widget.loginResponse,
                              ),
                            ),
                          );
                          setState(() {
                            addressLists = resp;
                          });
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
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  content: const Text(
                                      "Are you sure you want to delete this Record"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                      },
                                      child: const Text("No"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        deleteAddress(
                                            addressLists[index]['ID']);
                                        Navigator.pop(ctx);

                                        ScaffoldMessenger.of(ctx)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(ctx).showSnackBar(
                                          const SnackBar(
                                            content: Text("Address Deleted"),
                                            duration: Duration(seconds: 2),
                                            // action: SnackBarAction(
                                            //   label: "Undo",
                                            //   onPressed: () {
                                            //     // setState(() {
                                            //     //   _registeredExpenses.insert(expenseIndex, expense);
                                            //     // });
                                            //   },
                                            //),
                                          ),
                                        );
                                      },
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                ),
                                barrierDismissible: true,
                              );
                            },
                            title: Row(
                              children: [
                                Text(
                                  '${addressLists[index]['ID']}',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  foregroundColor:
                                      isDark ? Colors.black : Colors.white,
                                  child: Text(
                                    '${addressLists[index]['AddressType']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  '${addressLists[index]['AddressLine1']}',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${addressLists[index]['AddressPostCode']}',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.swipe,
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                          ),
                        ),
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
