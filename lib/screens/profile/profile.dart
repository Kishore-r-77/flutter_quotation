import 'package:flutter/material.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.loginResponse});
  final dynamic loginResponse;
  final String logo = "assets/images/peakpx.gif";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Profile",
        isBack: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(image: AssetImage(logo))),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Name: ${loginResponse["name"]}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Email: ${loginResponse["email"]}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "phone: ${loginResponse["phone"]}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Company Name: ${loginResponse["companyName"]}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
