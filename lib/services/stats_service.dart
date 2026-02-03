import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../models/user_stats.dart';
import '../utils/api_exceptions.dart';

class StatsService {
  late Dio _dio;

  StatsService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.fullApiUrl,
        connectTimeout: AppConfig.connectionTimeout,
        receiveTimeout: AppConfig.apiTimeout,
        contentType: Headers.jsonContentType,
      ),
    );
  }

  Future<UserStats> getMyStats(String token) async {
    try {
      ApiLogger.logRequest('GET', '/stats/me');

      _dio.options.headers['Authorization'] = 'Bearer $token';
      
      final response = await _dio.get('/stats/me');

      ApiLogger.logResponse('/stats/me', response.statusCode ?? 0, response.data);
      return UserStats.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = _handleDioException(e);
      ApiLogger.logError('/stats/me', errorMessage);
      throw ApiException(
        message: errorMessage,
        statusCode: e.response?.statusCode,
        originalException: e,
      );
    }
  }

  Future<UserStats> getUserStats(String token, int userId) async {
    try {
      ApiLogger.logRequest('GET', '/stats/$userId');

      _dio.options.headers['Authorization'] = 'Bearer $token';
      
      final response = await _dio.get('/stats/$userId');

      ApiLogger.logResponse('/stats/$userId', response.statusCode ?? 0, response.data);
      return UserStats.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = _handleDioException(e);
      ApiLogger.logError('/stats/$userId', errorMessage);
      throw ApiException(
        message: errorMessage,
        statusCode: e.response?.statusCode,
        originalException: e,
      );
    }
  }

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  String _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Tempo de conexão expirado';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return 'Tempo de resposta expirado';
    } else if (e.response != null) {
      final data = e.response?.data;
      if (data is Map && data.containsKey('detail')) {
        return data['detail'];
      }
      return data.toString();
    } else if (e.type == DioExceptionType.unknown) {
      return 'Erro de conexão. Verifique sua internet.';
    }
    return e.message ?? 'Erro desconhecido';
  }
}
