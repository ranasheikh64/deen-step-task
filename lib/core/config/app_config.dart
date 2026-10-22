/// Application runtime configuration and environment variables
class AppConfig {
  const AppConfig({
    required this.baseUrl,
    required this.environment,
    this.enableLogging = true,
  });

  final String baseUrl;
  final String environment;
  final bool enableLogging;

  static AppConfig? _instance;

  static AppConfig get instance {
    return _instance ??
        const AppConfig(
          baseUrl: 'https://test.deenstep.com/api/v1',
          environment: 'production',
          enableLogging: true,
        );
  }

  static void initialize({
    required String baseUrl,
    required String environment,
    bool enableLogging = false,
  }) {
    _instance = AppConfig(
      baseUrl: baseUrl,
      environment: environment,
      enableLogging: enableLogging,
    );
  }
}
