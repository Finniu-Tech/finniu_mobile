import 'package:finniu/config_staging.dart';
import 'package:finniu/main.dart';

void main() {
  final config = StagingConfig.getConfig();
  mainCommon(config);
}
