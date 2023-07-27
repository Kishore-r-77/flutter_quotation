import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';
import 'package:quotation_flutter/widgets/mainDrawer/main_drawer.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key, required this.loginResponse});

  static const String routeName = 'home';
  final dynamic loginResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final companyId = ref.watch(authProvider.notifier).companyId;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        drawer: MainDrawer(loginResponse: loginResponse),
        appBar: const CustomAppBar(title: "Quotation App"),
        body: Container(
          decoration: const BoxDecoration(),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  "Home Page",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
