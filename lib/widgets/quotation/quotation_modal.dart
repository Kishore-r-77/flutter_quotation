import 'package:flutter/material.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';
import 'package:quotation_flutter/widgets/quotation/qdetails_modal1.dart';
import 'package:quotation_flutter/widgets/quotation/qdetails_modal2.dart';
import 'package:quotation_flutter/widgets/quotation/qdetails_modal3.dart';
import 'package:quotation_flutter/widgets/quotation/qdetails_modal4.dart';
import 'package:quotation_flutter/widgets/quotation/qdetails_modal5.dart';
import 'package:quotation_flutter/widgets/quotation/qheader_modal.dart';

class QuotationModal extends StatefulWidget {
  const QuotationModal({super.key, required this.loginResponse});

  final dynamic loginResponse;

  @override
  State<QuotationModal> createState() => _QuotationModalState();
}

class _QuotationModalState extends State<QuotationModal> {
  var controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Quotation Modal", isBack: true),
      body: PageView(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          QHeaderModal(loginResponse: widget.loginResponse),
          QDetailsModal1(loginResponse: widget.loginResponse),
          QDetailsModal2(loginResponse: widget.loginResponse),
          QDetailsModal3(loginResponse: widget.loginResponse),
          QDetailsModal4(loginResponse: widget.loginResponse),
          QDetailsModal5(loginResponse: widget.loginResponse),
        ],
      ),
    );
  }
}
