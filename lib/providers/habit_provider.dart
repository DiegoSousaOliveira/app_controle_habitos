import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../services/habit_service.dart';
import '../utils/api_exceptions.dart';

class HabitProvider extends ChangeNotifier {
  final HabitService _habitService = HabitService();

  List<Habit> _habits = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Habit> get habits => _habits;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadHabits(String token) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      _habits = await _habitService.getHabits(token);
      _setLoading(false);
      notifyListeners();
    } on ApiException catch (e) {
      _errorMessage = e.message;
      _setLoading(false);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> createHabit({
    required String token,
    required String title,
    String? description,
    required String frequency,
    required int points,
    required bool active,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final habit = await _habitService.createHabit(
        token: token,
        title: title,
        description: description,
        frequency: frequency,
        points: points,
        active: active,
      );
      _habits.add(habit);
      _setLoading(false);
      notifyListeners();
    } on ApiException catch (e) {
      _errorMessage = e.message;
      _setLoading(false);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateHabit({
    required String token,
    required int habitId,
    required String title,
    String? description,
    required String frequency,
    required int points,
    required bool active,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final updatedHabit = await _habitService.updateHabit(
        token: token,
        habitId: habitId,
        title: title,
        description: description,
        frequency: frequency,
        points: points,
        active: active,
      );

      final index = _habits.indexWhere((h) => h.id == habitId);
      if (index != -1) {
        _habits[index] = updatedHabit;
      }
      _setLoading(false);
      notifyListeners();
    } on ApiException catch (e) {
      _errorMessage = e.message;
      _setLoading(false);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteHabit({required String token, required int habitId}) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      await _habitService.deleteHabit(token, habitId);
      _habits.removeWhere((h) => h.id == habitId);
      _setLoading(false);
      notifyListeners();
    } on ApiException catch (e) {
      _errorMessage = e.message;
      _setLoading(false);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> logHabitCompletion({
    required String token,
    required int habitId,
    required bool completed,
  }) async {
    try {
      await _habitService.logHabitCompletion(
        token: token,
        habitId: habitId,
        completed: completed,
      );
      // Reload habits to update with latest data
      await loadHabits(token);
    } on ApiException catch (e) {
      _errorMessage = e.message;
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

  void clearHabits() {
    _habits = [];
    _errorMessage = null;
    notifyListeners();
  }
}
