import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotation_flutter/utils/authUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSecure = true;
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    mobileController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppUtils.quotationTitle),
      body: Container(
        margin: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppUtils.appLightBackground,
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).colorScheme.background,
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
                size: 40,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Sign In",
              style: GoogleFonts.lato(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.phone_android),
                      alignLabelWithHint: true,
                      label: Text("Mobile Number"),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscuringCharacter: "*",
                  obscureText: isSecure,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone_android),
                    alignLabelWithHint: true,
                    label: const Text("Password"),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(
                          () {
                            isSecure = !isSecure;
                          },
                        );
                      },
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Sign In"),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
