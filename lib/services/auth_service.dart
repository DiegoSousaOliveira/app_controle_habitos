import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../models/user.dart';
import '../utils/api_exceptions.dart';

class AuthService {
  late Dio _dio;

  AuthService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.fullApiUrl,
        connectTimeout: AppConfig.connectionTimeout,
        receiveTimeout: AppConfig.apiTimeout,
        contentType: Headers.jsonContentType,
      ),
    );
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      ApiLogger.logRequest('POST', '/users/register', {
        'name': name,
        'email': email,
        'password': '***',
      });

      final response = await _dio.post(
        '/users/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      ApiLogger.logResponse('/users/register', response.statusCode ?? 0, response.data);
      return response.data;
    } on DioException catch (e) {
      final errorMessage = _handleDioException(e);
      ApiLogger.logError('/users/register', errorMessage);
      throw ApiException(
        message: errorMessage,
        statusCode: e.response?.statusCode,
        originalException: e,
      );
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      ApiLogger.logRequest('POST', '/users/login', {
        'email': email,
        'password': '***',
      });

      final response = await _dio.post(
        '/users/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      ApiLogger.logResponse('/users/login', response.statusCode ?? 0, response.data);
      return response.data;
    } on DioException catch (e) {
      final errorMessage = _handleDioException(e);
      ApiLogger.logError('/users/login', errorMessage);
      throw ApiException(
        message: errorMessage,
        statusCode: e.response?.statusCode,
        originalException: e,
      );
    }
  }

  Future<User> getCurrentUser(String token) async {
    try {
      ApiLogger.logRequest('GET', '/users/me');

      _dio.options.headers['Authorization'] = 'Bearer $token';
      
      final response = await _dio.get('/users/me');

      ApiLogger.logResponse('/users/me', response.statusCode ?? 0, response.data);
      return User.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = _handleDioException(e);
      ApiLogger.logError('/users/me', errorMessage);
      throw ApiException(
        message: errorMessage,
        statusCode: e.response?.statusCode,
        originalException: e,
      );
    }
  }

  Future<User> updateUser({
    required String token,
    required String name,
    required String email,
  }) async {
    try {
      ApiLogger.logRequest('PUT', '/users/me', {
        'name': name,
        'email': email,
      });

      _dio.options.headers['Authorization'] = 'Bearer $token';
      
      final response = await _dio.put(
        '/users/me',
        data: {
          'name': name,
          'email': email,
        },
      );

      ApiLogger.logResponse('/users/me', response.statusCode ?? 0, response.data);
      return User.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = _handleDioException(e);
      ApiLogger.logError('/users/me', errorMessage);
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

  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
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
