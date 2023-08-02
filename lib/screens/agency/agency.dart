import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
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
  Map<String, dynamic> initialvalues = {
    "AgencyChannelSt": "",
    "Office": "",
    "AgencySt": "",
    "LicenseNo": "",
    "LicenseStartDate": "",
    "LicenseEndDate": "",
    "Startdate": "",
    "EndDate": "",
    "TerminationReason": "",
    "Aadhar": "",
    "Pan": "",
    "ClientID": "",
    "AddressID": "",
    "BankID": "",
  };

  TextEditingController searchString = TextEditingController();
  String searchCriteria = "agency_channel_id";
  TextEditingController pageNo = TextEditingController();
  int pageSize = 0;
  @override
  void initState() {
    super.initState();
    getAllAgency(widget.loginResponse['authToken'], searchString.text,
        searchCriteria, pageNo.text, pageSize);
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

    void resetInitialValues() {
      initialvalues.update("AgencyChannelSt", (value) => "");
      initialvalues.update("Office", (value) => "");
      initialvalues.update("AgencySt", (value) => "");
      initialvalues.update("LicenseNo", (value) => "");
      initialvalues.update("LicenseStartDate", (value) => "");
      initialvalues.update("LicenseEndDate", (value) => "");
      initialvalues.update("Startdate", (value) => "");
      initialvalues.update("EndDate", (value) => "");
      initialvalues.update("TerminationReason", (value) => "");
      initialvalues.update("Aadhar", (value) => "");
      initialvalues.update("Pan", (value) => "");
      initialvalues.update("ClientID", (value) => "");
      initialvalues.update("AddressID", (value) => "");
      initialvalues.update("BankID", (value) => "");
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
                              initialValue: initialvalues["AgencyChannelSt"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "AgencyChannelSt", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("Agency Channel st"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              initialValue: initialvalues["Office"],
                              onChanged: (value) {
                                initialvalues.update("Office", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("Office"),
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
                              initialValue: initialvalues["AgencySt"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "AgencySt", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("Agency St"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              initialValue: initialvalues["Aadhar"],
                              onChanged: (value) {
                                initialvalues.update("Aadhar", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("Aadhar"),
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
                              initialValue: initialvalues["Pan"],
                              onChanged: (value) {
                                initialvalues.update("Pan", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("Pan"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              initialValue: initialvalues["LicenseNo"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "LicenseNo", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("License No"),
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
                              initialValue: initialvalues["LicenseStartDate"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "LicenseStartDate", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("License Start Date"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              initialValue: initialvalues["LicenseEndDate"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "LicenseEndDate", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("License End Date"),
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
                              initialValue: initialvalues["Startdate"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "Startdate", (val) => value);
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
                      Flexible(
                        child: TextFormField(
                          initialValue: initialvalues["TerminationReason"],
                          onChanged: (value) {
                            initialvalues.update(
                                "TerminationReason", (val) => value);
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            label: Text("Termination Reason"),
                          ),
                        ),
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
                          Flexible(
                            child: TextFormField(
                              initialValue: initialvalues["AddressID"],
                              onChanged: (value) {
                                initialvalues.update(
                                    "AddressID", (val) => value);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("Address Id"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                label: Text("Bank Id"),
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
                            onPressed: () {
                              AgencyService.createAgency(
                                  widget.loginResponse['authToken'],
                                  ref
                                      .watch(loginProvider.notifier)
                                      .prefs
                                      ?.getInt('companyId'),
                                  initialvalues);
                              // getAllAgency(
                              //     widget.loginResponse['authToken'],
                              //     searchString.text,
                              //     searchCriteria,
                              //     pageNo.text,
                              //     pageSize.text);
                              // resetInitialValues();
                              // Navigator.pop(context);
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
                                  pageSize,
                                );
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
