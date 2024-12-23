import 'package:intl/intl.dart';

final formatterSoles =
    NumberFormat.currency(locale: 'en_US', symbol: 'S/', decimalDigits: 2);
final formatterUSD =
    NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);
final formatterSolesNotComma =
    NumberFormat.currency(locale: 'en_US', symbol: 'S/', decimalDigits: 0);
final formatterUSDNotComma =
    NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 0);

String formatNumberNotComa({
  required String number,
  required bool isSoles,
}) {
  try {
    final formatter = isSoles ? formatterSolesNotComma : formatterUSDNotComma;
    return formatter.format(double.parse(number));
  } catch (e) {
    return number;
  }
}

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
    return "**********1234";
  }
}

String getMonthName(int month) {
  const monthes = [
    'Ene',
    'Feb',
    'Mar',
    'Abr',
    'May',
    'Jun',
    'Jul',
    'Ago',
    'Sep',
    'Oct',
    'Nov',
    'Dic',
  ];

  if (month < 1 || month > 12) {
    throw ArgumentError('El número del mes debe estar entre 1 y 12.');
  }

  return monthes[month - 1];
}

String getMonthNameComplete(int month) {
  const monthes = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre',
  ];

  if (month < 1 || month > 12) {
    throw ArgumentError('El número del mes debe estar entre 1 y 12.');
  }

  return monthes[month - 1];
}

int convertStringToInt(String value) {
  try {
    double doubleValue = double.parse(value);
    return doubleValue.toInt();
  } catch (e) {
    return 0;
  }
}
