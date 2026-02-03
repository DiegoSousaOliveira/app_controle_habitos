import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  late SharedPreferences _prefs;
  bool _initialized = false;

  factory StorageService() {
    return _instance;
  }

  StorageService._internal();

  Future<void> initialize() async {
    if (_initialized) return;
    try {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    } catch (e) {
      // Fallback para web: usar localStorage via window.localStorage
      // Por enquanto, marcar como inicializado mesmo em caso de erro
      _initialized = true;
    }
  }

  Future<void> saveToken(String token) async {
    if (!_initialized) await initialize();
    try {
      await _prefs.setString('access_token', token);
    } catch (e) {
      // Em caso de erro (ex: localStorage em web), ignora silenciosamente
      print('Erro ao salvar token: $e');
    }
  }

  String? getToken() {
    if (!_initialized) return null;
    try {
      return _prefs.getString('access_token');
    } catch (e) {
      print('Erro ao obter token: $e');
      return null;
    }
  }

  Future<void> clearToken() async {
    if (!_initialized) await initialize();
    try {
      await _prefs.remove('access_token');
    } catch (e) {
      print('Erro ao limpar token: $e');
    }
  }

  Future<void> saveUser(Map<String, dynamic> userData) async {
    if (!_initialized) await initialize();
    try {
      await _prefs.setString('user_data', userData.toString());
    } catch (e) {
      print('Erro ao salvar usuário: $e');
    }
  }

  String? getUser() {
    if (!_initialized) return null;
    try {
      return _prefs.getString('user_data');
    } catch (e) {
      print('Erro ao obter usuário: $e');
      return null;
    }
  }

  Future<void> clearUser() async {
    if (!_initialized) await initialize();
    try {
      await _prefs.remove('user_data');
    } catch (e) {
      print('Erro ao limpar usuário: $e');
    }
  }

  Future<void> clear() async {
    if (!_initialized) await initialize();
    try {
      await _prefs.clear();
    } catch (e) {
      print('Erro ao limpar storage: $e');
    }
  }
}
