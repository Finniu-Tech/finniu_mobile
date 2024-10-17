import 'package:finniu/app_config.dart';

class ProductionConfig {
  static AppConfig getConfig() {
    return AppConfig(
      apiBaseUrl: 'https://manage.finniu.com/api/v1/graph/finniu/',
      environment: 'production',
    );
  }
}
