import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotation_flutter/providers/authProvider/login_provider.dart';
import 'package:quotation_flutter/screens/homepage/homepage.dart';
import 'package:quotation_flutter/utils/appUtils/app_utils.dart';
import 'package:quotation_flutter/widgets/customAppbar/custom_appbar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
      appBar: CustomAppBar(
        title: AppUtils.quotationTitle,
        isBack: false,
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.onSecondary,
                size: 40,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Sign In",
              style: TextStyle(
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
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  controller: mobileController,
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
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  controller: passwordController,
                  obscuringCharacter: "*",
                  obscureText: isSecure,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.enhanced_encryption),
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor:
                          Theme.of(context).colorScheme.onSecondary),
                  onPressed: () async {
                    final loginResponse = await ref
                        .read(loginProvider.notifier)
                        .login(mobileController.text, passwordController.text);
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WillPopScope(
                            onWillPop: () async {
                              return false;
                            },
                            child: HomePage(
                                loginResponse: loginResponse['message']),
                          ),
                        ),
                      );
                    });
                  },
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
