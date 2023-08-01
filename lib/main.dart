import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotation_flutter/providers/darkProvider/dark_provider.dart';
import 'package:quotation_flutter/screens/loginScreen/login_screen.dart';
import 'package:quotation_flutter/utils/theme/theme_content.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(darkProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? ThemeContent.darkThemeData : ThemeContent.lightThemeData,
      home: const LoginScreen(),
    );
  }
}
