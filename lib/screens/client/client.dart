import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/screens/client/client_edit.dart';
import 'package:quotation_flutter/providers/darkProvider/dark_provider.dart';
import 'package:quotation_flutter/screens/client/client_enquiry.dart';
import 'package:quotation_flutter/services/client/client_service.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/client/client_address_modal.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';
import 'package:quotation_flutter/widgets/mainDrawer/main_drawer.dart';

//Client Screen
class ClientScreen extends ConsumerStatefulWidget {
  const ClientScreen(
      {super.key, required this.loginResponse, required this.isLookUp});
  final bool isLookUp;
  final dynamic loginResponse;

  @override
  ConsumerState<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends ConsumerState<ClientScreen> {
  final scrollController = ScrollController();
  bool isLoading = false;
  List<dynamic> clientLists = [];
  List<dynamic> fieldMap = [];
  List<dynamic> gender = [];
  List<dynamic> salutations = [];
  List<dynamic> languages = [];
  List<dynamic> clientstatuses = [];
  String selectedValue = 'I';
  String dropdownValue1 = 'F';
  String dropdownValue2 = 'Capt';
  String dropdownValue3 = 'E';
  String dropdownValue4 = 'AC';
  TextEditingController searchString = TextEditingController();
  String searchCriteria = "id";
  TextEditingController pageNo = TextEditingController();
  int pageSize = 0;
  @override
  void initState() {
    super.initState();
    getGender();
    getSalutation();
    getLanguage();
    getClientStatus();
    // scrollController.addListener(_scrollListener);
    getAllClients(
      widget.loginResponse['authToken'],
      searchString.text,
      searchCriteria,
      pageNo.text,
      pageSize,
    );
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
  // void _scrollListener() async {
  //   if (isLoading) return;
  //   if (scrollController.position.pixels ==
  //       scrollController.position.maxScrollExtent) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     pageSize += 1;
  //     await getAllClients(widget.loginResponse['authToken'], searchString.text,
  //         searchCriteria, pageNo.text, pageSize);
  //   }
  // }

  Future<void> getAllClients(
      token, searchString, searchCriteria, pageNo, pageSize) async {
    final response = await ClientService.getAllClients(
      token,
      searchString,
      searchCriteria,
      pageNo,
      pageSize,
    );
    setState(() {
      clientLists = clientLists + response["All Clients"];
      fieldMap = response["Field Map"];
    });
  }

// Delete Function
  deleteService(id) async {
    ClientService.softDeleteClient(
      widget.loginResponse['authToken'],
      id,
    );
    var getData = await ClientService.getAllClients(
        widget.loginResponse['authToken'],
        searchString.text,
        searchCriteria,
        pageNo.text,
        pageSize);
    setState(() {
      clientLists = getData["All Clients"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final authToken =
        ref.read(loginProvider.notifier).prefs?.getString("authToken");
    final isDark = ref.watch(darkProvider);

    dynamic clientResponse;

    return Scaffold(
      drawer: MainDrawer(
        loginResponse: widget.loginResponse,
      ),
      floatingActionButton: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) =>
                    ClientAddressModal(loginResponse: widget.loginResponse),
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
                "Client Enquiry",
                textAlign: TextAlign.center,
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
                                    await ClientService.getAllClients(
                                        authToken,
                                        searchString.text,
                                        searchCriteria,
                                        pageNo.text,
                                        pageSize);
                                setState(() {
                                  clientLists = response['All Clients'];
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
                  // controller: scrollController,
                  itemCount:
                      isLoading ? clientLists.length + 1 : clientLists.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if (widget.isLookUp) {
                        return Navigator.pop(
                            context, clientLists[index]['ID'].toString());
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
                                        deleteService(clientLists[index]['ID']);
                                        Navigator.pop(ctx);

                                        ScaffoldMessenger.of(ctx)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(ctx).showSnackBar(
                                          const SnackBar(
                                            content: Text("Client Deleted"),
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
                              clientResponse = await ClientService.getClient(
                                  authToken, clientLists[index]['ID']);

                              // ignore: use_build_context_synchronously
                              final resp = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientEdit(
                                    clientRecord: clientResponse["Client"],
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
                                clientLists = resp;
                              });
                            },
                          ),
                          SlidableAction(
                            icon: Icons.info,
                            label: "Info",
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            onPressed: (context) async {
                              clientResponse = await ClientService.getClient(
                                  authToken, clientLists[index]['ID']);

                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientEnquiry(
                                      clientResponse: clientResponse["Client"],
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
                                        deleteService(clientLists[index]['ID']);
                                        Navigator.pop(ctx);

                                        ScaffoldMessenger.of(ctx)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(ctx).showSnackBar(
                                          const SnackBar(
                                            content: Text("Client Deleted"),
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
                              clientResponse = await ClientService.getClient(
                                  authToken, clientLists[index]['ID']);

                              // ignore: use_build_context_synchronously
                              final resp = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientEdit(
                                    clientRecord: clientResponse["Client"],
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
                                clientLists = resp;
                              });
                            },
                          ),
                          SlidableAction(
                            icon: Icons.info,
                            label: "Info",
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            onPressed: (context) async {},
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
                                      deleteService(clientLists[index]['ID']);
                                      Navigator.pop(ctx);

                                      ScaffoldMessenger.of(ctx)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(ctx).showSnackBar(
                                        const SnackBar(
                                          content: Text("Client Deleted"),
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
                                '${clientLists[index]['ID']}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
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
                                  '${clientLists[index]['ClientType']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${clientLists[index]['ClientShortName']}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${clientLists[index]['Gender']}',
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
                                '${clientLists[index]['ClientEmail']}',
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
                            ),
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
