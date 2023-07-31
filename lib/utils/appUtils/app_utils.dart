import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static String quotationTitle = "Quotation App";
  static Color appLightBackground = const Color.fromARGB(255, 219, 245, 243);
  static final appUrl = dotenv.get("APP_URL", fallback: "");

  static String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }
}
