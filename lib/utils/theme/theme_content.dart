import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeContent {
  static final ThemeData lightThemeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.light,
      background: const Color.fromARGB(255, 127, 209, 201),
    ),
    textTheme: TextTheme.lerp(
      GoogleFonts.latoTextTheme(),
      GoogleFonts.zillaSlabHighlightTextTheme(),
      40.0,
    ),
  );

  static final ThemeData darkThemeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.amber,
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.latoTextTheme(),
  );
}
