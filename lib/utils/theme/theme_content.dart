import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeContent {
  static final ThemeData lightThemeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.light,
      background: const Color.fromARGB(255, 223, 253, 250),
    ),
    textTheme: GoogleFonts.latoTextTheme(),
  );

  static final ThemeData darkThemeData = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 131, 57, 0),
      onBackground: const Color.fromARGB(90, 131, 57, 0),
      brightness: Brightness.dark,
    ),
    textTheme: GoogleFonts.latoTextTheme(),
  );
}
