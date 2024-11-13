import 'app_config.dart';

class StagingConfig {
  static AppConfig getConfig() {
    return AppConfig(
      apiBaseUrl: 'https://qa.finniu.com/api/v1/graph/finniu/',
      notificationsBaseUrl: 'https://mngr9xtcl0.execute-api.us-east-2.amazonaws.com/dev',
      environment: 'staging',
    );
  }
}
