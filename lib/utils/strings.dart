bool exists(String? value) {
  return value != null && value.isNotEmpty;
}

num getNumberFromString(String? item) {
  if (item != null) {
    return num.parse(
      item.replaceAll(
        RegExp(r'[^\d.]'),
        '',
      ),
    );
    // return num.parse(item.split(' ')[0]);
  }
  return 0;
}
