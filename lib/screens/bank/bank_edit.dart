import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/providers/darkProvider/dark_provider.dart';
import 'package:quotation_flutter/screens/client/client.dart';
import 'package:quotation_flutter/services/bank/bank_service.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';

// ignore: must_be_immutable
class BankEdit extends StatefulWidget {
  const BankEdit({
    super.key,
    required this.bankRecord,
    required this.authToken,
    required this.companyId,
    required this.languageId,
    required this.loginResponse,
  });

  final dynamic bankRecord;
  final dynamic loginResponse;
  final String? authToken;
  final dynamic companyId;
  final dynamic languageId;

  @override
  State<BankEdit> createState() => _BankEditState();
}

class _BankEditState extends State<BankEdit> {
  List<dynamic> banktypes = [];
  List<dynamic> bankypes = [];
  List<dynamic> bankaccountstatus = [];
  List<dynamic> bankgroups = [];
  List<dynamic> bankLists = [];
  List<dynamic> fieldMap = [];

  TextEditingController searchString = TextEditingController();
  String searchCriteria = "bankcode";
  //String dropdownValue = "BU";
  TextEditingController pageNo = TextEditingController();
  int pageSize = 0;

  Map<String, dynamic> initialvalues = {
    "BankCode": "",
    "BankAccountNo": "",
    "StartDate": "",
    "EndDate": "",
    "BankType": "",
    "BankAccountStatus": "",
    "ClientID": "",
    "BankGroup": "",
  };

  get ref => null;
  @override
  void initState() {
    super.initState();
    getBankTypes();
    getBankAccountStatus();
    // getBankGroups();
    getAllBank(widget.loginResponse['authToken'], searchString.text,
        searchCriteria, pageNo.text, pageSize);
  }

  Future<dynamic> getAllBank(
      token, searchString, searchCriteria, pageNo, pageSize) async {
    final response = await BankService.getAllBank(
      token,
      searchString,
      searchCriteria,
      pageNo,
      pageSize,
    );
    setState(() {
      bankLists = response["All Banks"];
      fieldMap = response["Field Map"];
    });
  }

  String selectedValue = 'CA';
  String dropdownValue1 = 'AC';
  String dropdownValue2 = 'ICICI';

  Future<dynamic> getBankTypes() async {
    final response = await BankService.getBankTypes(
        widget.loginResponse['authToken'],
        widget.loginResponse['companyId'],
        widget.loginResponse['languageId'],
        "P0020");
    setState(() {
      bankypes = response["data"];
    });
  }

  Future<dynamic> getBankAccountStatus() async {
    final response = await BankService.getAccountTypes(
        widget.loginResponse['authToken'],
        widget.loginResponse['companyId'],
        widget.loginResponse['languageId'],
        "P0021");
    setState(() {
      bankaccountstatus = response["data"];
    });
  }

  // Future<dynamic> getBankGroups() async {
  //   final response = await BankService.getBankGroups(
  //       widget.loginResponse['authToken'],
  //       widget.loginResponse['companyId'],
  //       widget.loginResponse['languageId'],
  //       "P0050",
  //       "BANKGROUP");
  //   setState(() {
  //     bankgroups = response['param']['data']['datapairs'];
  //     print(bankgroups);
  //   });
  // }

  void resetInitialValues() {
    initialvalues.update("BankCode", (value) => "");
    initialvalues.update("BankAccountNo", (value) => "");
    initialvalues.update("StartDate", (value) => "");
    initialvalues.update("EndDate", (value) => "");
    initialvalues.update("BankType", (value) => "");
    initialvalues.update("BankAccountStatus", (value) => "");
    initialvalues.update("ClientID", (value) => "");
    initialvalues.update("BankGroup", (value) => "");
  }

  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController clientIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // String selectedValue = widget.bankRecord["BankType"];
    TextEditingController startDate = TextEditingController();
    startDate.text = AppUtils.formatDate(widget.bankRecord["StartDate"]);
    // ignore: unused_local_variable
    TextEditingController endDate = TextEditingController();
    endDate.text = AppUtils.formatDate(widget.bankRecord["EndDate"]);

