import 'package:logger/logger.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalException;

  ApiException({
    required this.message,
    this.statusCode,
    this.originalException,
  });

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => message;
}

class ApiLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  static void logRequest(String method, String endpoint, [dynamic data]) {
    _logger.i('📤 $method $endpoint\n${data != null ? 'Data: $data' : ''}');
  }

  static void logResponse(String endpoint, int statusCode, dynamic data) {
    _logger.i('📥 $endpoint [$statusCode]\nResponse: $data');
  }

  static void logError(String endpoint, dynamic error) {
    _logger.e('❌ $endpoint\nError: $error');
  }

  static void logDebug(String message) {
    _logger.d('🔍 $message');
  }
}
