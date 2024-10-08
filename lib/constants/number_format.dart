import 'package:intl/intl.dart';

final formatterSoles =
    NumberFormat.currency(locale: 'en_US', symbol: 'S/', decimalDigits: 2);
final formatterUSD =
    NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);
final formatterSolesNotComma =
    NumberFormat.currency(locale: 'en_US', symbol: 'S/', decimalDigits: 0);
final formatterUSDNotComma =
    NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 0);
