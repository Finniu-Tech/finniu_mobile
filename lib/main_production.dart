import 'package:finniu/config_production.dart';
import 'package:finniu/main.dart';

void main() {
  final config = ProductionConfig.getConfig();
  mainCommon(config);
}
