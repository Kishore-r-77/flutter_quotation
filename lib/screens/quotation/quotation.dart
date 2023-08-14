import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/screens/quotation/quotation_enquiry.dart';
import 'package:quotation_flutter/services/quotation/quotation_services.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';
import 'package:quotation_flutter/widgets/quotation/quotation_modal.dart';

class QuotationScreen extends ConsumerStatefulWidget {
  const QuotationScreen({super.key, required this.loginResponse});
  final dynamic loginResponse;

  @override
  ConsumerState<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends ConsumerState<QuotationScreen> {
  List<dynamic> quotationLists = [];
  List<dynamic> fieldMap = [];
  TextEditingController searchString = TextEditingController();
  String searchCriteria = "id";
  TextEditingController pageNo = TextEditingController();
  int pageSize = 0;
  @override
  void initState() {
    super.initState();
    getAllQuotation(
      widget.loginResponse['authToken'],
      searchString.text,
      searchCriteria,
      pageNo.text,
      pageSize,
    );
  }

  Future<void> getAllQuotation(
      token, searchString, searchCriteria, pageNo, pageSize) async {
    final response = await QuotationServices.getAllQuotation(
      token,
      searchString,
      searchCriteria,
      pageNo,
      pageSize,
    );
    setState(() {
      quotationLists = response["All QHeaders"];
      fieldMap = response["Field Map"];
    });
  }

  deleteQuotation(id) async {
    QuotationServices.softDeleteQuotation(
      widget.loginResponse['authToken'],
      id,
    );
    var getData = await QuotationServices.getAllQuotation(
        widget.loginResponse['authToken'],
        searchString.text,
        searchCriteria,
        pageNo.text,
        pageSize);
    setState(() {
      quotationLists = getData["All QHeaders"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final authToken =
        ref.read(loginProvider.notifier).prefs?.getString("authToken");

    dynamic quotationResponse;

    return Scaffold(
      floatingActionButton: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const QuotationModal(),
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
                "Quotation Enquiry",
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
                                    await QuotationServices.getAllQuotation(
                                        authToken,
                                        searchString.text,
                                        searchCriteria,
                                        pageNo.text,
                                        pageSize);
                                setState(() {
                                  quotationLists = response['All QHeaders'];
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
                  itemCount: quotationLists.length,
                  itemBuilder: (context, index) => Slidable(
                    startActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          icon: Icons.delete,
                          label: "Delete",
                          backgroundColor: Theme.of(context).colorScheme.error,
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
                                      deleteQuotation(
                                          quotationLists[index]['ID']);
                                      Navigator.pop(ctx);

                                      ScaffoldMessenger.of(ctx)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(ctx).showSnackBar(
                                        const SnackBar(
                                          content: Text("Quotation Deleted"),
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
                            quotationResponse =
                                await QuotationServices.getQuotation(
                                    authToken, quotationLists[index]['ID']);

                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuotationEnquiry(
                                    quotationResponse:
                                        quotationResponse["QHeader"],
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
                              Text(
                                '${quotationLists[index]['ID']}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${quotationLists[index]['QProduct']}',
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
                                '${quotationLists[index]['QFirstName']}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${quotationLists[index]['QOccupation']}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          trailing: Icon(
                            Icons.swipe,
                            color: Theme.of(context).colorScheme.primary,
                          )),
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
