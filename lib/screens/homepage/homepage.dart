import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quotation_flutter/screens/profile/profile.dart';
import 'package:quotation_flutter/widgets/category/quotation_category.dart';
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

  var selectedPageIndex = 0;
  @override
  void initState() {
    super.initState();
    selectedPageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    Widget getScreens({required int index}) {
      switch (index) {
        case 0:
          return QuotationCategory(loginResponse: widget.loginResponse);

        case 1:
          return Profile(loginResponse: widget.loginResponse);

        default:
          return QuotationCategory(loginResponse: widget.loginResponse);
      }
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: isIntroduction
            ? null
            : CurvedNavigationBar(
                height: 50,
                backgroundColor: Colors.transparent,
                color: Theme.of(context).colorScheme.primary,
                buttonBackgroundColor: Colors.green,
                index: selectedPageIndex,
                onTap: (value) {
                  setState(
                    () {
                      selectedPageIndex = value;
                    },
                  );
                },
                items: const [
                  Icon(
                    Icons.home,
                  ),
                  Icon(
                    Icons.person,
                  ),
                ],
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
            : getScreens(index: selectedPageIndex),
      ),
    );
  }
}
