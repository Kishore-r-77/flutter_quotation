import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/providers/darkProvider/dark_provider.dart';
import 'package:quotation_flutter/screens/bank/bank_enquiry.dart';
import 'package:quotation_flutter/screens/client/client.dart';
import 'package:quotation_flutter/services/bank/bank_service.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';
import 'package:quotation_flutter/widgets/mainDrawer/main_drawer.dart';

class BankScreen extends ConsumerStatefulWidget {
  const BankScreen({
    super.key,
    required this.loginResponse,
    required this.isLookUp,
  });
  final dynamic loginResponse;
  final bool isLookUp;

  @override
  ConsumerState<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends ConsumerState<BankScreen> {
  List<dynamic> bankLists = [];
  List<dynamic> fieldMap = [];
  List<dynamic> bankypes = [];
  List<dynamic> bankaccountstatus = [];
  List<dynamic> bankgroups = [];

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

  TextEditingController searchString = TextEditingController();
  String searchCriteria = "client_id";
  TextEditingController pageNo = TextEditingController();
  int pageSize = 0;
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
  String dropdownValue = 'AC';

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
  //     bankgroups = response;
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

  deleteBank(id) async {
    BankService.softDeleteBank(
      widget.loginResponse['authToken'],
      id,
    );
    var getData = await BankService.getAllBank(
        widget.loginResponse['authToken'],
        searchString.text,
        searchCriteria,
        pageNo.text,
        pageSize);
    setState(() {
      bankLists = getData["All Banks"];
    });
  }

  final TextEditingController _sdate = TextEditingController();
  final TextEditingController _edate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authToken =
        ref.read(loginProvider.notifier).prefs?.getString("authToken");

    dynamic bankResponse;

    final TextEditingController clientIdController = TextEditingController();
    final isDark = ref.watch(darkProvider);
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
                                  ...bankypes.map((address) => Flexible(
                                        child: RadioListTile<String>(
                                          // title: const Text('Business'),
                                          title: Text(address['longdesc']),
                                          value: address['item'],
                                          groupValue: selectedValue,
                                          onChanged: (value) {
                                            setRadioState(() {
                                              selectedValue = value!;
                                              initialvalues.update("BankType",
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
                              initialValue: initialvalues["BankCode"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "BankCode", (val) => value);
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
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              initialValue: initialvalues["BankAccountNo"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "BankAccountNo", (val) => value);
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
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          StatefulBuilder(
                            builder: (context, setDropdownState) => Flexible(
                              child: DropdownButtonFormField<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                decoration: const InputDecoration(
                                    fillColor: Colors.purple,
                                    labelText: "Bank Account Status"),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                onChanged: (selectedvalue) {
                                  setDropdownState(() {
                                    dropdownValue = selectedvalue!;
                                    initialvalues.update("BankAccountStatus",
                                        (val) => dropdownValue);
                                  });
                                },
                                items: bankaccountstatus
                                    .map(
                                      (values) => DropdownMenuItem(
                                        value: "${values['item']}",
                                        child: Text(
                                          "${values['longdesc']}",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
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
                              controller: _sdate,
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
                                    _sdate.text = DateFormat('dd/MM/yyyy')
                                        .format(pickeddate);
                                    initialvalues.update(
                                        "StartDate",
                                        (val) => DateFormat('yyyyMMdd')
                                            .format(pickeddate));
                                  });
                                }
                              },
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
                              controller: _edate,
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
                                    _edate.text = DateFormat('dd/MM/yyyy')
                                        .format(pickeddate);
                                    initialvalues.update(
                                        "EndDate",
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
                              await BankService.createBank(
                                  widget.loginResponse['authToken'],
                                  ref
                                      .watch(loginProvider.notifier)
                                      .prefs
                                      ?.getInt('companyId'),
                                  initialvalues);
                              final bankResp = await getAllBank(
                                widget.loginResponse['authToken'],
                                searchString.text,
                                searchCriteria,
                                pageNo.text,
                                pageSize,
                              );
                              setState(() {
                                Navigator.pop(context);
                                bankLists = bankResp["All Banks"];
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
                "Bank Enquiry",
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
                                var response = await BankService.getAllBank(
                                  authToken,
                                  searchString.text,
                                  searchCriteria,
                                  pageNo.text,
                                  pageSize,
                                );
                                setState(() {
                                  bankLists = response['All Addresses'];
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
                  itemCount: bankLists.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if (widget.isLookUp) {
                        return Navigator.pop(
                          context,
                          bankLists[index]['ID'].toString(),
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
                                        deleteBank(bankLists[index]['ID']);
                                        Navigator.pop(ctx);

                                        ScaffoldMessenger.of(ctx)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(ctx).showSnackBar(
                                          const SnackBar(
                                            content: Text("Bank Deleted"),
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
                            onPressed: (context) {},
                          ),
                          SlidableAction(
                            icon: Icons.info,
                            label: "Info",
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            onPressed: (context) async {
                              bankResponse = await BankService.getBank(
                                  authToken, bankLists[index]['ID']);

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BankEnquiry(
                                      bankResponse: bankResponse["Bank"],
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
                                        deleteBank(bankLists[index]['ID']);
                                        Navigator.pop(ctx);

                                        ScaffoldMessenger.of(ctx)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(ctx).showSnackBar(
                                          const SnackBar(
                                            content: Text("Bank Deleted"),
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
                            onPressed: (context) {},
                          ),
                          SlidableAction(
                            icon: Icons.info,
                            label: "Info",
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            onPressed: (context) async {
                              bankResponse = await BankService.getBank(
                                  authToken, bankLists[index]['ID']);

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BankEnquiry(
                                      bankResponse: bankResponse["Bank"],
                                      authToken: authToken),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
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
                              CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor:
                                    isDark ? Colors.black : Colors.white,
                                child: Text(
                                  '${bankLists[index]['ID']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${bankLists[index]['BankCode']}',
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
                                '${bankLists[index]['BankType']}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${bankLists[index]['BankAccountNo']}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
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
            ],
          ),
        ),
      ),
    );
  }
}
