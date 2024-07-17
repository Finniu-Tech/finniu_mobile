import 'app_config.dart';

class StagingConfig {
  static AppConfig getConfig() {
    return AppConfig(
      apiBaseUrl: 'https://qa.finniu.com/api/v1/graph/finniu/',
      environment: 'staging',
    );
  }
}
