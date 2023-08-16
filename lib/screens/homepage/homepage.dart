import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotation_flutter/screens/address/address.dart';
import 'package:quotation_flutter/screens/agency/agency.dart';
import 'package:quotation_flutter/screens/bank/bank.dart';
import 'package:quotation_flutter/screens/client/client.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';
import 'package:quotation_flutter/widgets/mainDrawer/main_drawer.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key, required this.loginResponse});

  static const String routeName = 'home';
  final dynamic loginResponse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
            ),
          ],
        ),
        drawer: MainDrawer(loginResponse: loginResponse),
        appBar: const CustomAppBar(
          title: "Quotation App",
          isBack: true,
        ),
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
                Expanded(
                  child: GridView(
                    padding: const EdgeInsets.all(24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    children: [
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddressScreen(
                                isLookUp: false,
                                loginResponse: loginResponse,
                              ),
                            ),
                          );
                        },
                        splashColor: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(16),
                              image: const DecorationImage(
                                image: AssetImage(
                                  "assets/images/address-icon-check-sign-approved-260nw-1051293593.webp",
                                ),
                                fit: BoxFit.cover,
                              )
                              // borderRadius: BorderRadius.circular(16),
                              // gradient: LinearGradient(
                              //   colors: [
                              //     Colors.green.withOpacity(0.55),
                              //     Colors.green.withOpacity(0.9),
                              //   ],
                              //   begin: Alignment.topLeft,
                              //   end: Alignment.bottomRight,
                              // ),
                              ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClientScreen(
                                isLookUp: false,
                                loginResponse: loginResponse,
                              ),
                            ),
                          );
                        },
                        splashColor: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(16),
                            image: const DecorationImage(
                                image: AssetImage(
                                  "assets/images/clients-sign-icon-group-people-260nw-404234248.webp",
                                ),
                                fit: BoxFit.cover),
                            // borderRadius: BorderRadius.circular(16),
                            // gradient: LinearGradient(
                            //   colors: [
                            //     Colors.pink.withOpacity(0.55),
                            //     Colors.pink.withOpacity(0.9),
                            //   ],
                            //   begin: Alignment.topLeft,
                            //   end: Alignment.bottomRight,
                            // ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BankScreen(
                                isLookUp: false,
                                loginResponse: loginResponse,
                              ),
                            ),
                          );
                        },
                        splashColor: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(16),
                            image: const DecorationImage(
                              image: AssetImage(
                                "assets/images/png-transparent-bank-logo-bank-saving-bank-pic-building-structure-bank.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                            // borderRadius: BorderRadius.circular(16),
                            // gradient: LinearGradient(
                            //   colors: [
                            //     Colors.purple.withOpacity(0.55),
                            //     Colors.purple.withOpacity(0.9),
                            //   ],
                            //   begin: Alignment.topLeft,
                            //   end: Alignment.bottomRight,
                            // ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AgencyScreen(
                                isLookUp: false,
                                loginResponse: loginResponse,
                              ),
                            ),
                          );
                        },
                        splashColor: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(16),
                            image: const DecorationImage(
                              image: AssetImage(
                                "assets/images/the-agency-logo.gif",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
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
