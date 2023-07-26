import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotation_flutter/screens/loginScreen/login_screen.dart';
import 'package:quotation_flutter/utils/theme/theme_content.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeContent.lightThemeData,
        home: const LoginScreen(),
      ),
    ),
  );
}
