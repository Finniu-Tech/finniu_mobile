class ArgumentsNavigator {
  final String uuid;
  final String status;
  final bool isReinvestAvailable;
  final String? actionStatus;
  ArgumentsNavigator({
    required this.uuid,
    required this.status,
    this.isReinvestAvailable = false,
    this.actionStatus,
  });
}
