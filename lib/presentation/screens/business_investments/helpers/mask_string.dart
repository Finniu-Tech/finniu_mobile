String maskString(String input) {
  if (input.length <= 4) {
    return input;
  }
  String lastFour = input.substring(input.length - 4);
  return lastFour;
}
