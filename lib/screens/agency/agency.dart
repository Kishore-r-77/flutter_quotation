import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/screens/address/address_enquiry.dart';
import 'package:quotation_flutter/screens/agency/agency_enquiry.dart';
import 'package:quotation_flutter/services/agency/agency_service.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';

class AgencyScreen extends ConsumerStatefulWidget {
  const AgencyScreen({super.key, required this.loginResponse});
  final dynamic loginResponse;

  @override
  ConsumerState<AgencyScreen> createState() => _AgencyScreenState();
}

class _AgencyScreenState extends ConsumerState<AgencyScreen> {
  List<dynamic> agencyLists = [];
  List<dynamic> fieldMap = [];
  TextEditingController searchString = TextEditingController();
  String searchCriteria = "agency_channel_id";
  TextEditingController pageNo = TextEditingController();
  TextEditingController pageSize = TextEditingController();
  @override
  void initState() {
    super.initState();
    getAllAgency(widget.loginResponse['authToken'], searchString.text,
        searchCriteria, pageNo.text, pageSize.text);
  }

  Future<void> getAllAgency(
      token, searchString, searchCriteria, pageNo, pageSize) async {
    final response = await AgencyService.getAllAgency(
      token,
      searchString,
      searchCriteria,
      pageNo,
      pageSize,
    );
    setState(() {
      agencyLists = response["All Agencies"];
      fieldMap = response["Field Map"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final authToken =
        ref.read(loginProvider.notifier).prefs?.getString("authToken");

    dynamic agencyResponse;

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
                "Agency Enquiry",
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
                                var response = await AgencyService.getAllAgency(
                                    authToken,
                                    searchString.text,
                                    searchCriteria,
                                    pageNo.text,
                                    pageSize.text);
                                setState(() {
                                  agencyLists = response['All Agencies'];
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
                  itemCount: agencyLists.length,
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
                            '${agencyLists[index]['ID']}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${agencyLists[index]['AgencyChannelSt']}',
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
                            '${agencyLists[index]['Office']}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${agencyLists[index]['AgencySt']}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                          onPressed: () async {
                            agencyResponse = await AgencyService.getAgency(
                                authToken, agencyLists[index]['ID']);

                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AgencyEnquiry(
                                    agencyResponse: agencyResponse["Agency"],
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
