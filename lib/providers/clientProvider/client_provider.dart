import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientNotifier extends StateNotifier<Map<String, dynamic>> {
  ClientNotifier()
      : super({
          "ClientShortName": "",
          "ClientLongName": "",
          "ClientSurName": "",
          "Gender": "",
          "Salutation": "",
          "Language": "",
          "ClientDob": "",
          "ClientEmail": "",
          "ClientMobile": "",
          "ClientStatus": "",
          "ClientType": "",
          "ClientDod": "",
          "Addresses": []
        });
  bool isAdd = false;
  bool isRemove = false;

  Map<String, dynamic> modal1 = {
    "AddressType": "",
    "AddressLine1": "",
    "AddressLine2": "",
    "AddressLine3": "",
    "AddressLine4": "",
    "AddressLine5": "",
    "AddressPostCode": "",
    "AddressState": "",
    "AddressCountry": "",
    "AddressStartDate": ""
  };
  Map<String, dynamic> modal2 = {
    "AddressType": "",
    "AddressLine1": "",
    "AddressLine2": "",
    "AddressLine3": "",
    "AddressLine4": "",
    "AddressLine5": "",
    "AddressPostCode": "",
    "AddressState": "",
    "AddressCountry": "",
    "AddressStartDate": ""
  };
  Map<String, dynamic> modal3 = {
    "AddressType": "",
    "AddressLine1": "",
    "AddressLine2": "",
    "AddressLine3": "",
    "AddressLine4": "",
    "AddressLine5": "",
    "AddressPostCode": "",
    "AddressState": "",
    "AddressCountry": "",
    "AddressStartDate": ""
  };
  Map<String, dynamic> modal4 = {
    "AddressType": "",
    "AddressLine1": "",
    "AddressLine2": "",
    "AddressLine3": "",
    "AddressLine4": "",
    "AddressLine5": "",
    "AddressPostCode": "",
    "AddressState": "",
    "AddressCountry": "",
    "AddressStartDate": ""
  };
  Map<String, dynamic> modal5 = {
    "AddressType": "",
    "AddressLine1": "",
    "AddressLine2": "",
    "AddressLine3": "",
    "AddressLine4": "",
    "AddressLine5": "",
    "AddressPostCode": "",
    "AddressState": "",
    "AddressCountry": "",
    "AddressStartDate": ""
  };
  // TextEditingController addressIdController = TextEditingController();
  // TextEditingController agencyIdController = TextEditingController();
  // TextEditingController clientIdController = TextEditingController();
  TextEditingController clientDob = TextEditingController();
  TextEditingController addressStartDate = TextEditingController();
}

final clientProvider =
    StateNotifierProvider<ClientNotifier, Map<String, dynamic>>(
        (ref) => ClientNotifier());
