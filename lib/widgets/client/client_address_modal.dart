import 'package:flutter/material.dart';
import 'package:quotation_flutter/widgets/client/addresses_modal1.dart';
import 'package:quotation_flutter/widgets/client/addresses_modal2.dart';
import 'package:quotation_flutter/widgets/client/addresses_modal3.dart';
import 'package:quotation_flutter/widgets/client/addresses_modal4.dart';
import 'package:quotation_flutter/widgets/client/addresses_modal5.dart';
import 'package:quotation_flutter/widgets/client/client_add_modal.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';

class ClientAddressModal extends StatefulWidget {
  const ClientAddressModal({super.key, required this.loginResponse});

  final dynamic loginResponse;

  @override
  State<ClientAddressModal> createState() => _ClientAddressModalState();
}

class _ClientAddressModalState extends State<ClientAddressModal> {
  var controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Quotation Modal", isBack: true),
      body: PageView(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          ClientAddModal(loginResponse: widget.loginResponse),
          AddressesModal1(loginResponse: widget.loginResponse),
          AddressesModal2(loginResponse: widget.loginResponse),
          AddressesModal3(loginResponse: widget.loginResponse),
          AddressesModal4(loginResponse: widget.loginResponse),
          AddressesModal5(loginResponse: widget.loginResponse),
        ],
      ),
    );
  }
}
