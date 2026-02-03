import 'package:flutter/material.dart';
import '../models/user_stats.dart';
import '../services/stats_service.dart';
import '../utils/api_exceptions.dart';

class StatsProvider extends ChangeNotifier {
  final StatsService _statsService = StatsService();

  UserStats? _stats;
  bool _isLoading = false;
  String? _errorMessage;

  UserStats? get stats => _stats;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadStats(String token) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      _stats = await _statsService.getMyStats(token);
      _setLoading(false);
      notifyListeners();
    } on ApiException catch (e) {
      _errorMessage = e.message;
      _setLoading(false);
      notifyListeners();
      rethrow;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearStats() {
    _stats = null;
    _errorMessage = null;
    notifyListeners();
  }
}
