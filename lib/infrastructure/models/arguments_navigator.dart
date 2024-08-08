class ArgumentsNavigator {
  final String uuid;
  final String status;
  final bool isReinvest;
  ArgumentsNavigator({
    required this.uuid,
    required this.status,
    this.isReinvest = false,
  });
}
