enum Environment { dev, staging, prod }

class AppConfig {
  final String appName;
  final String apiBaseUrl;
  final Environment flavor;

  AppConfig({
    required this.appName,
    required this.apiBaseUrl,
    required this.flavor,
  });

  static late AppConfig _instance;

  static AppConfig get instance => _instance;

  static void init({
    required String appName,
    required String apiBaseUrl,
    required Environment flavor,
  }) {
    _instance = AppConfig(
      appName: appName,
      apiBaseUrl: apiBaseUrl,
      flavor: flavor,
    );
  }
}
