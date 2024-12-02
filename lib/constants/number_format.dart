import 'package:intl/intl.dart';

final formatterSoles =
    NumberFormat.currency(locale: 'en_US', symbol: 'S/', decimalDigits: 2);
final formatterUSD =
    NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);
final formatterSolesNotComma =
    NumberFormat.currency(locale: 'en_US', symbol: 'S/', decimalDigits: 0);
final formatterUSDNotComma =
    NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 0);

String formatDate(String date) {
  try {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate =
        "${parsedDate.year}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.day.toString().padLeft(2, '0')}";

    return formattedDate;
  } catch (e) {
    return "";
  }
}

String getMaskedNumber(String? number) {
  if (number != null && number.length >= 3) {
    String visible = number.substring(number.length - 3);
    return "**********$visible";
  } else {
    return "**********234";
  }
}
