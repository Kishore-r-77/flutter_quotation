import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/screens/bank/bank_enquiry.dart';
import 'package:quotation_flutter/services/bank/bank_service.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';

class BankScreen extends ConsumerStatefulWidget {
  const BankScreen({super.key, required this.loginResponse});
  final dynamic loginResponse;

  @override
  ConsumerState<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends ConsumerState<BankScreen> {
  List<dynamic> bankLists = [];
  List<dynamic> fieldMap = [];

  Map<String, dynamic> initialvalues = {
    "BankCode": "",
    "BankAccountNo": "",
    "StartDate": "",
    "EndDate": "",
    "BankType": "",
    "BankAccountStatus": "",
    "ClientID": "",
  };

  TextEditingController searchString = TextEditingController();
  String searchCriteria = "client_id";
  TextEditingController pageNo = TextEditingController();
  int pageSize = 0;
  @override
  void initState() {
    super.initState();
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

  void resetInitialValues() {
    initialvalues.update("BankCode", (value) => "");
    initialvalues.update("BankAccountNo", (value) => "");
    initialvalues.update("StartDate", (value) => "");
    initialvalues.update("EndDate", (value) => "");
    initialvalues.update("BankType", (value) => "");
    initialvalues.update("BankAccountStatus", (value) => "");
    initialvalues.update("ClientID", (value) => "");
  }

  @override
  Widget build(BuildContext context) {
    final authToken =
        ref.read(loginProvider.notifier).prefs?.getString("authToken");

    dynamic bankResponse;

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
                          Flexible(
                            child: TextFormField(
                              initialValue: initialvalues["BankType"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "BankType", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("Bank Type"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              initialValue: initialvalues["BankAccountStatus"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "BankAccountStatus", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("Bank Account Status"),
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
                              initialValue: initialvalues["StartDate"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "StartDate", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("Start Date"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              initialValue: initialvalues["EndDate"],
                              onChanged: (value) {
                                initialvalues.update("EndDate", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("End Date"),
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
                              print(bankResp);
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
                  itemBuilder: (context, index) => Dismissible(
                    key: ValueKey(bankLists[index]['ID']),
                    background: Container(
                      color:
                          Theme.of(context).colorScheme.error.withOpacity(0.75),
                      // margin: EdgeInsets.symmetric(
                      //     horizontal:
                      //         Theme.of(context).cardTheme.margin!.horizontal),
                    ),
                    onDismissed: (direction) {
                      deleteBank(bankLists[index]['ID']);
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
                              '${bankLists[index]['ID']}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
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
                            onPressed: () async {
                              bankResponse = await BankService.getBank(
                                  authToken, bankLists[index]['ID']);

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BankEnquiry(
                                    bankResponse: bankResponse["Bank"],
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
