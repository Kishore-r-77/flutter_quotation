import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static String quotationTitle = "Quotation App";
  static Color appLightBackground = const Color.fromARGB(255, 219, 245, 243);

  static String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }
}
