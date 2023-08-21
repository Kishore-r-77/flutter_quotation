import 'package:flutter/material.dart';

class ClientEdit extends StatefulWidget {
  const ClientEdit(
      {super.key, required this.clientRecord, required this.authToken});

  final dynamic clientRecord;
  final String? authToken;

  @override
  State<ClientEdit> createState() => _ClientEditState();
}

class _ClientEditState extends State<ClientEdit> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
