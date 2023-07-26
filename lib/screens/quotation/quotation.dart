import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/services/quotation_services.dart';
import 'package:quotation_flutter/utils/authUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';

class QuotationScreen extends ConsumerStatefulWidget {
  const QuotationScreen({super.key, required this.loginResponse});
  final Map<String, dynamic> loginResponse;
  @override
  ConsumerState<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends ConsumerState<QuotationScreen> {
  List<dynamic> quotationLists = [];
  @override
  void initState() {
    super.initState();
    getAllQuotation(widget.loginResponse['authToken']);
  }

  Future<void> getAllQuotation(token) async {
    quotationLists = await QuotationServices.getAllQuotation(token);
  }

  @override
  Widget build(BuildContext context) {
    final authToken =
        ref.watch(loginProvider.notifier).prefs?.getString("authToken");

    return Scaffold(
      appBar: CustomAppBar(title: AppUtils.quotationTitle),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppUtils.appLightBackground,
          ),
          alignment: Alignment.center,
          child: ListView.builder(
            itemCount: quotationLists.length,
            itemBuilder: (context, index) => Card(
              borderOnForeground: false,
              shadowColor: Theme.of(context).colorScheme.primary,
              elevation: 10,
              child: ListTile(
                leading: Text(
                  '${quotationLists[index]['ID']}',
                ),
                title: Row(children: [
                  Text(
                    '${quotationLists[index]['QProduct']}',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${quotationLists[index]['QFirstName']}',
                  ),
                ]),
                trailing: Icon(
                  Icons.info,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
