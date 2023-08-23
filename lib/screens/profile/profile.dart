import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.loginResponse});
  final dynamic loginResponse;
  final String logo = "assets/images/futura_logo.png";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image(image: AssetImage(logo))),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "${loginResponse["name"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          // Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(
          //       "Name: ${loginResponse["name"]}",
          //       style: TextStyle(
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold,
          //         color: Theme.of(context).colorScheme.primary,
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 5,
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
          const SizedBox(
            height: 5,
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
          const SizedBox(
            height: 5,
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
