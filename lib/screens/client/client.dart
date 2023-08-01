import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/screens/client/client_enquiry.dart';
import 'package:quotation_flutter/screens/quotation/quotation_enquiry.dart';
import 'package:quotation_flutter/services/client/client_service.dart';
import 'package:quotation_flutter/services/quotation/quotation_services.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';

class ClientScreen extends ConsumerStatefulWidget {
  const ClientScreen({super.key, required this.loginResponse});
  final dynamic loginResponse;

  @override
  ConsumerState<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends ConsumerState<ClientScreen> {
  List<dynamic> clientLists = [];
  List<dynamic> fieldMap = [];
  TextEditingController searchString = TextEditingController();
  String searchCriteria = "id";
  TextEditingController pageNo = TextEditingController();
  TextEditingController pageSize = TextEditingController();
  @override
  void initState() {
    super.initState();
    getAllClients(widget.loginResponse['authToken'], searchString.text,
        searchCriteria, pageNo.text, pageSize.text);
  }

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
      clientLists = response["All Clients"];
      fieldMap = response["Field Map"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final authToken =
        ref.read(loginProvider.notifier).prefs?.getString("authToken");

    dynamic quotationResponse;
    dynamic clientResponse;

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
                                        pageSize.text);
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
                  itemCount: clientLists.length,
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
                            '${clientLists[index]['ID']}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
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
                          onPressed: () async {
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
