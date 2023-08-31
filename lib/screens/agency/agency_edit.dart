import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quotation_flutter/services/agency/agency_service.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';

class AgencyEdit extends StatefulWidget {
  const AgencyEdit({
    super.key,
    required this.agencyRecord,
    required this.authToken,
    required this.companyId,
    required this.languageId,
    required this.loginResponse,
  });

  final dynamic agencyRecord;
  final dynamic loginResponse;
  final String? authToken;
  final dynamic companyId;
  final dynamic languageId;

  @override
  State<AgencyEdit> createState() => _AgencyEditState();
}

class _AgencyEditState extends State<AgencyEdit> {
  TextEditingController searchString = TextEditingController();
  String searchCriteria = "agency_channel_id";
  TextEditingController pageNo = TextEditingController();
  int pageSize = 0;

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

  @override
  Widget build(BuildContext context) {
    TextEditingController LSDate = TextEditingController();
    LSDate.text = AppUtils.formatDate(widget.agencyRecord["LicenseStartDate"]);

    TextEditingController LEDate = TextEditingController();
    LEDate.text = AppUtils.formatDate(widget.agencyRecord["LicenseEndDate"]);

    TextEditingController StartDate = TextEditingController();
    StartDate.text = AppUtils.formatDate(widget.agencyRecord["Startdate"]);

    TextEditingController EndDate = TextEditingController();
    EndDate.text = AppUtils.formatDate(widget.agencyRecord["EndDate"]);

    return Scaffold(
      appBar: const CustomAppBar(title: "Agency Edit", isBack: false),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Flexible(
              child: TextFormField(
                initialValue: widget.agencyRecord["AgencyChannelSt"],
                onChanged: (value) {
                  widget.agencyRecord.update("AgencyChannelSt", (val) => value);
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
              height: 20,
            ),
            Flexible(
              child: TextFormField(
                initialValue: widget.agencyRecord["Office"],
                onChanged: (value) {
                  widget.agencyRecord.update("Office", (val) => value);
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
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: TextFormField(
                initialValue: widget.agencyRecord["AgencySt"],
                onChanged: (value) {
                  widget.agencyRecord.update("AgencySt", (val) => value);
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
              height: 20,
            ),
            Flexible(
              child: TextFormField(
                initialValue: widget.agencyRecord["Aadhar"],
                onChanged: (value) {
                  widget.agencyRecord.update("Aadhar", (val) => value);
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
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: TextFormField(
                initialValue: widget.agencyRecord["Pan"],
                onChanged: (value) {
                  widget.agencyRecord.update("Pan", (val) => value);
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
              height: 20,
            ),
            Flexible(
              child: TextFormField(
                initialValue: widget.agencyRecord["LicenseNo"],
                onChanged: (value) {
                  widget.agencyRecord.update("LicenseNo", (val) => value);
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
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: TextFormField(
                controller: LSDate,
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today_rounded),
                  labelText: "License Start Date",
                ),
                onTap: () async {
                  DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now());
                  if (pickeddate != null) {
                    setState(() {
                      LSDate.text = DateFormat('dd-MM-yyyy').format(pickeddate);
                      widget.agencyRecord.update("LicenseStartDate",
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
                controller: LEDate,
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today_rounded),
                  labelText: "License End Date",
                ),
                onTap: () async {
                  DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now());
                  if (pickeddate != null) {
                    setState(() {
                      LEDate.text = DateFormat('dd-MM-yyyy').format(pickeddate);
                      widget.agencyRecord.update("LicenseEndDate",
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
                controller: StartDate,
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
                      StartDate.text =
                          DateFormat('dd-MM-yyyy').format(pickeddate);
                      widget.agencyRecord.update("Startdate",
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
                controller: EndDate,
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today_rounded),
                  labelText: "End Date",
                ),
                onTap: () async {
                  DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now());
                  if (pickeddate != null) {
                    setState(() {
                      EndDate.text =
                          DateFormat('dd-MM-yyyy').format(pickeddate);
                      widget.agencyRecord.update("EndDate",
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
                initialValue: widget.agencyRecord["TerminationReason"],
                onChanged: (value) {
                  widget.agencyRecord
                      .update("TerminationReason", (val) => value);
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
              height: 20,
            ),
            Flexible(
              child: TextFormField(
                initialValue: widget.agencyRecord["ClientID"].toString(),
                enabled: false,
                onChanged: (value) {
                  widget.agencyRecord.update("ClientID", (val) => value);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  label: Text("ClientID"),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: TextFormField(
                initialValue: widget.agencyRecord["BankID"].toString(),
                enabled: false,
                onChanged: (value) {
                  widget.agencyRecord.update("BankID", (val) => value);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  label: Text("BankID"),
                ),
              ),
            ),
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
                    await AgencyService.editAgency(widget.authToken,
                        widget.companyId, widget.agencyRecord);
                    final agencyResp = await AgencyService.getAllAgency(
                      widget.loginResponse['authToken'],
                      searchString.text,
                      searchCriteria,
                      pageNo.text,
                      pageSize,
                    );
                    setState(() {
                      Navigator.pop(context, agencyResp["All Agencies"]);
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
