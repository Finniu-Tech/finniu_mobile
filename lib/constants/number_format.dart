import 'package:intl/intl.dart';

final formatterSoles = NumberFormat.currency(
  locale: 'es_PE',
  symbol: 'S/',
  customPattern: 'S/ #,##0.00',
);
final formatterUSD = NumberFormat.currency(locale: 'en_US', symbol: '\$');
