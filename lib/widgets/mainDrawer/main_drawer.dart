import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotation_flutter/screens/loginScreen/login_screen.dart';
import 'package:quotation_flutter/screens/quotation/quotation.dart';

class MainDrawer extends ConsumerStatefulWidget {
  const MainDrawer({super.key, required this.loginResponse});
  final dynamic loginResponse;

  @override
  ConsumerState<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends ConsumerState<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.work,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 18),
                Text(
                  'Sidebar Menu',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.notes,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Quotation',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 24,
                  ),
            ),
            onTap: () async {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      QuotationScreen(loginResponse: widget.loginResponse),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              'Logout',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
