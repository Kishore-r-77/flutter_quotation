import 'package:flutter/material.dart';
import 'package:quotation_flutter/screens/address/address.dart';
import 'package:quotation_flutter/screens/agency/agency.dart';
import 'package:quotation_flutter/screens/bank/bank.dart';
import 'package:quotation_flutter/screens/client/client.dart';
import 'package:quotation_flutter/screens/quotation/quotation.dart';

class QuotationCategory extends StatelessWidget {
  const QuotationCategory({
    super.key,
    required this.loginResponse,
  });

  final dynamic loginResponse;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Welcome ${loginResponse["name"]}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: GridView(
                padding: const EdgeInsets.all(24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    child: Card(
                      elevation: 12,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Address",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Expanded(
                              child: Icon(
                                Icons.location_city,
                                size: 60,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          ],
                        ),
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
                    child: Card(
                      elevation: 12,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Client",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Expanded(
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          ],
                        ),
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
                    child: Card(
                      elevation: 12,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Bank",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Expanded(
                              child: Icon(
                                Icons.account_balance,
                                size: 60,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          ],
                        ),
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
                    child: Card(
                      elevation: 12,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Agency",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Expanded(
                              child: Icon(
                                Icons.people,
                                size: 60,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuotationScreen(
                            loginResponse: loginResponse,
                          ),
                        ),
                      );
                    },
                    splashColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16),
                    child: Card(
                      elevation: 12,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Quotation",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Expanded(
                              child: Icon(
                                Icons.notes,
                                size: 60,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
