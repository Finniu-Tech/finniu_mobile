import 'app_config.dart';

class StagingConfig {
  static AppConfig getConfig() {
    return AppConfig(
      apiBaseUrl: 'https://qa.finniu.com/api/v1/graph/finniu/',
      notificationsBaseUrl: 'https://3o1c0pghj5.execute-api.us-east-2.amazonaws.com/dev2',
      environment: 'staging',
    );
  }
}
