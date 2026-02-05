import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';
import '../utils/api_exceptions.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();

  User? _user;
  String? _token;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _token != null && _user != null;

  Future<void> initialize() async {
    await _storageService.initialize();
    _token = _storageService.getToken();
    if (_token != null) {
      await _loadCurrentUser();
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final response = await _authService.register(
        name: name,
        email: email,
        password: password,
      );

      _token = response['access_token'];
      await _storageService.saveToken(_token!);
      _authService.setAuthToken(_token!);

      // Buscar dados completos do usuário após registro
      await _loadCurrentUser();
    } on ApiException catch (e) {
      _errorMessage = e.message;
      notifyListeners();
      rethrow;
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final response = await _authService.login(
        email: email,
        password: password,
      );

      _token = response['access_token'];
      await _storageService.saveToken(_token!);
      _authService.setAuthToken(_token!);

      await _loadCurrentUser();
    } on ApiException catch (e) {
      _errorMessage = e.message;
      notifyListeners();
      rethrow;
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _token = null;
    _user = null;
    _errorMessage = null;
    await _storageService.clearToken();
    _authService.clearAuthToken();
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    if (_token == null) return;

    try {
      _user = await _authService.getCurrentUser(_token!);
      notifyListeners();
    } on ApiException catch (e) {
      _errorMessage = e.message;
      notifyListeners();
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
  }) async {
    if (_token == null) throw ApiException(message: 'Não autenticado');

    _setLoading(true);
    _errorMessage = null;

    try {
      _user = await _authService.updateUser(
        token: _token!,
        name: name,
        email: email,
      );
      notifyListeners();
    } on ApiException catch (e) {
      _errorMessage = e.message;
      notifyListeners();
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
