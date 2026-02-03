class HabitLog {
  final int? id;
  final int? habitId;
  final DateTime date;
  final bool completed;

  HabitLog({
    this.id,
    this.habitId,
    required this.date,
    required this.completed,
  });

  factory HabitLog.fromJson(Map<String, dynamic> json) {
    return HabitLog(
      id: json['id'],
      habitId: json['habit_id'],
      date: DateTime.parse(json['date']),
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'habit_id': habitId,
      'date': date.toIso8601String(),
      'completed': completed,
    };
  }

  HabitLog copyWith({
    int? id,
    int? habitId,
    DateTime? date,
    bool? completed,
  }) {
    return HabitLog(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      completed: completed ?? this.completed,
    );
  }
}
