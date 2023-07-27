import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotation_flutter/services/quotation_services.dart';
import 'package:quotation_flutter/utils/authUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';

class QuotationScreen extends ConsumerStatefulWidget {
  const QuotationScreen({super.key, required this.loginResponse});
  final Map<String, dynamic> loginResponse;

  @override
  ConsumerState<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends ConsumerState<QuotationScreen> {
  List<dynamic> quotationLists = [];
  List<dynamic> fieldMap = [];
  TextEditingController searchString = TextEditingController();
  String searchCriteria = "id";
  TextEditingController pageNo = TextEditingController();
  TextEditingController pageSize = TextEditingController();
  @override
  void initState() {
    super.initState();
    getAllQuotation(widget.loginResponse['authToken'], searchString.text,
        searchCriteria, pageNo.text, pageSize.text);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_forward,
          ),
        ),
      ),
      appBar: CustomAppBar(title: AppUtils.quotationTitle),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppUtils.appLightBackground,
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
                                        widget.loginResponse['authToken'],
                                        searchString.text,
                                        searchCriteria,
                                        pageNo.text,
                                        pageSize.text);
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
                  itemBuilder: (context, index) => Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    borderOnForeground: false,
                    shadowColor: Theme.of(context).colorScheme.primary,
                    elevation: 10,
                    child: ListTile(
                      leading: Text(
                        '${quotationLists[index]['ID']}',
                      ),
                      title: Row(children: [
                        Text(
                          '${quotationLists[index]['QProduct']}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${quotationLists[index]['QFirstName']}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ]),
                      trailing: Icon(
                        Icons.info,
                        color: Theme.of(context).colorScheme.primary,
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
