import 'package:flutter/material.dart';
import 'package:quotation_flutter/screens/loginScreen/login_screen.dart';
import 'package:quotation_flutter/utils/theme/theme_content.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      theme: ThemeContent.lightThemeData,
      home: const LoginScreen(),
    ),
  );
}
