import 'package:intl/intl.dart';



double calculateDiscount(double price, double discountPercentage) {
  double discountAmount = price * (discountPercentage / 100);
  return price - discountAmount;
}



///Updated formatting method
String formatDate({required String date, String? format}) {
  if (date.isEmpty) return ""; // Return empty string if date is empty

  final String dateFormat = format ?? "dd MMM yy"; // Default format
  DateTime? parsedDate;

  // Try parsing with multiple date formats to handle different date inputs
  try {
    parsedDate = DateTime.parse(date); // ISO 8601 format
  } catch (e) {
    try {
      parsedDate = DateFormat("dd MMM,yyyy").parse(date); // "25 Jul,2023" format
    } catch (e) {
      return date; // Return empty string if parsing fails
    }
  }

  // Format the parsed date
  return DateFormat(dateFormat).format(parsedDate);
}