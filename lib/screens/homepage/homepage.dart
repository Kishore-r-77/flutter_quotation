import 'package:flutter/material.dart';
import 'package:quotation_flutter/utils/authUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppUtils.quotationTitle),
      body: Container(
        decoration: BoxDecoration(
          color: AppUtils.appLightBackground,
        ),
        alignment: Alignment.center,
        child: const Text("Hello"),
      ),
    );
  }
}
