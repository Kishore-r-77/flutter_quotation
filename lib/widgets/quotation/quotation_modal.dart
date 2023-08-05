import 'package:flutter/material.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';
import 'package:quotation_flutter/widgets/quotation/qdetails_modal1.dart';
import 'package:quotation_flutter/widgets/quotation/qdetails_modal2.dart';
import 'package:quotation_flutter/widgets/quotation/qheader_modal.dart';

class QuotationModal extends StatefulWidget {
  const QuotationModal({super.key});

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
        children: const [QHeaderModal(), QDetailsModal1(), QDetailsModal2()],
      ),
    );
  }
}
