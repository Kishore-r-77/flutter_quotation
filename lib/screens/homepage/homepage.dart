import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quotation_flutter/screens/address/address.dart';
import 'package:quotation_flutter/screens/agency/agency.dart';
import 'package:quotation_flutter/screens/bank/bank.dart';
import 'package:quotation_flutter/screens/client/client.dart';
import 'package:quotation_flutter/screens/profile/profile.dart';
import 'package:quotation_flutter/screens/quotation/quotation.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';
import 'package:quotation_flutter/widgets/mainDrawer/main_drawer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.loginResponse});

  static const String routeName = 'home';
  final dynamic loginResponse;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isIntroduction = true;

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        decoration: PageDecoration(
          bodyTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
          ),
          titleTextStyle: TextStyle(
            color: Theme.of(context).copyWith().colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        image: Image.asset(
          "assets/images/insurance.jpeg",
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        title: "FuturaInsTech",
        body:
            "FuturaInsTech is a product company formed by a team of Insurance IT professionals having a collective experience of over 120 person years. This experience has endowed FuturaInsTech a very deep understanding of the Insurance business across different geographies. The team has extensive hands on experience in successfully completing IT, Insurance Transformation, Migration, System Integration,Business Process Re-engineering projects, implementing and maintaining Insurance applications built on legacy and modern technologies. FuturaInsTech’s solutions include Products and Services for insurance companies to help them focus on their core business while keeping the Cost of Ownership at minimum. ",
      ),
      PageViewModel(
        decoration: PageDecoration(
          bodyTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
          ),
          titleTextStyle: TextStyle(
            color: Theme.of(context).copyWith().colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        image: Image.asset(
          "assets/images/technologies.jpeg",
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        title: "Technologies",
        body:
            "Having the core technology expertise we provide hassle-free Migration, Transformation and Business Process Re-engineering services to insurance companies to achieve their business objectives",
      ),
      PageViewModel(
        decoration: PageDecoration(
          bodyTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
          ),
          titleTextStyle: TextStyle(
            color: Theme.of(context).copyWith().colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        image: Image.asset(
          "assets/images/planning_and_consulting.jpeg",
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        title: "Planning and Consulting",
        body:
            "We provide support to insurance companies in planning and implementing Product configuration, modernization of legacy applications, Technical and Business Solutions, and Post Production services ",
      ),
      PageViewModel(
        decoration: PageDecoration(
          bodyTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
          ),
          titleTextStyle: TextStyle(
            color: Theme.of(context).copyWith().colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        image: Image.asset(
          "assets/images/colloboration.jpeg",
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        title: "Collaboration",
        body:
            "Bridging Insurance and Product Software companies in the areas of Migration of data from legacy system to target system, Product Configuration, UAT support and Product implementation",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var selectedPageIndex = 0;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: StatefulBuilder(
          builder: (context, setState) => BottomNavigationBar(
            currentIndex: selectedPageIndex,
            onTap: (value) {
              setState(
                () {
                  selectedPageIndex = value;
                  if (value == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile(
                          loginResponse: widget.loginResponse,
                        ),
                      ),
                    );
                  } else if (value == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          loginResponse: widget.loginResponse,
                        ),
                      ),
                    );
                  }
                },
              );
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
        drawer: MainDrawer(loginResponse: widget.loginResponse),
        appBar: const CustomAppBar(
          title: "Quotation App",
          isBack: true,
        ),
        body: isIntroduction
            ? IntroductionScreen(
                pages: getPages(),
                done: const Text("Done"),
                onDone: () {
                  setState(() {
                    isIntroduction = false;
                  });
                },
                skip: const Text("Skip"),
                onSkip: () {
                  setState(() {
                    isIntroduction = false;
                  });
                },
                showSkipButton: true,
                showNextButton: false,
              )
            : Container(
                height: double.infinity,
                width: double.infinity,
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Welcome ${widget.loginResponse["name"]}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
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
                                      loginResponse: widget.loginResponse,
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      Icon(
                                        Icons.location_city,
                                        size: 60,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                      loginResponse: widget.loginResponse,
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                      loginResponse: widget.loginResponse,
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      Icon(
                                        Icons.account_balance,
                                        size: 60,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                      loginResponse: widget.loginResponse,
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      Icon(
                                        Icons.people,
                                        size: 60,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                      loginResponse: widget.loginResponse,
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      Icon(
                                        Icons.notes,
                                        size: 60,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                      loginResponse: widget.loginResponse,
                                    ),
                                  ),
                                );
                              },
                              splashColor: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/futura_logo.png"),
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
              ),
      ),
    );
  }
}
