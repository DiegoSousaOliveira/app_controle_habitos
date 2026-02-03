class AppConfig {
  static const String apiBaseUrl = 'http://localhost:8000';
  static const String apiVersion = 'v1';
  static const String appVersion = '1.0.0';
  static const String appName = 'Controle de Hábitos';

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 10);

  // Storage Keys
  static const String tokenKey = 'access_token';
  static const String userKey = 'user_data';
  static const String refreshTokenKey = 'refresh_token';

  static Future<void> initialize() async {
    // Aqui você pode adicionar inicializações necessárias
    // Por exemplo, inicializar SharedPreferences, logs, etc.
  }

  static String get fullApiUrl => apiBaseUrl;
}
