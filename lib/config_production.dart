import 'package:finniu/app_config.dart';

class ProductionConfig {
  static AppConfig getConfig() {
    return AppConfig(
      apiBaseUrl: 'https://manage.finniu.com/api/v1/graph/finniu/',
      notificationsBaseUrl: 'https://j3e8e1fit6.execute-api.us-east-1.amazonaws.com/prod',
      environment: 'production',
    );
  }
}
