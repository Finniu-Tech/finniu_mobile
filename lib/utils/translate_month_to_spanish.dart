String translateMonthToSpanish(String date) {
  Map<String, String> months = {
    'January': 'Enero',
    'February': 'Febrero',
    'March': 'Marzo',
    'April': 'Abril',
    'May': 'Mayo',
    'June': 'Junio',
    'July': 'Julio',
    'August': 'Agosto',
    'September': 'Septiembre',
    'October': 'Octubre',
    'November': 'Noviembre',
    'December': 'Diciembre',
  };

  months.forEach((key, value) {
    date = date.replaceAll(key, value);
  });

  return date;
}