    // final isDark = ref.watch(darkProvider);
    return Scaffold(
      appBar: const CustomAppBar(title: "Bank Edit", isBack: false),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            StatefulBuilder(
              builder: (context, setRadioState) => Flexible(
                child: Row(
                  children: [
                    ...bankypes.map((address) => Flexible(
                          child: RadioListTile<String>(
                            // title: const Text('Business'),
                            title: Text(address['longdesc']),
                            value: address['item'],
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setRadioState(() {
                                selectedValue = value!;
                                initialvalues.update(
                                    "BankType", (val) => selectedValue);
                              });
                            },
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Flexible(
              child: TextFormField(
                initialValue: widget.bankRecord["ClientID"].toString(),
                onChanged: (value) {
                  widget.bankRecord.update("ClientID", (val) => value);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  label: Text("OwnerID"),
                ),
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
                initialValue: widget.bankRecord["BankCode"],
                onChanged: (value) {
                  widget.bankRecord.update("BankCode", (val) => value);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  label: Text("Bank Code"),
                ),
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
                initialValue: widget.bankRecord["BankAccountNo"],
                onChanged: (value) {
                  widget.bankRecord.update("BankAccountNo", (val) => value);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  label: Text("Bank Account No"),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            StatefulBuilder(
              builder: (context, setDropdownState) => Flexible(
                child: DropdownButtonFormField<String>(
                  value: dropdownValue1,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  decoration: const InputDecoration(
                    labelText: "Bank Account Status",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (selectedvalue) {
                    setDropdownState(() {
                      dropdownValue1 = selectedvalue!;
                      initialvalues.update(
                          "BankAccountStatus", (val) => dropdownValue1);
                    });
                  },
                  items: bankaccountstatus
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
              height: 20,
            ),
            Flexible(
              child: TextFormField(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
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
                      startDate.text =
                          DateFormat('dd/MM/yyyy').format(pickeddate);
                      initialvalues.update("StartDate",
                          (val) => DateFormat('yyyyMMdd').format(pickeddate));
                    });
                  }
                },
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
                controller: endDate,
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today_rounded),
                  labelText: "End Date",
                ),
                onTap: () async {
                  DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(3000));
                  if (pickeddate != null) {
                    setState(() {
                      endDate.text =
                          DateFormat('dd/MM/yyyy').format(pickeddate);
                      initialvalues.update("EndDate",
                          (val) => DateFormat('yyyyMMdd').format(pickeddate));
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // StatefulBuilder(
            //   builder: (context, setDropdownState) => Flexible(
            //     child: DropdownButtonFormField<String>(
            //       value: dropdownValue2,
            //       icon: const Icon(Icons.arrow_downward),
            //       decoration: const InputDecoration(
            //           fillColor: Colors.purple, labelText: "Bank Group"),
            //       elevation: 16,
            //       style: const TextStyle(color: Colors.deepPurple),
            //       onChanged: (selectedvalue) {
            //         setDropdownState(() {
            //           dropdownValue2 = selectedvalue!;
            //           initialvalues.update(
            //               "BankGroup", (val) => dropdownValue2);
            //         });
            //       },
            //       items: bankgroups
            //           .map(
            //             (values) => DropdownMenuItem(
            //               value: "${values['item']}",
            //               child: Text(
            //                 "${values['longdesc']}",
            //                 style: TextStyle(
            //                   color: Theme.of(context).colorScheme.primary,
            //                 ),
            //               ),
            //             ),
            //           )
            //           .toList(),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 20,
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
                    await BankService.editBank(
                        widget.authToken, widget.companyId, widget.bankRecord);
                    final bankResp = await BankService.getAllBank(
                      widget.loginResponse['authToken'],
                      searchString.text,
                      searchCriteria,
                      pageNo.text,
                      pageSize,
                    );
                    setState(() {
                      Navigator.pop(context, bankResp["All Banks"]);
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
