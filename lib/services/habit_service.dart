import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../models/habit.dart';
import '../utils/api_exceptions.dart';

class HabitService {
  late Dio _dio;

  HabitService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.fullApiUrl,
        connectTimeout: AppConfig.connectionTimeout,
        receiveTimeout: AppConfig.apiTimeout,
        contentType: Headers.jsonContentType,
      ),
    );
  }

  Future<List<Habit>> getHabits(String token) async {
    try {
      ApiLogger.logRequest('GET', '/habits');

      _dio.options.headers['Authorization'] = 'Bearer $token';
      
      final response = await _dio.get('/habits');

      ApiLogger.logResponse('/habits', response.statusCode ?? 0, response.data);
      
      final List<dynamic> data = response.data;
      return data.map((habit) => Habit.fromJson(habit)).toList();
    } on DioException catch (e) {
      final errorMessage = _handleDioException(e);
      ApiLogger.logError('/habits', errorMessage);
      throw ApiException(
        message: errorMessage,
        statusCode: e.response?.statusCode,
        originalException: e,
      );
    }
  }

  Future<Habit> createHabit({
    required String token,
    required String title,
    String? description,
    required String frequency,
    required int points,
    required bool active,
  }) async {
    try {
      ApiLogger.logRequest('POST', '/habits', {
        'title': title,
        'description': description,
        'frequency': frequency,
        'points': points,
        'active': active,
      });

      _dio.options.headers['Authorization'] = 'Bearer $token';
      
      final response = await _dio.post(
        '/habits',
        data: {
          'title': title,
          'description': description,
          'frequency': frequency,
          'points': points,
          'active': active,
        },
      );

      ApiLogger.logResponse('/habits', response.statusCode ?? 0, response.data);
      return Habit.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = _handleDioException(e);
      ApiLogger.logError('/habits', errorMessage);
      throw ApiException(
        message: errorMessage,
        statusCode: e.response?.statusCode,
        originalException: e,
      );
    }
  }

  Future<Habit> getHabitDetail(String token, int habitId) async {
    try {
      ApiLogger.logRequest('GET', '/habits/$habitId');

      _dio.options.headers['Authorization'] = 'Bearer $token';
      
      final response = await _dio.get('/habits/$habitId');

      ApiLogger.logResponse('/habits/$habitId', response.statusCode ?? 0, response.data);
      return Habit.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = _handleDioException(e);
      ApiLogger.logError('/habits/$habitId', errorMessage);
      throw ApiException(
        message: errorMessage,
        statusCode: e.response?.statusCode,
        originalException: e,
      );
    }
  }

  Future<Habit> updateHabit({
    required String token,
    required int habitId,
    required String title,
    String? description,
    required String frequency,
    required int points,
    required bool active,
  }) async {
    try {
      ApiLogger.logRequest('PUT', '/habits/$habitId', {
        'title': title,
        'description': description,
        'frequency': frequency,
        'points': points,
        'active': active,
      });

      _dio.options.headers['Authorization'] = 'Bearer $token';
      
      final response = await _dio.put(
        '/habits/$habitId',
        data: {
          'title': title,
          'description': description,
          'frequency': frequency,
          'points': points,
          'active': active,
        },
      );

      ApiLogger.logResponse('/habits/$habitId', response.statusCode ?? 0, response.data);
      return Habit.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = _handleDioException(e);
      ApiLogger.logError('/habits/$habitId', errorMessage);
      throw ApiException(
        message: errorMessage,
        statusCode: e.response?.statusCode,
        originalException: e,
      );
    }
  }

  Future<void> deleteHabit(String token, int habitId) async {
    try {
      ApiLogger.logRequest('DELETE', '/habits/$habitId');

      _dio.options.headers['Authorization'] = 'Bearer $token';
      
      await _dio.delete('/habits/$habitId');

      ApiLogger.logResponse('/habits/$habitId', 204, 'Deleted');
    } on DioException catch (e) {
      final errorMessage = _handleDioException(e);
      ApiLogger.logError('/habits/$habitId', errorMessage);
      throw ApiException(
        message: errorMessage,
        statusCode: e.response?.statusCode,
        originalException: e,
      );
    }
  }

  Future<void> logHabitCompletion({
    required String token,
    required int habitId,
    required bool completed,
  }) async {
    try {
      ApiLogger.logRequest('POST', '/habits/$habitId/logs', {
        'completed': completed,
      });

      _dio.options.headers['Authorization'] = 'Bearer $token';
      
      await _dio.post(
        '/habits/$habitId/logs',
        data: {
          'completed': completed,
        },
      );

      ApiLogger.logResponse('/habits/$habitId/logs', 201, 'Log created');
    } on DioException catch (e) {
      final errorMessage = _handleDioException(e);
      ApiLogger.logError('/habits/$habitId/logs', errorMessage);
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
