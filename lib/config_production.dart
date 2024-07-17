import 'package:finniu/app_config.dart';

class ProductionConfig {
  static AppConfig getConfig() {
    return AppConfig(
      apiBaseUrl: 'https://www.finniu.com/api/v1/graph/finniu/',
      environment: 'production',
    );
  }
}
