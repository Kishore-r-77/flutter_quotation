import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  TextEditingController searchString = TextEditingController();
  String searchCriteria = "address_line1";
  TextEditingController pageNo = TextEditingController();
  TextEditingController pageSize = TextEditingController();
  @override
  void initState() {
    super.initState();
    getAllAddress(widget.loginResponse['authToken'], searchString.text,
        searchCriteria, pageNo.text, pageSize.text);
  }

  Future<void> getAllAddress(
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

  @override
  Widget build(BuildContext context) {
    final authToken =
        ref.read(loginProvider.notifier).prefs?.getString("authToken");

    dynamic addressResponse;

    return Scaffold(
      floatingActionButton: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_forward,
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
                                        pageSize.text);
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
                  itemBuilder: (context, index) => Card(
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
            ],
          ),
        ),
      ),
    );
  }
}
